#!/bin/bash
# shelters-html-to-kml.sh
# Scrapes all shelters from Swedish shelter page

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
# 20220719	A.Swen	created.

# SETTINGS
date=$(date +%Y%m%d)
me=$(basename $0)
mydir=$(dirname $0)
shelter_list_url='https://vindskyddskartan.se/en/places/Sweden'

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

log () { printf '%s %s\n' "$(date +%F' '%T)" "$@"; }

# SCRIPT

# To get an index file:
#curl "$shelter_list_url" | grep -EA2 '<td><a href="/en/places/[0-9]+/' > Sweden.list
# VIM: :%s?<td><a href="\(/en.*\)">\(.*\)</a></td>\n\s*<td>\(.*\)</td>\n\s*<td><a.*>\(.*\)</a></td>\n--?\2;\4;\3;\1?

# Use the index to download all files from the site
# IFS=';';total=$(wc -l <../Sweden.list );count=0;while read name loc state uri;do count=$((count+1));nr=${uri#/en/places/};nr=${nr%/*};printf '%d/%d: Name: %s\n' "$count" "$total" "$name" ;curl -s "https://vindskyddskartan.se$uri" > "${name/\// }_$nr.html";done < Sweden.list

IFS=';'
printf '%s\n' '<?xml version="1.0" encoding="UTF-8"?>'
printf '%s\n' '<kml xmlns="http://earth.google.com/kml/2.0">'
printf '%s\n' '<Document>'
printf '%s\n' '<name>Shelters in Sweden</name>'
while read name loc state uri;do
  clean_name=$(echo $name|sed -e 's?"??g' -e 's?&??g')
  longitude=${loc##*,}
  latitude=${loc%%,*}
  nr=${uri#/en/places/};nr=${nr%/*}
  file="${name/\// }_$nr.html"
  printf '<Placemark>\n<name>%s</name>\n<description>\n' "$clean_name"
  grep -hE 'placeCheckboxProperty|placeValueProperty|<br />|</p>' "$file"|\
    grep -vE '<p>|^<br />|^</p>'|\
    sed -e 's?<p class="placeDescription  mt-3 mb-3">?Information: ?'\
      -e 's?</p>??g'\
      -e 's?<span class="placeCheckboxProperty">?+ ?'\
      -e 's?</span>??g'\
      -e 's?<span class="placeValueProperty">?+ ?'\
      -e 's?</div>??g'\
      -e 's?<br />??g'\
      -e 's?&quot;?"?g'\
      -e 's?&amp;?and?g'\
      -e 's?&?and?g'\
      -e 's?"??g'\
      -e 's?&#039;?'"''"'?g'\
      -e 's?<a href.*</a>??g'
  printf '</description>\n<Point>\n<coordinates>%s,%s,0</coordinates>\n</Point>\n<styleUrl>#placemark-%s</styleUrl>\n</Placemark>\n' "$longitude" "$latitude" "purple"
done < ../Sweden.list
printf '</Document>\n</kml>\n'

# END
