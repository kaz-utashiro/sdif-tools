use strict;
use warnings;
use Test::More;
use File::Spec;
use Command::Run::Tmpfile;

use_ok 'App::watchdiff';

my $lib       = File::Spec->rel2abs('lib');
my $script    = File::Spec->rel2abs('script');
my $watchdiff = "$script/watchdiff";

$ENV{PATH} .= ":$script";
$ENV{PERL5LIB} .= ":$lib";

# Skip on systems where /dev/fd/N (N>2) is unavailable, e.g. FreeBSD
# without fdescfs mounted.
{
    my $probe = Command::Run::Tmpfile->new;
    my $path  = $probe->path;
    unless (defined $path and -r $path) {
	plan skip_all => 'no /dev/fd or /proc/self/fd path available';
    }
}

sub watchdiff {
    my @command = ($^X, "-I$lib", $watchdiff, @_);
    open my $fh, '-|', @command or die "$watchdiff: $!";
    local $/;
    <$fh>;
}

# strip ANSI escape sequences
sub plain {
    (my $data = shift) =~ s/\e\[[\d;]*[a-zA-Z]//g;
    $data;
}

# The target command must actually be executed and its output shown.
like watchdiff(qw(--plain -r0 --count 1 -- echo hello)),
    qr/hello/, "execute target command";

like watchdiff(qw(--plain -r0 --count 1 -- echo foo bar)),
    qr/foo bar/, "execute target command with arguments";

like watchdiff(qw(--plain -r0 --count 1 -e), 'echo baz'),
    qr/baz/, "execute command given by --exec";

# SYNOPSIS says: watchdiff -e uptime -e iostat -e df
like plain(watchdiff(qw(--plain -r0 --count 1 -e), 'echo AAA', '-e', 'echo BBB')),
    qr/AAA\n\nBBB/, "execute multiple commands given by --exec";

done_testing;
