#!/usr/bin/env bash
#######################################################################################################################
#
#   >>> Sample bash code which tests for a valid ipv4
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

isValidIPv4() {
   local -a nibbles # array of the nibbles

   IFS="." read -r -a nibbles <<<"$1" # read the text and split by "." into array

   if ((${#nibbles[@]} != 4)); then # IPv4 has to have 4 nibbles
      error "ERROR: $1: 4 Nibbles required" ""
      return 1
   fi

   for nibble in "${nibbles[@]}"; do # now check all nibbles for an integer
      if ! isInteger "$nibble"; then
         error "ERROR: $1: $nibble is not a valid nibble" ""
         return 1
      fi
      if ((nibble < 0 || nibble > 255)); then # and >= 0 and <= 255
         error "ERROR: $1: $nibble is < 0 or > 255" ""
         return 1
      fi
   done
}

# private networks
#
#   10.0.0.0 – 10.255.255.255 (Klasse A)
#   172.16.0.0 – 172.31.255.255 (Klasse B)
#   192.168.0.0 – 192.168.255.255 (Klasse C)
#   169.254.0.0 – 169.254.255.255 (Link-Local)

isLocalIPv4() { # check whether the IPv4 is a private network

   if ! isValidIPv4 "$1"; then
      error "ERROR: $1 is no valid IPv4" ""
   fi

   local -a nibbles

   IFS="." read -r -a nibbles <<<"$1"

   case "$1" in

   10.* | 172.16.*)				# | is a pattern separator to catch two subnets in one match
      return 0
      ;;
   192.168.*)					# More readable pattern without |
      return 0
      ;;
   169.254.*)
      return 0
      ;;
   *)
      return 1
      ;;
   esac

}

testIPv4() {
   if isValidIPv4 "$1"; then
      if isLocalIPv4 "$1"; then
        echo "INTERN: $1"
      else
         echo "EXTERN: $1"
      fi
   fi
}

if (($# != 0)); then
   testIPv4 "$1"
else
   ips="10.9.8.5 192.168.8.9 172.16.5.6 169.254.5.6 \
  192.169.4.3 172.17.3.4 1.2.3.4 -4.6.7. 1.2.k.3 1.2.3.500" # small test
   for ip in $ips; do
      testIPv4 "$ip"
   done

fi
