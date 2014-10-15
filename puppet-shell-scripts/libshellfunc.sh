##############################################################################
# name: libshellfunc.sh
# author: Daniele Sluijters (daenney)
# version: 0.1
# description: Provides a bunch of (useful) function that can be used in
#              shell scripts. It aims to be ZSH and Bash compatible.
##############################################################################

# Figure out where we're being called from
DIR="$( cd "$( dirname ${BASH_SOURCE:-$0} )" && pwd )"

# Source all our components
source $DIR/libshellfunc/globals.sh
source $DIR/libshellfunc/datetime.sh
source $DIR/libshellfunc/colour.sh
source $DIR/libshellfunc/logging.sh
source $DIR/libshellfunc/exit.sh
source $DIR/libshellfunc/inarray.sh
