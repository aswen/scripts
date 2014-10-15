##############################################################################
# name: globals.sh
# author: Daniele Sluijters (daenney)
##############################################################################

# @function: debug()
# @intent: If calls to debug() should result in output on the screen.
typeset -i LIBSF_DEBUG=${LIBSF_DEBUG:-0}

# @function:  log()
# @intent: At what number of characters lines should be wrapped.
typeset -i LIBSF_JUSTIFY=${LIBSF_JUSTIFY:-78}
