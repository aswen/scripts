#!/bin/bash
# <SCRIPTNAME>
# <WHAT DOES THIS SCRIPT DO?>

# Copyright (C) 2014-2015 Alexander Swen <alex@swen.nu>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Alexander Swen
# Private contact: alex@swen.nu

# CHANGELOG:
# <DATE>	A.Swen	created.

# SETTINGS
date=$(date +%Y%m%d)
me=$(basename $0)
mydir=$(dirname $0)


# FUNCTIONS
die () {
  rc=$1
  shift
  printf '%s\n' "=====================" >&2
  printf '%s\n' "==== FATAL ERROR ====" >&2
  printf '%s\n\n' "=====================" >&2
  printf '%s\n\n' "$@" >&2
  exit $rc
}

usage () {
  printf '%s\n' "===============" >&2
  printf '%s\n' "==== USAGE ====" >&2
  printf '%s\n\n' "===============" >&2
  printf '%s\n' "Usage: ${me} " >&2
  printf '%s\n\n' "example: ${me} " >&2
  exit 1
}
get_options () {
  [ $# -gt 0 ]||usage
  while getopts "u:" opt;do
    case ${opt} in
      u) export user=`echo ${OPTARG}` ;;
      *) usage;;
    esac
  done
}

duration () {
  local before=$1
  local after="$(date +%s)"
  local elapsed="$(expr $after - $before)"
  local hours=$(($elapsed / 3600))
  local elapsed=$(($elapsed - $hours * 3600))
  local minutes=$(($elapsed / 60))
  local seconds=$(($elapsed - $minutes * 60))
  time_running="${hours}:${minutes}:${seconds}"
}

log () { printf '%s %s\n' "$(date +%F' '%T)" "$@"; }

log_msg () {
  duration ${before_total}
  message="$1"
  echo "${time_running} $1"|tee -a ${short_log}
}

# SCRIPT
before_total="$(date +%s)"
[ ${UID} -gt 0 ] && die 1 "Only root may do that."
log_msg "$(date) started ${me}"
# get_options $@


duration ${before_total}
log_msg "Total time taken: ${time_running}"
log_msg "$(date) finished"
# END
