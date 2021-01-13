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

Version 4.18.2

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
        --rcs           use rcsdiff
        -r<rev>, -q     rcs options

        --diff=command      specify diff command
        --subdiff=command   specify backend diff command
        --stat              show statistical information
        --colormap=s        specify color map
        --unit=s            word, char or mecab     (default word)
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
        --prefix-pattern    prefix pattern
        --visible char=?    set visible attributes
        --[no]mecab         use mecab tokenizer     (default false)
        --[no]lenience      suppress unexpected input warning (default true)

# DESCRIPTION

**cdif** is a post-processor of the Unix diff command.  It highlights
deleted, changed and added words based on word context (**--unit=word**
by default).  If you want to compare text character-by-character, use
option **--unit=char**.  Option **--unit=mecab** tells to use external
**mecab** command as a tokenizer for Japanese text.

If single or no file is specified, cdif reads that file or STDIN as a
output from diff command.

Lines those don't look like diff output are simply ignored and
printed.

# OPTIONS

- **-**\[**cCuUibwtT**\]

    Almost same as **diff** command.

- **--rcs**, **-r**_rev_, **-q**

    Use rcsdiff instead of normal diff.  Option **--rcs** is not required
    when **-r**_rev_ is supplied.

- **--****unit**=_word_|_char_|_mecab_
- **--****by**=_word_|_char_|_mecab_

    Specify the comparing unit.  Default is _word_ and compare each line
    word-by-word.  Specify _char_ if you want to compare them
    character-by-character.

    When _mecab_ is given as an unit, **mecab** command is called as a
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

- **--**\[**no**\]**color**

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
        <aliceblue> <honeydue> <hotpink> <mooccasin>
        <medium_aqua_marine>

    with other special effects :

        D  Double-struck (boldface)
        I  Italic
        U  Underline
        S  Stand-out (reverse video)

    Above color spec is simplified summary so if you want complete
    information, read [Getopt::EX::Colormap](https://metacpan.org/pod/Getopt::EX::Colormap).

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

- **--**\[**no**\]**commandcolor**, **--cc**
- **--**\[**no**\]**markcolor**, **--mc**
- **--**\[**no**\]**textcolor**, **--tc**
- **--**\[**no**\]**unknowncolor**, **--uc**

    Enable/Disable using color for the corresponding field.

- **--**\[**no**\]**old**, **--**\[**no**\]**new**

    Print or not old/new text in diff output.

- **--**\[**no**\]**command**

    Print or not command lines preceding diff output.

- **--**\[**no**\]**unknown**

    Print or not lines not look like diff output.

- **--**\[**no**\]**mark**

    Print or not marks at the top of diff output lines.  At this point,
    this option is effective only for unified diff.

    Next example produces the output exactly same as _new_ except visual
    effects.

        cdif -U100 --no-mark --no-old --no-command --no-unknown old new

    These options are prepared for watchdiff(1) command.

- **--**\[**no**\]**prefix**

    Understand prefix for diff output including **git** **--graph** option.
    True by default.

- **--prefix-pattern**=_pattern_

    Specify prefix pattern in regex.  Default pattern is:

        (?:\| )*(?:  )*

    This pattern matches **git** graph style and whitespace indented diff
    output.

- **--visible** _chaname_=\[0,1\]

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

    Colormap name `VISIBLE` is applied to those characters.  Default
    setting is `S`, and visible characters are displayed in reverse
    video.  Unlike other colormaps, only special effects can be set to
    this name.  Effect `D` (double-struck) is exception (see `~` section
    in [Getopt::EX::Colormap](https://metacpan.org/pod/Getopt::EX::Colormap)).

- **--stat**

    Print statistical information at the end of output.  It shows number
    of total appended/deleted/changed words in the context of cdif.  It's
    common to have many insertions and deletions of newlines because of
    text filling process.  So normal information is followed by modified
    number which ignores insert/delete newlines.

- **--**\[**no**\]**lenience**

    Suppress warning message for unexpected input from diff command.  True
    by default.

# ENVIRONMENT

Environment variable **CDIFOPTS** is used to set default options.

# AUTHOR

Kazumasa Utashiro

# LICENSE

Copyright 1992-2021 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

[sdif(1)](http://man.he.net/man1/sdif), [watchdiff(1)](http://man.he.net/man1/watchdiff)

[Getopt::EX::Colormap](https://metacpan.org/pod/Getopt::EX::Colormap)

[https://taku910.github.io/mecab/](https://taku910.github.io/mecab/)

# BUGS

**cdif** is naturally not very fast because it uses normal diff command
as a back-end processor to compare words.
