#!/usr/bin/env bash
#######################################################################################################################
#
#   >>> Sample implementation for bash bootcamp exercise countchars.sh
#   >>> which counts characters in a file and prints the 10 most frequent characters
#
#######################################################################################################################
#
#    Copyright (c) 2026 https://github.com/pmarf
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#######################################################################################################################

source functions.sh # source helperfunctions

declare -A frequency # dictionary which hols the count of every char

if [[ -n "$1" ]]; then # filename was passed as first argument, read from this file
   exec < "$1"

elif [[ ! -t 0 ]]; then # stdin already connected, do nothing
   :

else # no pipe input, ask user for filename
   read -rp "Enter filename: " filename

   if [[ ! -f "$filename" ]]; then
      echo "Error: file not found" >&2
      exit 1
   fi

   exec < "$filename"
fi

sumchars=0

while IFS= read -r line; do             # process every line of file (don't split and ignore space and tab, NLs are ignored)
   for ((i = 0; i < ${#line}; i++)); do # process every char in line
      ((sumchars++))                    # increase sum counter to have number of all chars read
      char=${line:i:1}
      ((frequency[$char]++)) 		# increase counter (if element is undefined it's considered 0)
   done
done

echo "Sum chars: $sumchars"

sortfilename="$(mktemp)"                                  # create a temporary filename in /tmp
for char in "${!frequency[@]}"; do                        # loop over all keys/chars
   count="${frequency[$char]}"                            # retrieve the count
   ((frequency = (count * 100) / sumchars))               # calculate frequency
   asciinumber=$(printf "%02X" "\"$char")                              # get ascii representation of char in hex
   echo "${frequency} $count '$char' ($asciinumber)" >>"$sortfilename" # append result to temporary file
done

sort -r -n -k1 -k2 "$sortfilename" > "${sortfilename}2" # sort temporary file

head -n 10 "${sortfilename}2" # print first 10 chars

rm "${sortfilename}"* # cleanup
