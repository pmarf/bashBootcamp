#!/bin/bash
#######################################################################################################################
#
#   >>> Example how globbing works
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

glob() {
   echo "Script called with following $(($# - 1)) arguments:" # $0 is the script name
   for ((i = 1; i <= $#; i++)); do                            # Processs al parameters
      echo "Arg $i: ${!i}"
   done
}

# Try to find bashBootcamp dir and use current dir otherwise
echo "Trying to find bashBootcamp directory"
if ! bootcampPath=$(find  ~ -iname bashBootcamp -type d | head -1); then
	echo "Not found. Use currect directory"
	bootcampPath="."
fi

echo "Calling function with quotes \"*.sh\""
glob "$bootcampPath/*.sh"
echo "Calling function without quotes *.sh"
glob $bootcampPath/*.sh
