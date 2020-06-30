# WATCHDIFF

# NAME

watchdiff - repeat command and watch the differences

# SYNOPSIS

watchdiff option -- command

Options:

        -r, --refresh:1     refresh screen count (default 1)
        -i, --interval=i    interval time in second (default 2)
        -c, --count=i       command repeat count (default 1000)
        -e, --exec=s        set executing commands
        -s, --silent        do not show same result
        -p, --plain         shortcut for --nodate --nonewline
        --[no]date          show date at the beginning (default on)
        --[no]newline       print newline result (default on)
        --[no]clear         clear screen after output (default on)
        --diff=command      diff command used to compare result
        --unit=unit         comparison unit (word/char/mecab)

# EXAMPLES

        watchdiff ifconfig -a

        watchdiff df

        watchdiff --silent df

        watchdiff --refresh 5 --noclear df

        watchdiff -sri1 -- netstat -sp icmp

        watchdiff -e uptime -e iostat -e df

        watchdiff -psr --diff 'sdif --no-command -U-1' netstat -S -I en0

        watchdiff -pc18i10r0 date; say tea is ready

# AUTHOR

Kazumasa Utashiro

[https://github.com/kaz-utashiro/sdif-tools](https://github.com/kaz-utashiro/sdif-tools)

# LICENSE

Copyright 2014-2020 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[diff(1)](http://man.he.net/man1/diff), [cdif(1)](http://man.he.net/man1/cdif), [sdif(1)](http://man.he.net/man1/sdif)
