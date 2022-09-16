# WATCHDIFF

# NAME

watchdiff - repeat command and watch differences

# SYNOPSIS

watchdiff option -- command

Options:

        -r, --refresh:1     refresh screen count (default 1)
        -i, --interval=i    interval time in second (default 2)
        -c, --count=i       command repeat count (default 1000)
        -e, --exec=s        set executing commands
        -s, --silent        do not show same result
        -p, --plain         shortcut for --nodate --nonewline
        --[no-]date         show date at the beginning (default on)
        --[no-]newline      print newline result (default on)
        --[no-]clear        clear screen after output (default on)
        --diff=command      diff command used to compare result
        --unit=unit         comparison unit (word/char/mecab)

        -M, --mark          show diff mark (default off)
        -O, --old           show old data (default off)
        -U, --context=i     diff before/after context (default 100)

        -h, --help          show help
        -v, --version       show version

# VERSION

Version 4.22.3

# EXAMPLES

        watchdiff ifconfig -a

        watchdiff df

        watchdiff --silent df

        watchdiff --refresh 5 --noclear df

        watchdiff -sri1 -- netstat -sp icmp

        watchdiff -e uptime -e iostat -e df

        watchdiff -ps --diff 'sdif --no-command -U-1' netstat -S -I en0

        watchdiff -pc18i10r0 date; say tea is ready

        watchdiff -sU2 du -h ~/Music

# DESCRIPTION

Use `^C` to terminate.

Basically **watchdiff** command expect the command output is small
enough to fit within a terminal screen size.  If the output is longer
than the screen height, only the final part is shown.  Use **-U**
option if the output is large and you want to see modified part only.

# AUTHOR

Kazumasa Utashiro

[https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

# LICENSE

Copyright 2014-2022 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[App::sdif](https://metacpan.org/pod/App%3A%3Asdif)

[diff(1)](http://man.he.net/man1/diff), [cdif(1)](http://man.he.net/man1/cdif), [sdif(1)](http://man.he.net/man1/sdif)
