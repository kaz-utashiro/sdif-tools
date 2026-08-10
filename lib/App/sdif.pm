package App::sdif;
use v5.14;
use warnings;

use Exporter 'import';
our @EXPORT      = qw(usage);
our %EXPORT_TAGS = ();
our @EXPORT_OK   = qw();

our $VERSION = "4.4802";

use Pod::Usage;

sub usage {
    my $opt = ref($_[0]) eq 'HASH' ? shift : {};
    select STDERR;
    print @_;
    pod2usage(-verbose => 0, -exitval => "NOEXIT");
    print "Version: $VERSION\n";
    exit($opt->{status} // 0);
}

1;

=encoding utf8

=head1 NAME

App::sdif - sdif and family tools, cdif and watchdiff

=head1 SYNOPSIS

    sdif f1 f2

    diff -c f1 f2 | cdif

    git diff | sdif -n

    watchdiff df

=head1 DESCRIPTION

B<sdif-tools> is composed of B<sdif> and related tools including
B<cdif> and B<watchdiff>.

B<sdif> prints diff output in side-by-side format.

B<cdif> adds visual effects to diff output, comparing lines word by
word or character by character.

B<watchdiff> calls a command repeatedly, and prints its output with
visual effects to emphasize the modified part.

See the manual of each command for details.

=head1 INSTALL

    $ cpanm App::sdif

=head1 GIT

These are sample configurations for using the B<sdif> family under
git.  The B<mecab> command has to be installed to use the B<--mecab>
option.

    ~/.gitconfig
        [pager]
            log  = sdif | less
            show = sdif | less
            diff = sdif | less

    ~/.sdifrc
        option default -n --margin=4

    ~/.cdifrc
        option default --mecab

    ~/.profile
        export LESS="-cR"
        export LESSANSIENDCHARS="mK"

Everything can be written in F<~/.gitconfig> instead:

    [pager]
        log  = sdif -n --margin=4 --mecab | env LESSANSIENDCHARS=mK less -cR
        show = sdif -n --margin=4 --mecab | env LESSANSIENDCHARS=mK less -cR
        diff = sdif -n --margin=4 --mecab | env LESSANSIENDCHARS=mK less -cR

=begin html

<p><img width="750" src="https://raw.githubusercontent.com/kaz-utashiro/sdif-tools/master/docs/images/git.jpg"></p>

=end html

=head1 SEE ALSO

L<sdif>, L<cdif>, L<watchdiff>

L<Getopt::EX>

=head1 AUTHOR

Kazumasa Utashiro

=head1 LICENSE

Copyright 1992- Kazumasa Utashiro.

These commands and libraries are free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

=cut

#  LocalWords:  sdif cdif watchdiff diff CPANM cpanm Kaz Utashiro
