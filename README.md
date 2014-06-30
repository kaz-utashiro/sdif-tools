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

# SYNOPSIS

cdif \[cdif option\] file1 file2

cdif \[rcs options\] \[cdif options\] file

cdif \[cdif options\] \[diff-data\]

Options:

        -c, -Cn         context diff
        -u, -Un         unified diff
        -i              ignore case
        -b              ignore trailing blank
        -w              ignore whitespace
        -t              expand tabs
        -T              initial tabs
        --rcs           use rcsdiff
        -r<rev>, -q     rcs options

        -B                  char-by-char comparison
        -W                  specify terminal width
        --diff=command      specify diff command
        --stat              show statistical information
        --colormap=s        specify color map
        --[no]color         color or not            (default true)
        --[no]256           ANSI 256 color mode     (default true)
        --[no]commandcolor  color for command line  (default true)
        --[no]markcolor     color for diff mark     (default true)
        --[no]textcolor     color for normal text   (default true)
        --[no]old           print old text          (default true)
        --[no]new           print new text          (default true)
        --[no]command       print diff command line (default true)
        --[no]unknown       print unknown line      (default true)

# DESCRIPTION

**cdif** is a post-processor of the Unix diff command.  It highlights
deleted, changed and added words based on word context.

You may want to compare character-by-character rather than
word-by-word.  Option **-B** option can be used for that purpose.

If only one file is specified, cdif reads that file (stdin if no file)
as a output from diff command.

Lines those don't look like diff output are simply ignored and
printed.

# OPTIONS

- **-**\[**cCuUibwtT**\]

    Almost same as **diff** command.

- **--rcs**, **-r**_rev_, **-q**

    Use rcsdiff instead of normal diff.  Option **--rcs** is not required
    when **-r**_rev_ is supplied.

- **-B**, **--char**

    Compare the data character-by-character context.

- **-W** _width_, **--width**=_width_

    Explicitly specify terminal width.

- **--diff**=_command_

    Specify the diff command to use.

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

    You can make multiple filelds same color joining them by = :

        FIELD1=FIELD2=...=COLOR

    Also wildcard can be used for field name :

        *CHANGE=BDw

    Multiple fields can be specified by repeating options

        --cm FILED1=COLOR1 --cm FIELD2=COLOR2 ...

    or combined with comma (,) :

        --cm FILED1=COLOR1,FIELD2=COLOR2, ...

    COLOR is combination of single character representing uppercase
    foreground color :

        R  Red
        G  Green
        B  Blue
        C  Cyan
        M  Magenta
        Y  Yellow
        K  Black
        W  White

    and corresponding lowercase background color :

        r, g, b, c, m, y, k, w

    or RGB value if using ANSI 256 color terminal :

        FORMAT:
            foreground[/background]

        COLOR:
            000 .. 555       : 6 x 6 x 6 216 colors
            000000 .. FFFFFF : 24bit RGB mapped to 216 colors

        Sample:
            005     0000FF        : blue foreground
               /505       /FF00FF : magenta background
            000/555 000000/FFFFFF : black on white
            500/050 FF0000/00FF00 : red on green

    and other effects :

        S  Standout (reverse video)
        U  Underline
        D  Double-struck (boldface)
        F  Flash (blink)
        E  Expand (only for command line)

    When **E** is specified for command line, the line is expanded to
    window width filling up by space characters.

    Defaults are :

        COMMAND => "SE"
        OMARK   => "CS"
        NMARK   => "MS"
        OTEXT   => "C"
        NTEXT   => "M"
        OCHANGE => "BD/445"
        NCHANGE => "BD/445"
        DELETE  => "RD/544"
        APPEND  => "RD/544"

    This is equivalent to :

        cdif --cm 'COMMAND=SE,OMARK=CS,NMARK=MS' \
             --cm 'OTEXT=C,NTEXT=M,*CHANGE=BD/445,DELETE=APPEND=RD/544'

- **--**\[**no**\]**commandcolor**, **--cc**
- **--**\[**no**\]**markcolor**, **--mc**
- **--**\[**no**\]**textcolor**, **--tc**

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

        cdif -U100 --nomark --noold --nocommand --nounknown old new

    These options are prepared for watchdiff(1) command.

- **--stat**

    Print statistical information at the end of output.  It shows number
    of total appended/deleted/changed words in the context of cdif.  It's
    common to have many insertions and deletions of newlines becuase of
    text filling process.  So normal informaiton is followed by modified
    number which ignores insert/delete newlines.

- **--mecab**

    Experimental option for using **mecab** as a tokenizer.  To use this
    option, external command **mecab** has to be installed.

# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/cdif

# SEE ALSO

perl(1), diff(1), sdif(1), watchdiff(1)

# BUGS

**cdif** is naturally not very fast because it uses normal diff command
as a backend processor to compare words.

# COPYRIGHT

Use and redistribution for ANY PURPOSE are granted as long as all
copyright notices are retained.  Redistribution with modification is
allowed provided that you make your modified version obviously
distinguishable from the original one.  THIS SOFTWARE IS PROVIDED BY
THE AUTHOR \`\`AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES ARE
DISCLAIMED.
