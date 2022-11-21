---
layout: page
title: sdif
---
## NAME

sdif - side-by-side diff viewer for ANSI terminal

## VERSION

Version 4.22.3

## SYNOPSIS

      sdif file_1 file_2

      diff ... | sdif

    OPTIONS:

      -i, --ignore-case
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
      --margin=#          specify margin column number (default 0)
      --runin=#           specify run-in column number (default --margin)
      --runout=#          specify run-out column number (default --margin)
      --mark=position     mark position (right, left, center, side) or no
      --column=order      set column order (default ONM)
      --view, -v          viewer mode
      --ambiguous=s       ambiguous character width (detect, wide, narrow)
      --[no]command       print diff control command (default on)
      --[no]prefix        process git --graph output (default on)
      --prefix-pattern    prefix pattern

      --color=when        'always' (default), 'never' or 'auto'
      --nocolor           --color=never
      --colormap, --cm    specify color map
      --colortable        show color table
      --[no]256           on/off ANSI 256 color mode (default on)

      --man               display manual page
      --diff=s            set diff command
      --diffopts=s        set diff command options

      --[no]lenience      supress unexpected input warning (default on)
      --visible xx=1      set visible chars
      --tabhead=char      set tabhead char
      --tabspace=char     set tabspace char
      --tabstyle=style    set tabstyle (dot, symbol, shade, bar, dash...)
      --tabstop=#         set tabstop width (default 8)

      --[no]cdif          use ``cdif'' as word context diff backend
      --unit=s            pass through to cdif (word, char, mecab)
      --cdifopts=s        set cdif command options

## DESCRIPTION

