# CDIF

### is word context visualizer of DIFF output

### for ANSI color terminal

[![cdif](http://cdn-ak.f.st-hatena.com/images/fotolife/u/uta46/20140110/20140110150042.gif)](http://cdn-ak.f.st-hatena.com/images/fotolife/u/uta46/20140110/20140110150042.gif)

# Side-by-side view

### power by SDIF command

[![default](http://kaz-utashiro.github.io/sdif/images/screen-shot-default.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-default.jpg)


# International

### Unicode

### East Asian wide width character

### Japanese Kanji/Hiragana/Katakana separation

[![japanese](http://kaz-utashiro.github.io/sdif/images/screen-shot-japanese.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-japanese.jpg)


# Japanese syllable tokenizer

### --mecab morphology

[![mecab](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab.jpg)

[![mecab](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab-comp.jpg)](http://kaz-utashiro.github.io/sdif/images/screen-shot-mecab-comp.jpg)


# Using inside Emacs

[![emacs](http://cdn-ak.f.st-hatena.com/images/fotolife/u/uta46/20140403/20140403170919.png)](http://cdn-ak.f.st-hatena.com/images/fotolife/u/uta46/20140403/20140403170919.png)
# NAME

cdif - word context diff

# VERSION

Version 4.22.1

# SYNOPSIS

cdif \[option\] file1 file2

cdif \[option\] \[diff-data\]

Options:

        -c, -Cn         context diff
        -u, -Un         unified diff
        -i              ignore case
        -b              ignore space change
        -w              ignore whitespace
        -t              expand tabs

        --diff=command      specify diff command
        --subdiff=command   specify backend diff command
        --stat              show statistical information
        --colormap=s        specify color map
        --sdif              sdif friendly option
        --[no]color         color or not            (default true)
        --[no]256           ANSI 256 color mode     (default true)
        --[no]commandcolor  color for command line  (default true)
        --[no]markcolor     color for diff mark     (default true)
        --[no]textcolor     color for normal text   (default true)
        --[no]unknowncolor  color for unknown text  (default true)
        --[no]old           print old text          (default true)
        --[no]new           print new text          (default true)
        --[no]command       print diff command line (default true)
        --[no]unknown       print unknown line      (default true)
        --[no]mark          print mark or not       (default true)
        --[no]prefix        read git --graph output (default true)
        --unit=s            word, char or mecab     (default word)
        --[no]mecab         use mecab tokenizer     (default false)
        --prefix-pattern    prefix pattern
        --visible char=?    set visible attributes
        --[no]lenience      suppress unexpected input warning (default true)

# DESCRIPTION

**cdif** is a post-processor of the Unix diff command.  It highlights
deleted, changed and added words based on word context (**--unit=word**
by default).  If you want to compare text character-by-character, use
option **--unit=char**.  Option **--unit=mecab** tells to use external
**mecab** command as a tokenizer for Japanese text.

If single or no file is specified, cdif reads that file or STDIN as an
output from diff command.

Lines those don't look like diff output are simply ignored and
printed.

## STARTUP and MODULE

**cdif** utilizes Perl [Getopt::EX](https://metacpan.org/pod/Getopt%3A%3AEX) module, and reads _~/.cdifrc_
file if available when starting up.  You can define original and
default option there.  Next line enables **--mecab** option and add
crossed-out effect for deleted words.

    option default --mecab --cm DELETE=+X

Modules under **App::cdif** can be loaded by **-M** option without
prefix.  Next command load **App::cdif::colors** module.

    $ cdif -Mcolors

You can also define options in module file.  Read \`perldoc
Getopt::EX::Module\` for detail.

## COLOR

Each lines are displayed in different colors.  Each text segment has
own labels, and color for them can be specified by **--colormap**
option.  Read \`perldoc Getopt::EX::Colormap\` for detail.

Standard module **-Mcolors** is loaded by default, and define several
color maps for light and dark screen.  If you want to use CMY colors in
dark screen, place next line in your `~/.cdifrc`.

    option default --dark-cmy

Option **--autocolor** is defined in **default** module to call
[Getopt::EX::termcolor](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3Atermcolor) module.  It sets **--light** or **--dark**
option according to the brightness of the terminal screen.  You can
set preferred color in your `~/.cdifrc` like:

    option --light --cmy
    option --dark  --dark-cmy

Automatic setting is done by [Getopt::EX::termcolor](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3Atermcolor) module and it
works with macOS Terminal.app and iTerm.app, and other XTerm
compatible terminals.  This module accept environment variable
[TERM\_BGCOLOR](https://metacpan.org/pod/TERM_BGCOLOR) as a terminal background color.  For example, use
`000` or `#000000` for black and `555` or `#FFFFFF` for white.

Option **--autocolor** is set by default, so override it to do nothing
to disable.

    option --autocolor --nop

## EXIT STATUS

**cdif** always exit with status zero unless error occurred.

# OPTIONS

- **-**\[**cCuUibwtT**\]

    Almost same as **diff** command.

- **--****unit**=`word`|`letter`|`char`|`mecab`
- **--****by**=`word`|`letter`|`char`|`mecab`

    Specify the comparing unit.  Default is _word_ and compare each line
    word-by-word.  Specify `char` if you want to compare them
    character-by-character.  Unit `letter` is almost same as `word` but
    does not include underscore.

    When `mecab` is given as an unit, **mecab** command is called as a
    tokenizer for non-ASCII text.  ASCII text is compared word-by-word.
    External **mecab** command has to been installed.

- **--mecab**

    Shortcut for **--unit=mecab**.

- **--diff**=_command_

    Specify the diff command to use.

- **--subdiff**=_command_

    Specify the backend diff command to get word differences.  Accept
    normal and unified diff format.

    If you want to use **git diff** command, don't forget to set _-U0_
    option.

        --subdiff="git diff -U0 --no-index --histogram"

- **--**\[**no-**\]**color**

    Use ANSI color escape sequence for output.

- **--colormap**=_colormap_, **--cm**=_colormap_

    Basic _colormap_ format is :

        FIELD=COLOR

    where the FIELD is one from these :

        COMMAND  Command line
        OMARK    Old mark
        NMARK    New mark
        OTEXT    Old text
        NTEXT    New text
        OCHANGE  Old change part
        NCHANGE  New change part
        APPEND   Appended part
        DELETE   Deleted part
        VISIBLE  Visualized invisible chars

    and additional _Common_ and _Merged_ FIELDs for git-diff combined
    format.

        CMARK    Common mark
        CTEXT    Common text
        MMARK    Merged mark
        MTEXT    Merged text

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

        COMMAND => "555/222E"
        OMARK   => "CS"
        NMARK   => "MS"
        OTEXT   => "C"
        NTEXT   => "M"
        OCHANGE => "K/445"
        NCHANGE => "K/445"
        DELETE  => "K/544"
        APPEND  => "K/544"

        CMARK   => "GS"
        MMARK   => "YS"
        CTEXT   => "G"
        MTEXT   => "Y"

    This is equivalent to :

        cdif --cm 'COMMAND=555/222E,OMARK=CS,NMARK=MS' \
             --cm 'OTEXT=C,NTEXT=M,*CHANGE=BD/445,DELETE=APPEND=RD/544' \
             --cm 'CMARK=GS,MMARK=YS,CTEXT=G,MTEXT=Y'

- **--colormap**=`&func`
- **--colormap**=`sub{...}`

    You can also set the name of perl subroutine name or definition to be
    called handling matched words.  Target word is passed as variable
    `$_`, and the return value of the subroutine will be displayed.

    Next option produces [wdiff](https://metacpan.org/pod/wdiff)-like formatted output.

        --cm '*'= \
        --cm DELETE=OCHANGE='sub{"[-$_-]"}' \
        --cm APPEND=NCHANGE='sub{"{+$_+}"}'

    See ["FUNCTION SPEC" in Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap#FUNCTION-SPEC) for detail.

- **--**\[**no-**\]**commandcolor**, **--**\[**no-**\]**cc**
- **--**\[**no-**\]**markcolor**, **--**\[**no-**\]**mc**
- **--**\[**no-**\]**textcolor**, **--**\[**no-**\]**tc**
- **--**\[**no-**\]**unknowncolor**, **--**\[**no-**\]**uc**

    Enable/Disable using color for the corresponding field.

- **--sdif**

    Disable options appropriate to use for **sdif**'s input:
    **--commandcolor**, **--markcolor**, **--textcolor** and
    **--unknowncolor**.

- **--**\[**no-**\]**old**, **--**\[**no-**\]**new**

    Print or not old/new text in diff output.

- **--**\[**no-**\]**command**

    Print or not command lines preceding diff output.

- **--**\[**no-**\]**unknown**

    Print or not lines not look like diff output.

- **--**\[**no-**\]**mark**

    Print or not marks at the top of diff output lines.  At this point,
    this option is effective only for unified diff.

    Next example produces the output exactly same as _new_ except visual
    effects.

        cdif -U100 --no-mark --no-old --no-command --no-unknown old new

    These options are prepared for watchdiff(1) command.

- **--**\[**no-**\]**prefix**

    Understand prefix for diff output including **git** **--graph** option.
    True by default.

- **--prefix-pattern**=_pattern_

    Specify prefix pattern in regex.  Default pattern is:

        (?:\| )*(?:  )*

    This pattern matches **git** graph style and whitespace indented diff
    output.

- **--visible** _charname_=\[0,1\]

    Set visible attribute for specified characters.  Visible character is
    converted to corresponding Unicode symbol character.  Default visible:
    nul, bel, bs, vt, np, cr, esc, del.  Default invisible: ht, nl, sp.

        NAME  CODE  Unicode NAME                      DEFAULT
        ----  ----  --------------------------------  -------
        nul   \000  SYMBOL FOR NULL                   YES
        bel   \007  SYMBOL FOR BELL                   YES
        bs    \010  SYMBOL FOR BACKSPACE              YES
        ht    \011  SYMBOL FOR HORIZONTAL TABULATION  NO
        nl    \012  SYMBOL FOR NEWLINE                NO
        vt    \013  SYMBOL FOR VERTICAL TABULATION    YES
        np    \014  SYMBOL FOR FORM FEED              YES
        cr    \015  SYMBOL FOR CARRIAGE RETURN        YES
        esc   \033  SYMBOL FOR ESCAPE                 YES
        sp    \040  SYMBOL FOR SPACE                  NO
        del   \177  SYMBOL FOR DELETE                 YES

    Multiple characters can be specified at once, by assembling them by
    comma (`,`) like `--visible ht=1,sp=1`; or connecting them by equal
    sign (`=`) like `--visible ht=sp=1`.  Character name accept
    wildcard; `--visible '*=1'`.

    Colormap label `VISIBLE` is applied to those characters.  Default
    setting is `S`, and visible characters are displayed in reverse
    video.  Unlike other colormaps, only special effects can be set to
    this label.  Effect `D` (double-struck) is exception (See
    ["~" in Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap#pod)).

- **--stat**

    Print statistical information at the end of output.  It shows number
    of total appended/deleted/changed words in the context of cdif.  It's
    common to have many insertions and deletions of newlines because of
    text filling process.  So normal information is followed by modified
    number which ignores insert/delete newlines.

- **--**\[**no-**\]**lenience**

    Suppress warning message for unexpected input from diff command.  True
    by default.

# GIT

See \`perldoc App::sdif\` how to use related commands under the GIT
environment.

# ENVIRONMENT

- **CDIFOPTS**

    Environment variable **CDIFOPTS** is used to set default options.

- **LESS**
- **LESSANSIENDCHARS**

    Since **cdif** produces ANSI Erase Line terminal sequence, it is
    convenient to set **less** command understand them.

        LESS=-cR
        LESSANSIENDCHARS=mK

# AUTHOR

Kazumasa Utashiro

# LICENSE

Copyright 1992-2022 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[App::sdif](https://metacpan.org/pod/App%3A%3Asdif), [https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

[sdif(1)](http://man.he.net/man1/sdif), [watchdiff(1)](http://man.he.net/man1/watchdiff)

[Getopt::EX::Colormap](https://metacpan.org/pod/Getopt%3A%3AEX%3A%3AColormap)

[https://taku910.github.io/mecab/](https://taku910.github.io/mecab/)

# BUGS

**cdif** is naturally not very fast because it uses normal diff command
as a back-end processor to compare words.
