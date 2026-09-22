#!/usr/bin/env bash
#######################################################################################################################
#
#   >>> Sample implementation for bash bootcamp exercise fibonacci.sh
#   >>> which calulates the fibonacci number recursive and interative
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

source functions.sh # include helperfunctions

fibo_r() {
   local fm1 fm2 result
   if (($1 <= 0)); then
      echo "0"
   elif (($1 <= 2)); then
      echo "1"
   else
      ((fm1 = $1 - 1))
      fm1="$(fibo_r "$fm1")"
      ((fm2 = $1 - 2))
      fm2="$(fibo_r "$fm2")"
      ((result = fm1 + fm2))
      echo "$result"
   fi
}

fibo_i() {
   local fm1=0 fm2=1 t
   for ((i = 0; i < $1; i++)); do
      ((t = fm1))
      ((fm1 = fm2))
      ((fm2 = t + fm2))
   done
   echo "$fm1"
}

fibonacci() { # number

   local result

   if (($# == 0)); then
      error "Missing number"
   fi

   if (($1 < 0 || $1 > 20)); then
      error "Number $1 out of bounds"
   fi

   result=$(fibo_i "$1")
   echo -n "$1! = $result (iterative)"
   echo

   result="$(fibo_r "$1")"
   echo -n "$1! = $result (recursive)"
   echo

}

if (($# != 0)); then
   if ! isInteger "$1"; then
      error "Invalid integer $1"
   else
      fibonacci "$1"
   fi
else
   for i in $( # some tests
      seq 0 5 15
   ); do
      fibonacci "$i"
   done
fi
