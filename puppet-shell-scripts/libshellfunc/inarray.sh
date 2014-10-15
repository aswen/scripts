##############################################################################
# name: inarray.sh
# description: Test if an array contains an element similar to var
##############################################################################

# Returns true of (part of var) is in array
# usage: inarray "$value" "${array[@]}"

inarray() {
  local n=$1 h
  shift
  for h do
    [[ $n =~ "$h" ]] && return
  done
  return 1
}
