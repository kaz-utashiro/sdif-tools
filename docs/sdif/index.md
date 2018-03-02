# SDIF

### is Side-by-side diff viewer

### for ANSI color terminal

### capable of word context display powerd by CDIF

[![default](http://kaz-utashiro.github.io/sdif/images/screen-shot-default.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-default.jpg)


# Flexible color

### ANSI 256 colors

[![green](http://kaz-utashiro.github.io/sdif/images/screen-shot-green.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-green.jpg)


# International

### Unicode

### East Asian wide width character

### Japanese Kanji/Hiragana/Katakana separation

[![japanese](http://kaz-utashiro.github.io/sdif/images/screen-shot-japanese.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-japanese.jpg)

### Korean

[![korean](http://kaz-utashiro.github.io/sdif/images/screen-shot-korean.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-korean.jpg)

### Chinese

[![chinese](http://kaz-utashiro.github.io/sdif/images/screen-shot-chinese.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-chinese.jpg)


# Japanese syllable tokenizer

### --mecab morphology

[![mecab](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab.jpg)

[![mecab](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab-comp.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab-comp.jpg)

# NAME

sdif - side-by-side diff viewer for ANSI terminal

# SYNOPSIS

sdif file\_1 file\_2

diff ... | sdif

    -b, --ignore-space-change
    -w, --ignore-all-space
    -B, --ignore-blank-lines

    --[no]number, -n    print line number
    --digit=#           set the line number digits (default 4)
    --truncate, -t      truncate long line
    --[no]onword        fold line on word boundaries
    --context, -c, -C#  context diff
    --unified, -u, -U#  unified diff

    --width=#, -W#      specify width of output (default 80)
    --color=when        'always' (default), 'never' or 'auto'
    --nocolor           --color=never
    --colormap, --cm    specify color map
    --colortable        show color table
    --[no]256           on/off ANSI 256 color mode (default on)
    --mark=position     mark position (right, left, center, side) or no
    --column=order      set column order (default ONM)
    --view, -v          viewer mode
    --ambiguous=s       ambiguous character width (detect, wide, narrow)

    --man               display manual page
    --diff=s            set diff command
    --diffopts=s        set diff command options

    --[no]cdif          use ``cdif'' as word context diff backend
    --cdifopts=s        set cdif command options
    --mecab             pass --mecab option to cdif

# DESCRIPTION

**sdif** is inspired by System V [sdiff(1)](http://man.he.net/man1/sdiff) command.  The basic
feature of sdif is making a side-by-side listing of two different
files.  All contents of two files are listed on left and right sides.
Center column is used to indicate how different those lines are.  No
mark means no difference.  Added, deleted and modified lines are
marked with \`-' and \`+' character.

    1 deleted  -
    2 same          1 same
    3 changed  -+   2 modified
    4 same          3 same
                +   4 added

It also reads and formats the output from **diff** command from
standard input.  Besides normal diff output, context diff _-c_ and
unified diff _-u_ output will be handled properly.  Combined diff
format is also supported, but currently limited up to three files.

## STARTUP and MODULE

**sdif** utilizes Perl [Getopt::EX](https://metacpan.org/pod/Getopt::EX) module, and reads _~/.sdifrc_
file if available when starting up.  You can define original and
default option there.  To show the line number always, define like
this:

    option default -n

Modules under **App::sdif** can be loaded by **-M** option without
prefix.  Next command load **App::sdif::colors** module.

    $ sdif -Mcolors

You can also define options in module file.  Read \`perldoc
Getopt::EX::Module\` for detail.

## COLOR

Each lines are displayed in different colors by default.  Use
**--no-color** option to disable it.  Each text segment has own labels,
and color for them can be specified by **--colormap** option.  Read
\`perldoc Getopt::EX::Colormap\` for detail.

Standard module **-Mcolors** is loaded by default, and define several
color maps for light and dark screen.  If you want to use CMY colors in
dark screen, place next line in your `~/.sdifrc`.

    option default --dark-cmy

Option **--autocolor** is defined to load **-Mautocolor** module.  It
sets **--light** or **--dark** option according to the brightness of the
terminal screen.  You can set preferred color in your `~/.sdifrc`
like:

    option --light --cmy
    option --dark  --dark-cmy

If the **BRIGHTNESS** environment variable is set in a range of 0 to
100 digit, it is used as a screen brightness.

Currently automatic setting by **-Mautocolor** module works only on
macOS Terminal.app.  If you are using other terminal application, set
the **BRIGHTNESS** or write a module.

Option **--autocolor** is set by default, so override it to do nothing
to disable.

    option --autocolor --nop

## CDIF

While **sdif** doesn't care about the contents of each modified lines,
it can read the output from **cdif** command which show the word
context differences of each lines.  Option **--cdif** set the
appropriate options for **cdif**.  Set _--no-cc_, _--no-mc_ options
at least when invoking **cdif** manually.  Option _--no-tc_ is
preferable because text color can be handled by **sdif**.

From version 4.1.0, option **--cdif** is set by default, so use
**--no-cdif** option to disable it.

# OPTIONS

- **--width**=_width_, **-W** _width_

    Use width as a width of output listing.  Default width is 80.  If the
    standard error is assigned to a terminal, the width is taken from it
    if possible.

- **--**\[**no**\]**number**, **-n**

    Print line number on each lines.
    Default false.

- **--digit**=_n_

    Line number is displayed in 4 digits by default.  Use this option to
    change it.

- **-b**, **--ignore-space-change**
- **-w**, **--ignore-all-space**
- **-B**, **--ignore-blank-lines**
- **-c**, **-C**_n_, **-u**, **-U**_n_

    Passed through to the back-end diff command.  Sdif can interpret the
    output from normal, context (_diff -c_) and unified diff (_diff
    \-u_).

- **--**\[**no**\]**truncate**, **-t**

    Truncate lines if they are longer than printing width.
    Default false.

- **--**\[**no**\]**onword**

    Fold long line at word boundaries.
    Default true.

- **--**\[**no**\]**cdif**

    Use **cdif** command instead of normal diff command.
    Default true.

- **--cdifopts**=_option_

    Specify options for back-end **cdif** command.

- **--mecab**

    Pass **--mecab** option to back-end **cdif** command.  Use **--cdifopts**
    to set other options.

- **--diff**=_command_

    Any command can be specified as a diff command to be used.  Piping
    output to **sdif** is easier unless you want to get whole text.

- **--diffopts**=_option_

    Specify options for back-end **diff** command.

- **--mark**=_position_

    Specify the position for a mark.  Choose from _left_, _right_,
    _center_, _side_ or _no_.  Default is _center_.

- **--column**=_order_

    Specify the order of each column by **O** (old), **N** (new) and **M**
    (merge).  Default order is **ONM**.  If you want to show new file on
    left side and old file in right side, use like:

        $ sdif --column NO

    Next example show merged file on left-most column for diff3 data.

        $ sdif --column MON

- **--**\[**no**\]**color**

    Use ANSI color escape sequence for output.  Default is true.

- **--**\[**no**\]**256**

    Use ANSI 256 color mode.  Default is true.

- **--colortable**

    Show table of ANSI 216 colors.

- **--view**, **-v**

    Viewer mode.  Display two files side-by-side in straightforward order.

- **--ambiguous**=_width\_spec_

    This is an experimental option to specify how to treat Unicode
    ambiguous width characters.  Default value is 'narrow'.

    - **detect** or **auto**

        Detect from user's locate.  Set 'wide' when used in CJK environment.

    - **wide** or **full**

        Treat ambiguous characters as wide.

    - **narrow** or **half**

        Treat ambiguous characters as narrow.

- **--colormap**=_colormap_, **--cm**=_colormap_

    Basic _colormap_ format is :

        FIELD=COLOR

    where the FIELD is one from these :

        OLD       NEW       MERGED    UNCHANGED
        --------- --------- --------- ---------
        OCOMMAND  NCOMMAND  MCOMMAND           : Command line
        OFILE     NFILE     MFILE              : File name
        OMARK     NMARK     MMARK     UMARK    : Mark
        OLINE     NLINE     MLINE     ULINE    : Line number
        OTEXT     NTEXT     MTEXT     UTEXT    : Text

    If UMARK and/or ULINE is empty, OMARK/NMARK and/or OLINE/NLINE are
    used instead.

    You can make multiple fields same color joining them by = :

        FIELD1=FIELD2=...=COLOR

    Also wildcard can be used for field name :

        *CHANGE=BDw

    Multiple fields can be specified by repeating options

        --cm FILED1=COLOR1 --cm FIELD2=COLOR2 ...

    or combined with comma (,) :

        --cm FILED1=COLOR1,FIELD2=COLOR2, ...

    COLOR is a combination of single character representing uppercase
    foreground color :

        R  Red
        G  Green
        B  Blue
        C  Cyan
        M  Magenta
        Y  Yellow
        K  Black
        W  White

    and alternative (usually brighter) colors in lowercase :

        r, g, b, c, m, y, k, w

    or RGB values and 24 grey levels if using ANSI 256 or full color
    terminal :

        FORMAT:
            foreground[/background]

        COLOR:
            000 .. 555       : 6 x 6 x 6 216 colors
            000000 .. FFFFFF : 24bit RGB mapped to 216 colors
            L00 .. L23       : 24 grey levels

        Sample:
            005     0000FF        : blue foreground
               /505       /FF00FF : magenta background
            000/555 000000/FFFFFF : black on white
            500/050 FF0000/00FF00 : red on green

    and other effects :

        S  Stand-out (reverse video)
        U  Underline
        D  Double-struck (boldface)
        F  Flash (blink)
        E  Expand

    **E** is effective for command, file and text line.  That line will be
    expanded to window width filling up by space characters.  Left column
    is expanded always.  You may want to use this to set background color
    for right column.

    Defaults are :

        OCOMMAND => "555/010E"  or "GSE"
        NCOMMAND => "555/010E"  or "GSE"
        MCOMMAND => "555/010E"  or "GSE"
        OFILE    => "555/010DE" or "GSDE"
        NFILE    => "555/010DE" or "GSDE"
        MFILE    => "555/010DE" or "GSDE"
        OMARK    => "010/444"   or "G/W"
        NMARK    => "010/444"   or "G/W"
        MMARK    => "010/444"   or "G/W"
        UMARK    => ""
        OLINE    => "220"       or  "Y"
        NLINE    => "220"       or  "Y"
        MLINE    => "220"       or  "Y"
        ULINE    => ""
        OTEXT    => "KE/454"    or "G"
        NTEXT    => "KE/454"    or "G"
        MTEXT    => "KE/454"    or "G"
        UTEXT    => ""

    This is equivalent to :

        sdif --cm '?COMMAND=555/010E,?FILE=555/010DE' \
             --cm '?MARK=010/444,UMARK=' \
             --cm '?LINE=220,ULINE=' \
             --cm '?TEXT=KE/454,UTEXT='

# MODULE OPTIONS

## default

    default      --autocolor
    --autocolor  -Mautocolor
    --nop        do nothing

## -Mcolors

Following options are available by default.  Use \`perldoc -m
App::sdif::colors\` to see actual setting.

    --light
    --green
    --cmy
    --mono

    --dark
    --dark-green
    --dark-cmy
    --dark-mono

# ENVIRONMENT

Environment variable **SDIFOPTS** is used to set default options.

# AUTHOR

- Kazumasa Utashiro
- [https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

# SEE ALSO

[cdif(1)](http://man.he.net/man1/cdif), [watchdiff(1)](http://man.he.net/man1/watchdiff)

[Getopt::EX::Colormap](https://metacpan.org/pod/Getopt::EX::Colormap)

[App::sdif::colors](https://metacpan.org/pod/App::sdif::colors),
[App::sdif::autocolor](https://metacpan.org/pod/App::sdif::autocolor),
[App::sdif::autocolor::Apple\_Terminal](https://metacpan.org/pod/App::sdif::autocolor::Apple_Terminal)
