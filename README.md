# NAME

watchdiff - repeat command and watch the differences

# SYNOPSIS

watchdiff option -- command

Options:

        --refresh=#     refresh screen count (default 0)
        --interval=#    interval time between execution in second (default 2)
        --count=#       command repeat count (default 1000)
        --[no]date      show date at the beginning (default on)
        --[no]silent    do not show same result (default off)
        --[no]newline   print newline after command result (default on)
        --exec          set executing commands
        --diff=command  diff command used to compare result

Example:

        watchdiff df

        watchdiff --silent df

        watchdiff --refresh 5 --noclear -- df

        watchdiff --refresh 1 -- netstat -s -p ip

        watchdiff --refresh 1 --exec uptime --exec iostat --exec df

        watchdiff -s --refresh 1 --diff 'sdif --cdif -U100' -- netstat -sp ip

        watchdiff --nodate --nonewline --count=18 --interval=10 date

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