**sdif** is inspired by System V [sdiff(1)](http://man.he.net/man1/sdiff) command.  The basic
feature of sdif is making a side-by-side listing of two different
files.  All contents of two files are listed on left and right sides.
Center column is used to indicate how different those lines are.  No
mark means no difference.  Added, deleted and modified lines are
marked with minus `-` and plus `+` character, and wrapped line is
marked with period `.`.

    1 deleted  -
    2 same          1 same
    3 changed  -+   2 modified
      wrapped  ..     folded
    4 same          3 same
                +   4 added

It also reads and formats the output from **diff** command from
standard input.  Besides normal diff output, context diff _-c_ and
unified diff _-u_ output will be handled properly.  Combined diff
format is also supported, but currently limited up to three files.

### STARTUP and MODULE

**sdif** utilizes Perl [Getopt::EX](https://metacpan.org/pod/Getopt%3A%3AEX) module, and reads _~/.sdifrc_
file if available when starting up.  You can define original and
default option there.  To show the line number always, define like
this:

    option default -n

Modules under **App::sdif** can be loaded by **-M** option without
prefix.  Next command load **App::sdif::colors** module.

    $ sdif -Mcolors

You can also define options in module file.  Read \`perldoc
Getopt::EX::Module\` for detail.

### COLOR

Each lines are displayed in different colors by default.  Use
**--no-color** option to disable it.  Each text segment has own labels,
and color for them can be specified by **--colormap** option.  Read
\`perldoc Getopt::EX::Colormap\` for detail.

Standard module **-Mcolors** is loaded by default, and define several
color maps for light and dark screen.  If you want to use CMY colors in
dark screen, place next line in your `~/.sdifrc`.

    option default --dark-cmy

Option **--autocolor** is defined in **default** module to call
[Getopt::EX::termcolor](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3Atermcolor) module.  It sets **--light** or **--dark**
option according to the brightness of the terminal screen.  You can
set preferred color in your `~/.sdifrc` like:

    option --light --cmy
    option --dark  --dark-cmy

Automatic setting is done by [Getopt::EX::termcolor](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3Atermcolor) module and it
works with macOS Terminal.app and iTerm.app, and other XTerm
compatible terminals.  This module accept environment variable
[TERM\_BGCOLOR](https://metacpan.org/pod/TERM_BGCOLOR) as a terminal background color in a form of
`#FFFFFF`.

Option **--autocolor** is set by default, so override it to do nothing
to disable.

    option --autocolor --nop

### WORD DIFFERENCE

While **sdif** doesn't care about the contents of each modified lines,
it can read the output from **cdif** command which show the word
context differences of each lines.  Option **--cdif** set the
appropriate options for **cdif**.  Set _--no-cc_, _--no-mc_ options
at least when invoking **cdif** manually.  Option _--no-tc_ is
preferable because text color can be handled by **sdif**.

From version 4.1.0, option **--cdif** is set by default, so use
**--no-cdif** option to disable it.  Option **--unit** (default word)
will be passed through to **cdif**.  Other **cdif** options can be
specified by **--cdifopts**.

### EXIT STATUS

**sdif** always exit with status zero unless error occurred.

## OPTIONS

- **--width**=_width_, **-W** _width_

    Use width as a width of output listing.  Default width is 80.  If the
    standard error is assigned to a terminal, the width is taken from it
    if possible.

- **--margin**=_column_
- **--runin**=_column_
- **--runout**=_column_

    Set the number of margin column.  Margin columns are left blank at the
    end of each line.  This option implicitly declare line break control,
    which allows to run-in and run-out prohibited characters at the
    head-and-end of line.  Margin columns are used for run-in/run-out
    columns unless they are given explicitly.  See \`perldoc
    Text::ANSI::Fold\` for detail.

- **-n**, **--**\[**no-**\]**number**

    Print line number on each lines.
    Default false.

- **--**\[**no-**\]**command**

    Print diff command control lines.
    Default true.

- **--digit**=_n_

    Line number is displayed in 4 digits by default.  Use this option to
    change it.

- **-i**, **--ignore-case**
- **-b**, **--ignore-space-change**
- **-w**, **--ignore-all-space**
- **-B**, **--ignore-blank-lines**
- **-c**, **--context**=_n_, **-C**_n_
- **-u**, **--unified**=_n_, **-U**_n_

    Passed through to the back-end diff command.  Sdif can interpret the
    output from normal, context (_diff -c_) and unified diff (_diff
    \-u_).

- **-t**, **--**\[**no-**\]**truncate**

    Truncate lines if they are longer than printing width.
    Default false.

- **--**\[**no-**\]**onword**

    Fold long line at word boundaries.
    Default true.

- **--**\[**no-**\]**cdif**\[=_command_\]

    Use **cdif** command instead of normal diff command.  Enabled by
    default and use **--no-cdif** option explicitly to disable it.  This
    option accepts optional parameter as an actual **cdif** command.

- **--cdifopts**=_option_

    Specify options for back-end **cdif** command.

- **--unit**=\[`word`,`letter`,`char`,`mecab`\]
- **--by**=\[`word`,`letter`,`char`,`mecab`\]
- **--mecab**

    These options are simply sent to back-end **cdif** command.  Choose
    value from `word` (default), `letter`, `char` or `mecab`.  Option
    **--by** is an alias for **--unit**.  Option **--mecab** is a shortcut
    for **--unit=mecab**.  Consult [cdif](https://metacpan.org/pod/cdif) manual for detail.

    Use **--cdifopts** to set other options.

- **--diff**=_command_

    Any command can be specified as a diff command to be used.  Piping
    output to **sdif** is easier unless you want to get whole text.

- **--diffopts**=_option_

    Specify options for back-end **diff** command.

- **--mark**=_position_

    Specify the position for a mark.  Choose from `left`, `right`,
    `center`, `side` or `no`.  Default is `center`.

- **--column**=_order_

    Specify the order of each column by **O** (1: old), **N** (2: new) and
    **M** (3: merged).  Default order is "ONM" or "123".  If you want to
    show new file on left side and old file in right side, use like:

        $ sdif --column NO

    Next example show merged file on left-most column for diff3 data.

        $ sdif --column MON

    Next two commands produce same output.

        $ git diff v1 v2 v3 | sdif --column 312

        $ git diff v3 v1 v2 | sdif

- **--**\[**no-**\]**color**

    Use ANSI color escape sequence for output.  Default is true.

- **--**\[**no-**\]**256**

    Use ANSI 256 color mode.  Default is true.

- **--colortable**

    Show table of ANSI 216 colors.

- **-v**, **--view**

    Viewer mode.  Display each files in straightforward order.  Without
    this option, unchanged lines are placed at the same position.

- **--ambiguous**=_width\_spec_

    This is an experimental option to specify how to treat Unicode
    ambiguous width characters.  Default value is 'narrow'.

    - **detect** or **auto**

        Detect from user's locate.  Set 'wide' when used in CJK environment.

    - **wide** or **full**

        Treat ambiguous characters as wide.

    - **narrow** or **half**

        Treat ambiguous characters as narrow.

- **--**\[**no-**\]**prefix**

    Understand prefix for diff output including **git** **--graph** option.
    True by default.

- **--prefix-pattern**=_pattern_

    Specify prefix pattern in regex.  Default pattern is:

        (?:\| )*(?:  )?

    This pattern matches **git** graph style and whitespace indented diff
    output.

- **--**\[**no-**\]**lenience**

    Suppress warning message for unexpected input from diff command.  True
    by default.

- **--visible** _charname_=\[0,1\]
- **--tabhead**=_char_
- **--tabspace**=_char_

    Visualize characters.  Currently only `ht` (horizontal tab) is
    supported.  Each horizontal tab character is converted to **tabhead**
    and following **tabspace** characters.  They can be specified by
    **--tabhead** and **--tabspace** option.

        $ sdif --visible ht=1 --tabhead=T --tabspace=.

    If the option value is longer than single character, it is evaluated
    as unicode name.

        $ sdif --visible ht=1 \
               --tabhead="MEDIUM SHADE" \
               --tabspace="LIGHT SHADE"

    See [https://www.unicode.org/charts/charindex.html](https://www.unicode.org/charts/charindex.html) for Unicode
    names.

    **cdif** shows non-space control characters visible by default. See
    ["--visible" in cdif](https://metacpan.org/pod/cdif#visible).

- **--tabstyle**=\[`space`,`dot`,`symbol`,`shade`,`bar`,`dash`...\]

    Option **--tabstyle** allow to set **--tabhead** and **--tabspace**
    characters at once according to the given style name.  Select from
    `space`, `dot`, `symbol`, `shade`, `bar`, `dash` and others.
    See ["tabstyle" in Text::ANSI::Fold](https://metacpan.org/pod/Text%3A%3AANSI%3A%3AFold#tabstyle) for available styles.

    Multiple styles can be mixed up like `symbol,space`.  In this case,
    tabhead and tabspace are taken from `symbol` and `space` style
    respectively.

    Setting tabstyle implies `ht` being visible.  If you want to set
    tabstyle by default, but don't want to make tab visible always,
    disable it explicitly.

        option default --tabstyle=symbol,space --visible ht=0

    Then you can enable it at the time of execution.

        $ sdif --visible ht=1

- **--tabstop**=_n_

    Specify tab stop.  Default is 8.

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

    Color specification is a combination of single uppercase character
    representing 8 colors :

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

        (255,255,255)      : 24bit decimal RGB colors
        #000000 .. #FFFFFF : 24bit hex RGB colors
        #000    .. #FFF    : 12bit hex RGB 4096 colors
        000 .. 555         : 6x6x6 RGB 216 colors
        L00 .. L25         : Black (L00), 24 grey levels, White (L25)

    or color names enclosed by angle bracket :

        <red> <blue> <green> <cyan> <magenta> <yellow>
        <aliceblue> <honeydue> <hotpink> <moccasin>
        <medium_aqua_marine>

    with other special effects :

        D  Double-struck (boldface)
        I  Italic
        U  Underline
        S  Stand-out (reverse video)

    Above color spec is simplified summary so if you want complete
    information, read [Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap).

    Defaults are :

        OCOMMAND => "555/010"  or "GS"
        NCOMMAND => "555/010"  or "GS"
        MCOMMAND => "555/010"  or "GS"
        OFILE    => "551/010D" or "GDS"
        NFILE    => "551/010D" or "GDS"
        MFILE    => "551/010D" or "GDS"
        OMARK    => "010/444"  or "G/W"
        NMARK    => "010/444"  or "G/W"
        MMARK    => "010/444"  or "G/W"
        UMARK    => ""
        OLINE    => "220"      or "Y"
        NLINE    => "220"      or "Y"
        MLINE    => "220"      or "Y"
        ULINE    => ""
        OTEXT    => "K/454"    or "G"
        NTEXT    => "K/454"    or "G"
        MTEXT    => "K/454"    or "G"
        UTEXT    => ""

    This is equivalent to :

        sdif --cm '?COMMAND=555/010,?FILE=555/010D' \
             --cm '?MARK=010/444,UMARK=' \
             --cm '?LINE=220,ULINE=' \
             --cm '?TEXT=K/454,UTEXT='

- **--colormap**=`&func`
- **--colormap**=`sub{...}`

    You can also set the name of perl subroutine name or definition to be
    called handling matched words.  Target word is passed as variable
    `$_`, and the return value of the subroutine will be displayed.

    See ["FUNCTION SPEC" in Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap#FUNCTION-SPEC) for detail.

## MODULE OPTIONS

### default

    default      --autocolor
    --nop        do nothing

### -Mcolors

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

## ENVIRONMENT

Environment variable **SDIFOPTS** is used to set default options.

## AUTHOR

- Kazumasa Utashiro
- [https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

## LICENSE

Copyright 1992-2022 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

## SEE ALSO

[cdif(1)](http://man.he.net/man1/cdif), [watchdiff(1)](http://man.he.net/man1/watchdiff)

[Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap)

[Getopt::EX::termcolor](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3Atermcolor)

[App::sdif::colors](https://metacpan.org/pod/App%3A%3Asdif%3A%3Acolors)

[https://taku910.github.io/mecab/](https://taku910.github.io/mecab/)
