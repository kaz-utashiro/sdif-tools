# NAME

watchdiff - repeat command and watch the differences

# SYNOPSIS

watchdiff option -- command

Options:

        -r, --refresh:1     refresh screen count (default 0)
        -i, --interval=i    interval time in second (default 2)
        -c, --count=i       command repeat count (default 1000)
        -e, --exec=s        set executing commands
        -s, --silent        do not show same result
        -p, --plain         shortcut for --nodate --nonewline
            --[no]date      show date at the beginning (default on)
            --[no]newline   print newline result (default on)
            --[no]clear     clear screen after output (default on)
            --diff=command  diff command used to compare result

Example:

        watchdiff df

        watchdiff --silent df

        watchdiff --refresh 5 --noclear -- df

        watchdiff -sri1 -- netstat -sp ip

        watchdiff -r -e uptime -e iostat -e df

        watchdiff -sr1 --diff 'sdif --cdif -U100' -- netstat -sp ip

        watchdiff -pc18i10 date; echo ready

# DESCRIPTION

Please install cdif(1) command as a default backend.

# AUTHOR

Kazumasa Utashiro

https://github.com/kaz-utashiro/watchdiff

# SEE ALSO

diff(1), cdif(1), sdif(1)

# COPYRIGHT

Use and redistribution for ANY PURPOSE are granted as long as all
copyright notices are retained.  Redistribution with modification is
allowed provided that you make your modified version obviously
distinguishable from the original one.  THIS SOFTWARE IS PROVIDED BY
THE AUTHOR \`\`AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES ARE
DISCLAIMED.
