# bash bootcamp exercises

## General

1. Verify all user input
1. Write short error message to stderr with helper function in case of an error
1. Place helper functions in function.sh and source it
1. Use `shellcheck -x <filename>` and correct any findings
1. Follow standard C/C++ identation rules
1. Execute `shellcheck [!b]*.sh 2>/dev/null && echo "*** OK ***" || echo "??? Fail ???"` to check all scripts

## Exercises

* [countfiles.sh](https://github.com/pmarf/bashBootcamp/blob/main/countfiles.sh)

  Count number of files with a given extension in a directory tree passed as first argument and accept second argument for the search mask of find

  `countfiles.sh [directory] [searchmask]?`

  * Example
    ```
    countfiles.sh ~/bashBootcamp
    countfiles.sh ~/bashBootcamp *.jpg
    ```
  * Default searchmask: `*.sh`
  * Hints: Use find and wc
  * Challenge: Extend the script to find all files with an extension (default jpg) and extract the exif information, use identify tool from the imagemagick package (sudo apt install imagemagick)


* [countchars.sh](https://github.com/pmarf/bashBootcamp/blob/main/countchars.sh)

  Count number of chars in a file and read filename from user and print the 10 most frequent chars with their percentage

  `countchars.sh [filename]`

  * Hints: Use read, associative array, sort, head and use bash calculations
  * Challenge: Allow script to accept input from stdin if no filename is passed as first argument via pipe
     ```
     countchars.sh filename => read from file filename without prompt, test: "countchars.sh countchars.sh"
     countchars.sh => read from console, test: "countchars.sh", enter some data and end input with <CTRL D>
     countchars.sh < filename => read from file filename (filename is used in stdin), test: "countchars.sh < countchars.sh"
     cat countchars.sh | countchars.sh => read from pipe
     ```

* [substdigits.sh](https://github.com/pmarf/bashBootcamp/blob/main/substdigits.sh)

  Read a file and replace digits 0-9 with their textual representation

  `substdigits.sh [filename]`

   * Hints: Use read, associative array, here doc

* [fibonacci.sh](https://github.com/pmarf/bashBootcamp/blob/main/fibonacci.sh)

  Accept one parameter and calculate fibonacci numbers iterativ and recursive

  `fibonacci.sh [number]?`

  * Default: If no argument is passed calculate fibonacci numbers for 0,5,10,15 and 20
  * Hints: Use isInteger to check input

* [findactivedevices.sh](https://github.com/pmarf/bashBootcamp/blob/main/findactivedevices.sh)

  Scan local net for active systems and print their DNS name and IP address

  `findactivedevices.sh [local ipv4 network] like 192.168.0.0/24 or 192.168.178.0/24`

  * Hints: Use `map -sP "$1"` to scan network, use associative arrays and grep, use printf to enhance output format
  * Challenge: Accept an addtional option `-i` and `-n` and sort list according ip addresses or dns names
     **Note:** sort ips not alphabetically (default of sort command) but numerically

* [testipv4.sh](https://github.com/pmarf/bashBootcamp/blob/main/testipv4.sh)

  Accept one parameter as an IPv4 address and check if is valid
  If no ipv4 is passed test 10.9.8.5 192.168.8.9 1.2.3.4 -4.6.7. 1.2.3.500 169.253.0.0

  `testipv4.sh [ipv4]?`

   * Hints: Use indexed array, carefully test ipv4 with function isInteger, change IFS to "." to split nibbles
   * Challenge: Test if ip address is member of a private network, use switch statement with bash patterns

```
   --- private networks ---

   10.0.0.0 – 10.255.255.255 (Class A)
   172.16.0.0 – 172.31.255.255 (Class B)
   192.168.0.0 – 192.168.255.255 (Class C)
   169.254.0.0 – 169.254.255.255 (Link-Local)
  ```

* [weatherin.sh](https://github.com/pmarf/bashBootcamp/blob/main/weatherin.sh)

  Retrieve weather information for a city

  `weatherin.sh [City]`

  * Default: Read cityname argument, if no argument retrieve values for a list of cities `Hamburg Berlin Frankfurt Muenchen Kiew Peking`
  * Hints: Use curl, https://nominatim.openstreetmap.org https://api.open-meteo.com to retrieve data, use regular expressions
      use READONLY for URL locations of a city and temperature et al
  * Challenge: Use jq instead of grep to extract data from json doc returned by api calls

* [highlow.sh](https://github.com/pmarf/bashBootcamp/blob/main/highlow.sh)

  High low game

  `highlow.sh [demo|number]?`

   * Default: range 0-100, first parameter defines the upper bound, demo starts a computer demo
   * Hints: Use RANDOM, use isInteger function to check for valid input
   * Challenge: Accept option `demo` and have the script to find the number with binary search,
       when user trial finishes let script use the binary search and compare number of trials of human and computer

* [functions.sh](https://github.com/pmarf/bashBootcamp/blob/main/functions.sh)

  Sourced file with helper functions and debug enhancement definition

```
loc --by-file [!b]*.sh
      10 text files.
      10 unique files.
       0 files ignored.

github.com/AlDanial/cloc v 1.98  T=0.01 s (1419.1 files/s, 106429.2 lines/s)
----------------------------------------------------------------------------------
File                                blank        comment           code
----------------------------------------------------------------------------------
highlow.sh                             15             23             81
weatherin.sh                           19             22             72
testipv4.sh                            16             28             59
findactivedevices.sh                   16             24             53
fibonacci.sh                           10             22             48
countchars.sh                          14             22             37
substdigits.sh                          6             22             37
countfiles.sh                          11             23             22
functions.sh                            3             22             13
formatCode.sh                           3              1              6
----------------------------------------------------------------------------------
SUM:                                  113            209            428
----------------------------------------------------------------------------------
```
