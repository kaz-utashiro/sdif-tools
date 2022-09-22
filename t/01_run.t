use strict;
use warnings;
use utf8;
use Test::More;
use File::Spec;

my $lib       = File::Spec->rel2abs('lib');
my $sdif      = File::Spec->rel2abs('script/sdif');
my $cdif      = File::Spec->rel2abs('script/cdif');
my $watchdiff = File::Spec->rel2abs('script/watchdiff');

for my $data (qw(t/DIFF.out t/DIFF-c.out t/DIFF-u.out)) {
    is(sdif('-W160', $data), 0);
    is(cdif($data), 0);
}

is(sdif('--colortable'), 0);

done_testing;

sub sdif      { system($^X, "-I$lib", $sdif, @_) }
sub cdif      { system($^X, "-I$lib", $cdif, @_) }
sub watchdiff { system($^X, "-I$lib", $watchdiff, @_) }
