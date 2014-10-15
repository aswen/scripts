##############################################################################
# name: exit.sh
# description: Function to execute a command and check if it was succesful.
##############################################################################

# This function will execute the string that it was passed as first argument
# and caputre the exitcode.
#
# Parameters:
#  ${1}: the command to execute
#  ${2}: the message to return on failure
#  ${exitcode}: the exitcode we're expecting, defaults to 0
#  $(exit_with): if we are to exit with the failed commands exitcode, defaults to false
check_exit () {
    # Check if we were passed at least 2 argument.
    if test $# -lt 2; then
        error "Need at least the command and log message passed."
        # If we call exit here we'd exit the complete environment, this just
        # returns to the rest of the script may continue running.
        return
    fi

    # Assign the first two arguments to meaningful variables
    command=${1}
    message=${2}
    # Remove the first two arguments
    shift 2
    # Create local variables for every other argument
    local $*

    # Check if exitcode was passed to us.
    if test -z "$exitcode"; then
        typeset -ri exitcode=0
    fi

    # Check if exit_with was passed to us.
    if test -z "$exit_with"; then
        typeset -r exit_with="false"
    fi

    # If we're debugging, capture the output and possible errors.
    if test ${LIBSF_DEBUG} -eq 1; then
        output=$($command 2>&1)
        typeset -ri return_code=$?
    # If not, throw the output away
    else
        eval $command > /dev/null 2>&1
        typeset -ri return_code=$?
    fi

    # When the exitcodes don't match up
    if test ${return_code} -ne ${exitcode}; then
        # If we're debugging, just call debug with the output
        if test ${LIBSF_DEBUG} -eq 1; then
            debug "Output was: ${output}"
        # If we're not debugging
        else
            if test ${exit_with} != "false"; then
                error "${message}" ${return_code}
            else
                warn "${message}"
            fi
        fi
    fi
}
