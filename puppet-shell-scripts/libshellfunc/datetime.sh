##############################################################################
# name: datetime.sh
# description: Helperfunctions for working with date and time.
##############################################################################

# Returns the current time formatted as: 00:00:00 +/-0000
# Calling `now` will give you the time at which `now` was called so every
# call to now will result in a different time contrary to setting it as a
# variable when the srcipt is sourced.
now () {
    date +'%H:%M:%S %z'
}
