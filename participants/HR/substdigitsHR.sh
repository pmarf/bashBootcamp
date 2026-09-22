#!/bin/bash 

# bash script substdigitsHR.sh to replace given char-patterns by others
# special solution for substdigits.sh in https://github.com/pmarf/bashBootcamp/blob/main/README.md 
# script generates new, dedicated script to efficiently  do the replacement
# author : hr
# vers 2026-09-16

echo "### running " $0

while IFS='=' read -r digit text; do # fill dictionary with text
   if [[ -z $digit ]]; then
      continue # skip empty lines
   fi
   TT["$digit"]="$text"
done << 'EOF'
0=zero
1=one
2=two
3=three
4=four
5=five
6=six
7=seven
8=eight
9=nine
EOF

echo ### pattern read:

for k in "${!TT[@]}"; do
    echo $k ' : ' ${TT["$k"]}
done 

echo ### generating script to run

# header + start of sed
echo "#!/bin/bash " > "$1".run
echo "# =================================" >> "$1".run
echo "# starting $1.run with input $1" >> "$1".run
echo "# =================================" >> "$1".run
echo "echo -n 'Datei: ';ls -l  $1" >> "$1".run 
echo "echo -n 'Start: '; date" >> "$1".run 
echo 'sed -E "{' >> "$1".run

# sed substitutions
for k in "${!TT[@]}"; do
    echo "         s|"$k"|${TT["$k"]}|g;" >> "$1".run
done 

# end of sed command with input output file
echo '}" ' "$1" '>' "$1".rep >> "$1".run
echo "echo -n 'Ende : '; date" >> "$1".run 
echo "echo -n 'Neu  : ';ls -l  $1.rep" >> "$1".run 

# make script executable
chmod +x "$1".run

# show generated file
echo '-------------------------------'
echo "### this script was generated as" "$1".run
echo '-------------------------------'
cat "$1".run
echo '-------------------------------'

read -rp "run script now (y/n) " ans

if [[ "$ans" == y ]]; then
   echo running script "$1".run 
   source "$1".run
else
   echo you can run generated script by typing '"'"$1".run'"' in the shell
fi


