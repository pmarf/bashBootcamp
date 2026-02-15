# Sample exercises and sample code for a bash bootcamp

## All scripts should

1. Verify all user input
1. Write short error message to stderr with helper function in case of an error
1. Place helper functions in function.sh and source it
1. Pass `shellcheck -x <filename>` without error messages

## Final test
* `shellcheck [!b]*.sh 2>/dev/null && echo "*** Verything passes checkshell ***" || echo "??? Some scripts fail checkshell ???"`

## Sample exercises

* [countfiles.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/countfiles.sh)

  Count number of files with a given extension in a directory tree
  ```
  countFiles.sh [directory] [extension]
  Default extension: *.sh
  Hints: Use find and wc
  ```

* [countchars.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/countchars.sh)

  Count number of chars in a file and print the 10 most frequent chars with thir percentage
  ```
  countchars.sh [filename]
  Hints: Use read, associative array, sort, head and use bash calculations
  Challenge: Allow script to accept input from stdin
  ```

* [substdigits.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/substdigits.sh)

  Replace digits 0-9 with their textual representation
  ```
  substdigits.sh [filename]
  Hints: Use read, associative array, here doc
  ```

* [fibonacci.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/fibonacci.sh)

  Calculate fibonacci numbers iterativ and recursive
  ```
  fibonacci.sh [number]?
  Default: If no argument is passed calculate fibonacci numbers for 0,5,10,15 and 20
  ```

* [findactivedevices.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/findactivedevices.sh)

  Scan local net for active systems and print their DNS name and IP address
  ```
  findactivedevices.sh [local ipv4 network] like 192.168.0.0/24 or 192.168.178.0/24
  Hints: Use `map -sP "$1"` to scan network, use associative arrays and grep, use printf to enhance output format
  Challenge: Accept an addtional option `-i` and `-n` and sort list according ip addresses or dns names, Note: sort ips not alphabetically (default) but numerically
  ```

* [testipv4.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/testipv4.sh)

  Test if an IPv4 is valid and local or external
  ```
  testipv4.sh [ipv4]?
  If no ipv4 is passed test 10.9.8.5 192.168.8.9 1.2.3.4 -4.6.7. 1.2.3.500 169.253.0.0
  Hints: Use indexed array, carefully test ipv4 with function isInteger
  Challenge: Test if ip address is member of a private network, use switch statement

  # private networks

   10.0.0.0 – 10.255.255.255 (Klasse A)
   172.16.0.0 – 172.31.255.255 (Klasse B)
   192.168.0.0 – 192.168.255.255 (Klasse C)
   169.254.0.0 – 169.254.255.255 (Link-Local)

  ```

* [weatherin.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/weatherin.sh)

  Retrieve weather information for a city

  ```
  weatherin.sh [City]
  Default: Read cityname argument, if no argument retrieve values for a list of cities `Hamburg Berlin Frankfurt Muenchen Kiew Peking`
  Hints: Use curl, https://nominatim.openstreetmap.org https://api.open-meteo.com to retrieve, use READONLY for URLs
  location of a city and temperature et al
  Challenge: Use jq instead of grep to extract data from json doc returned by api calls
  ```

* [highlow.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/highlow.sh)

  High low game

```
  highlow.sh [demo|number]?
  Default: range 0-100, first parameter defines the upper bound, demo starts a computer demo
  Hints: Use RANDOM, use isInteger function to check for valid input
  Challenge: Accept option `demo` and have the script to find the number with binary search,
  when user trial finishes let script use the binary search and compare number of trials of human and computer
```

* [functions.sh](https://github.com/pmarf/bashBootcampSamplecode/blob/main/functions.sh)

  Sourced file with some helper functions and debug enhancement definition

```
github.com/AlDanial/cloc v 1.98  T=0.01 s (696.3 files/s, 55164.8 lines/s)
----------------------------------------------------------------------------------
File                                blank        comment           code
----------------------------------------------------------------------------------
highlow.sh                             15             23             81
weatherin.sh                           19             22             74
testipv4.sh                            17             28             65
findactivedevices.sh                   16             24             51
fibonacci.sh                           11             22             42
substdigits.sh                          6             22             37
countchars.sh                          11             22             32
functions.sh                            3             22             13
countfiles.sh                           4             23              8
----------------------------------------------------------------------------------
SUM:                                  102            208            403
----------------------------------------------------------------------------------
```
