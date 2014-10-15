##############################################################################
# name: colour.sh
# description: Sets up variables that are used to colourise output.
##############################################################################

if tty -s;then
    typeset -r RED=${RED:-$(tput setaf 1)}
    typeset -r  GREEN=${GREEN:-$(tput setaf 2)}
    typeset -r YLW=${YLW:-$(tput setaf 3)}
    typeset -r BLUE=${BLUE:-$(tput setaf 4)}
    typeset -r PURPLE=${URPLE:-$(tput setaf 5)}
    typeset -r CYAN=${CYAN:-$(tput setaf 6)}
    typeset -r WHITE=${WHITE:-$(tput setaf 7)}
    typeset -r RESET=${RESET:-$(tput sgr0)}
    typeset -r BOLD=${BOLD:-$(tput bold)}
    typeset -r UNDER=${UNDER:-$(tput smul)}
    typeset -r NOUNDER=${NOUNDER:-$(tput rmul)}
else
    typeset -r BLD=
    typeset -r RED=
    typeset -r GREEN=
    typeset -r YLW=
    typeset -r BLUE=
    typeset -r PURPLE=
    typeset -r CYAN=
    typeset -r WHITE=
    typeset -r RESET=
    typeset -r BOLD=
    typeset -r UNDER=
    typeset -r NOUNDER=
fi
