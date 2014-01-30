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
        --diff=command      specify diff command
        --stat              show statistical information
        --colormap=s        specify color map
        --[no]color         color or not           (default true)
        --[no]256           ANSI 256 color mode    (default true)
        --[no]commandcolor  color for command line (default true)
        --[no]markcolor     color for diff mark    (default true)
        --[no]textcolor     color for normal text  (default true)

# DESCRIPTION

__cdif__ is a post-processor of the Unix diff command.  It highlights
deleted, changed and added words based on word context.

You may want to compare character-by-character rather than
word-by-word.  Option __-B__ option can be used for that purpose.

If only one file is specified, cdif reads that file (stdin if no file)
as a output from diff command.

Lines those don't look like diff output are simply ignored and
printed.

# OPTIONS

- __-__\[__cCuUibwtT__\]

    Almost same as __diff__ command.

- __--rcs__, __-r___rev_, __-q__

    Use rcsdiff instead of normal diff.  Option __--rcs__ is not required
    when __-r___rev_ is supplied.

- __-B__, __--char__

    Compare the data character-by-character context.

- __--diff__=_command_

    Specify the diff command to use.

- __--__\[__no__\]__color__

    Use ANSI color escape sequence for output.

- __--colormap__=_colormap_, __--cm__=_colormap_

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

    When __E__ is specified for command line, the line is expanded to
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

- __--__\[__no__\]__commandcolor__, __--cc__
- __--__\[__no__\]__markcolor__, __--mc__
- __--__\[__no__\]__textcolor__, __--tc__

    Enable/Disable using color for the corresponding field.

- __--stat__

    Print statistical information at the end of output.  It shows number
    of total appended/deleted/changed words in the context of cdif.  It's
    common to have many insertions and deletions of newlines becuase of
    text filling process.  So normal informaiton is followed by modified
    number which ignores insert/delete newlines.

- __--mecab__

    Experimental option for using __mecab__ as a tokenizer.  To use this
    option, external command __mecab__ has to be installed.

# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/cdif

# SEE ALSO

perl(1), diff(1)

# BUGS

__cdif__ is naturally not very fast because it uses normal diff command
as a backend processor to compare words.

# COPYRIGHT

Use and redistribution for ANY PURPOSE are granted as long as all
copyright notices are retained.  Redistribution with modification is
allowed provided that you make your modified version obviously
distinguishable from the original one.  THIS SOFTWARE IS PROVIDED BY
THE AUTHOR \`\`AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES ARE
DISCLAIMED.
