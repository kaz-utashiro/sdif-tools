=head1 NAME

App::sdif::autocolor::Apple_Terminal

=head1 SYNOPSIS

sdif -Mautocolor::Apple_Terminal

=head1 DESCRIPTION

This is a module for L<sdif(1)> command to set default option
according to terminal background color taken by AppleScript.  Terminal
brightness is caliculated from terminal background RGB values by next
equation.

    Y = 0.30 * R + 0.59 * G + 0.11 * B

When the result is greater than 0.5, set B<--LIGHT-SCREEN> option,
otherwise B<--DARK-SCREEN>.  You can override default setting in your
F<~/.sdifrc>.

=head1 SEE ALSO

L<App::sdif::autocolor>, L<App::sdif::colors>

=cut

package App::sdif::autocolor::Apple_Terminal;

use strict;
use warnings;

use App::sdif::autocolor;

sub brightness {
    my $app = "Terminal";
    my $do = "background color of first window";
    my $bg = qx{osascript -e \'tell application \"$app\" to $do\'};
    my($r, $g, $b) = $bg =~ /(\d+)/g;
    App::sdif::autocolor::rgb_to_brightness($r, $g, $b);
}

sub initialize {
    my $rc = shift;
    $rc->setopt(
	default =>
	brightness > 50 ? '--LIGHT-SCREEN' : '--DARK-SCREEN');
}

1;

__DATA__
