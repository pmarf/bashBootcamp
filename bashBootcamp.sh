#!/bin/env bash
#
# bash programming bootcamp
#
# Copyright (c) 2026 https://github.com/pmarf
#
# References
#
# - GNU bash manual: https://www.gnu.org/software/bash/manual/
# - Bash beginners guide: https://tldp.org/LDP/Bash-Beginners-Guide/Bash-Beginners-Guide.pdf
# - Advanced scripting guide: https://tldp.org/LDP/abs/html/
# - Deutsch: www-user.tu-chemnitz.de/~hot/unix_linux_werkzeugkasten/bash.html
# - Bash Scripting Exercises and Solutions: https://www.w3resource.com/bash-script-exercises/index.php
# - man bash
# - man bash-builtin
#
# - Gutes Checktool (linter) für bash: shellcheck
#	sudo apt install shellcheck
#	https://github.com/koalaman/shellcheck/wiki/<shellcheckmessageid> liefert eine detailierte Beschreibung
#       zu der Meldungsnummer und warum die Meldung geschrieben wurde und wie sie zu beseitigen ist
#
# - Formatierungstool
#   shfmt -i 3 *.sh (sudo apt install shfmt)
#
# - Hilfe
#   Zu den meisten Befehlen gibt es eine direkte Hilfe mit man <Befehl>, z.B. man ls
#   Ausserdem gibt es help <builtin command> wie z.B. help echo, help printf, help export
#
# Ausserdem helfen Suchmaschinen wie auch Tools wie chatGPT

###########################################################################################
#
# ### Navigation und bash Basics ###
#
###########################################################################################

if [[ "$*" =~ topics|all ]]; then
	echo
	echo ">>> bash bootcamp topics <<<"
	echo
	grep -E '# >>> .+ <<<' $0 | grep -v "grep"
	echo
fi
if [[ "$*" =~ homework|all ]]; then
	echo ">>> bash bootcamp homework <<<"
	echo
	for file in  [!b]*.sh; do
		echo "--- $file ---"
		grep ">>>" $file
	done
	echo
	set -v
	cloc --by-file [!b]*.sh
	set +v
fi
if [[ "$1" =~ \-([?h]|\-help) ]]; then
	echo "$0: [topics|homework|all]"
	exit
fi
if (( $# > 0 )); then
	exit 0
fi

# Kommentare beginnen mit # an beliebiger Stelle. Alles folgende wird ignoriert
# Zeilenfortsetzung mit \ als letztes Zeichen in einer Zeile

echo "Das ist eine\
         Demo der Zeilenfortsetzung mit vielen Spaces"

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Tastatur Quickies <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# <TAB> expandiert bei Dateinamen soweit wie möglich und zeigt die restlichen Alternativen an
# <CTRL R> text, sucht in der bash History nach dem text
# <ARROW UP/DOWN> blättert in der bash History

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Verzeichnisse <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# FSH - file system hierarchy

/bin - Binärdateien/Befehle
/dev - Gerätedateien
/etc - Systemkonfigurationsdateien
/lib - Bibliotheken
/media - Mountpoint für Wechseldatenträger
/mnt - Temporär eingehängtes Dateisystem
/opt - Anwendungsprogramme
/sbin - Binärdateien für das System
/tmp - Temporäre Dateien
/home - Stammverzeichnis aller Nutzerverzeichnisse
/root - Stammverzeichnis von root

# Ein Verzeichnisbaum besteht aus durch / getrennte Namen
# Steht / am Anfang ist es ein absoluter Name. Ohne / ist es ein relativer Name

# Anzeige aller Nutzerverzeichnisse
ls /home

# Mit cd wechselt man in ein Verzeichnis
# Mit einem ; werden mehrere Befehle getrennt
cd /home; ls -la
# oder ein Verzeichnis nach oben
cd ..
# Heimatverzeichnis ist ~ und das aktuelle Verzeichnis ist .
cd ~
ls -la .

# Erzeugen eines Verzeichnisses
mkdir Unterverzeichnis1
mkdir Unterxerzeichnis2
mkdir Unterxerzeichnis3
# Löschen eines leeren Verzeichnisses
rmdir Unterverzeichnis3
# Löschen eines Verzeichnisses mit Inhalt
# rm -rf <Verzeichnis>

# Verzeichnis- und Dateirechte
# -rwxrwxr-x 1 peter peter 1484 Feb  2 17:36 bashBootcamp.sh
# 3 verschiedene Zugriffsgruppen: Owner, Guppe und alle
# 3 Verschiedene Berechtigungen: Schreiben (r), lesen (r) und execute(x)
# Owner und Gruppe
# Größe in Bytes
# Änderungsdatum
# Name

ls -la bashBootcamp.sh
chmod +x bashBootcamp.sh # setzen des executebits

# >>> Globbing <<<
#
# Globbing bezeichet die Expandierung von Wildcards vor der Befehlsausführung mit Patterns
# * beliebige Zeichen, ? exakt ein Zeichen, [a-z] Character class
# Anzeige aller Dateien im aktuellen Verzeichnis die mit bash beginnen
# Achtung auf Sonderzeichen
ls ./bash*
ls *.sh
ls Unter[xv]erzeichnis
ls Unter?erzeichnis
rmdir Unterverzeichnis1
rmdir Unterxerzeichnis2

# >>> Text splitting <<<

# Texte werden gemäß des Separators IFS zerlegt. Standard ist Space, Tab und LF
text="eins zwei drei"

echo "$text"
for word in $text; do
  echo "$word"
done
# Achtung !
for word in "$text"; do
  echo "$word"
done
# macht kein Text splitting - wichtig bei Variablennutzung in Scripts diese in " ... " zu schreiben

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Suchpfade <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Ausgabe des aktuellen Suchpfades
echo $PATH
# bash Umgebungsvoreinstellung
# Die Datei ~/.bashrc wird beim Öffnen des Commandwindows ausgeführt
# und ermöglicht so alle möglichen Dinge voreinzustellen
# wie z.B. den Pfad um ein eigenes Verzeichnis mit shell Scripts immer zu erreichen
# Mit dem Doppelpunkt wird der Suchpfad um Verzeichnisse erweiter

# Also zuerst ein bin Verzeichnis erstellen
mkdir ~/bin
# und dann die Datei ~/.bashrc editieren und
export PATH=$PATH:~/bin # in .bashrc aufnehmen
# Ansonsten muss immer der ganze Pfad angegeben werden bzw ./bashBootcamp.sh wenn das Script im aktuellen Verzeichnis steht

# Suchen wo sich ein Script im Suchpfad befindet
which ./bashBootcamp.sh

# Ausgabe des cd Suchpfades
echo $CDPATH
# Default ist
#  export CDPATH=.
# Beispielerweiterung in .bashrc
# export CDPATH=.:~/myProject

# Ausgabe aller bekannten exports
env

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Pipes <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Mit pipes können Kommandoausgaben in ein weiteres Kommando weitergereicht werden. Typisch unter Linux. So können Oneliner entstehen wo mehrere Linux Tools hintereinander aufgerufen werden
# Die Ausgabe von einem Kommando (stdout) wird die Eingabe (stdin) von dem folgenden Befehl Fehlermeldungen werden auf stderr geschrieben

ls ~ | grep -i boot*
# Alternativ und besser
ls *Boot*

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Häufig genutzte Linux Kommandos <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# man <command> oder <command> --help liefert detailierte Info mit allen Optionen

# cat - concatenate - Dateien aneinanderhängen
# cp - Kopieren von Dateien
# cut - Selektion von Teilen einer Textzeile
# exec - Ausführen von Befehlen in keiner Subshell sondern Ersetzung der aktuellen shell
# find - Suchen nach Dateien oder Verzeichnissen
# grep - Suche nach Dateien mit einem bestimmten Inhalt
# head - Anfang von Dateien anzeigen
# less - Scrollfähige Anzeige von Dateien
# locate - Suche nach Dateien mit der Datenbank locatedb
# ls - Listen von Dateinverzeichnissen
# man - Hilfetext anzeigen
# mv - Dateien moven
# rename - Umbenennen von Dateien
# rm - Dateien löschen
# rsync - Dateisynchornisation
# script - Terminalsitzung in einer Datei mitschneiden
# sed - Niciht interaktiver Zeileneditor
# sleep - Pausieren
# sort - sortieren von Dateiinhalten
# sudo - temporäres Ausführen von Befehlen als root
# tail - Ende von Dateien Anzeigen
# tr - Umwandeln von Zeichen
# tree - Verzeichnisstruktur rekursiv anzeigen
# wc - Zählen von Zeichen, Zeilen
# xargs - Liest Daten von stdin und führt Befehle mit diese Argumenten aus

# typische Nutzung von pipes

# Zählen wie viele Trennkommentare in einer Datei sind
grep "#>>>>>>>" ./bashBootcamp.sh | wc -l
# Zähle wie viele Shellscripts es gibt
find -iname "*.sh" | wc -l
# Suche in allen shell scripts nach dem Text "if" aber nicht kniff o.ä.
find -iname "*.sh" | xargs grep -H "\bif\b" | grep wc -l
# oder
find -iname "*.sh" -exec grep -H "\bif\b" '{}' \; | wc -l

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Redirections <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Kommandein- und Ausgaben können redirected werden. Üblicherweise sind das Ein- und Ausgabedateien

# Ausgabe
# stdout bzw 1 ist normaler Ausgabekanal, stderr bzw 2 ist Fehlerausgabekanal
# Bei pipes wird von stdin gelesen und auf stdout geschrieben
# > ist Kurzform von 1>
ls > ls-datei
# Eingabe - zählt Zeilen einer Datei
< bashBootcamp.sh wc -l
# Alternativ und besser
wc -l bashBootcamp.sh

# Sowohl stdout als auch stderr in eine Datei redirecten
ls 1> ls-datei 2>&1
# Achtung: Nicht umgekehrt
ls 2>&1 1>ls-datei
# Kurzform
ls &>ls-datei

# exec Nutzung um stderr und stdout generell in eine Datei umzuleiten

exec 1>>logfile
exec 2>&1

# oder gleich (Sowohl stdin als auch stderr werden redirected)

exec &>>logfile

# Schreiben in eine Datei
echo "Test" > datei
# Anhängen an eine Datei
echo "test" >> datei

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Returnwerte von Tools <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 0: Alles OK
# >0: Fehler, konkreter Grund findet sich üblicherweise in den man pages

# Berücksichtigung von Returnwerten

# Führe Befehl2 nur aus wenn Befehl1 erfolgreich war
ls ~ && ls /

# Führe Befehl2 aus wenn Befehl1 nicht erfolgreich war
ls /dummy || ls ~

# Funktionen: return <0-255>
# shellscript: exit <0-255>

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Besondere bash Variablen - Auswahl <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Aktuelles Vereichnis
echo "$PWD"
# Interner Feldseparator (Default: Space, tab und newline)
echo -n "$IFS" | xxd # Ausgabe in hex
# Suchpfad
echo "$PWD"
# Command prompt string
echo "$PS1"
# Aufrufargumente
echo "$1 $2 $3"
# Returnwert des letzten Script- oder Funktionsaufrufes
echo "$?"
# Anzahl Aufrufparameter eines Scripts
echo "$#"
# Script und Funktionsparameter als ein String
echo "$*"
# Script und Funktionsparameter als Array
echo "$@"

p() {
	echo "Anzahl Args: $#"
	for e in "$*"; do
		echo '$*'": -$e-"
	done
	for e in "$@"; do
		echo '$@'": -$e-"
	done
}
p "eins" "zwei" "drei"
# Achtung: " nutzen da sonst bash Word splitting erfolgt und das Ergebnis anders aussieht
p "eins zwei drei"

###########################################################################################
#
# ### Programmierung ###
#
###########################################################################################

# Verbreitete Editoren:
# - vim (cmdline)
# - nano (cmdline)
# - geany (desktop) <== Als Einstieg empfohlen
# - emacs (desktop)
# - vs code (IDE) (desktop)
# - mc (ternminal ui)
# - ...

# Kommentare
# Zeichen in einer separaten Zeile oder hinter einem Befehl

# Scripte müssen ausführbar sein
chmod +x bashBootcamp.sh

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Variablen <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Beginnen mit $ auf der rechten Seite und ohne $ auf der linken Seite und sind immer Strings
# Möglichst ${VARNAME} verwenden statt $VARNAME, ausser beim Rechnen mit Zahlen
VARIABLE1="Hello world"
VARIABLE2="${VARIABLE1}"
VARIABLE3=${VARIABLE1}
# Variablenwerte sollten möglichst immer in " eingeschlossen werden
# - Schutz vor word splitting (IFS variable definiert splitting char, default ist Leerzeichen, tab und newline)

f() {
	echo "$1 - Parms $#"
}
f 1q "$VARIABLE1"
f 1  $VARIABLE1
f 2q "$VARIABLE2"
f 2  $VARIABLE2
f 3q "$VARIABLE3"
f 3  $VARIABLE3

# - schutz vor globbing (wildcard Ersetzung)
VARIABLE1="*"
echo ${VARIABLE1} # gibt nicht * aus sondern die vorhandenen Dateien im aktuellen Verzeichnis
echo "${VARIABLE1}" # gibt * aus da kein globbing stattfindet

# Indirekte Adressierung über den Namen

declare -n ref=PTR
V1="VAR1"
PTR="V1"
echo "$PTR"
V2="VAR2"
PTR="V2"
echo "$PTR"

# Variablentypen
# - Normale Variable V=10 oder v="eins"
# - Liste - declare -a A; A=( 1 2 3 )
# - Assoziatives Array/Dictionary - declare -A AA; AA=( [eins]=1 [zwei]=2 ) # [key]=value

# Basis Syntaxelemente
# - Text: "Hello world" oder 'Hello world'
#   Bei " werden Sonderzeichen der bash interpretiert. Speziell das $ mit welchem Variablen beginnen. D.h. Variablennamem werden expandiert. Bei ' findet keine Interpretation statt
# - Zahlen: Nur ganze Zahlen
#   Zahlenbasen: 0x42 - hexadezimal, 042 - oktal

# Rechnen (keine $ notwendig ei Variablen)

i=0
(( i=i+1 ))
(( i++ ))

# Strings

s="hello"
b=" "
w="world"
s="$s$b$w"

# besser

s="${s}${b}${w}"

# Arbeiten mit Listen (zero based)

declare -a A=( "Aeins" "Azwei" "Adrei" "Avier" )

# Arbeiten mit assoziativen Arrays

declare -A AA=( [eins]=AAeins [zwei]=AAzwei )

# Zugriff auf Elemente (sowohl liste als auch dictionary)
echo "${AA["eins"]}"
echo "${A[0]}"
# Anzahl Elemente
echo "${#A[@]}"
echo "${#AA[@]}"
# Array Keys
echo "${!A[@]}"
echo "${!AA[@]}"
# Array elemente
echo "${A[@]}"
echo "${AA[@]}"
# Element löschen
unset "${A[2]}"
unset "${AA["eins"]}"

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> bash interne Funktionen <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Substring
V="Hello world"
echo "${V:7}"	# world
echo "${V:7:1}" # w

# Ersetzen
VV="${V/world/folks}"
echo "$VV"

# und diverse mehr

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Regular expressions <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if [[ "$VV" =~ ^folks ]]; then
	echo "String starting with folks"
else
	echo "String NOT starting with folks" # match
fi
if [[ "$VV" =~ folks ]]; then
	echo "String contains folks" # match
else
	echo "String does NOT contains folks"
fi

VV="Hello world and folks"
regex="^Hello ([a-zA-Z]+) .+ ([a-zA-Z]+)$"
if [[ $VV =~ $regex ]]; then
		world=${BASH_REMATCH[1]}
		folks=${BASH_REMATCH[2]}
fi
echo "$world $folks"

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Erste Zeilen eines bash Scriptes und debuggen <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Sicherstellen, dass der bash Interpreter aufgerufen wird für die Datei
#!/bin/env bash
# oder
#!/bin/bash
# oder expliziter Aufruf der bash
# bash ./bashBootcamp.sh

# set -x schaltet im Code den Debugmodus an und set +x schaltet ihn aus

# Einschalten des Debugmodes im ganzen Script
#!/bin/env -S bash -x
# oder
#!/bin/bash -x

# Alternativ Aufruf des Scripts mit bash -x <Scriptname>
bash -x ./bashBootcamp.sh

# Verbesserung der Debugausgaben mit Zeilennummern
declare -r PS4='|${LINENO}> \011${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> IF statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Vollständige Form

b=true
if $b; then
	echo "true"
else
	echo "false"
fi

# Es existieren mehrere syntaktische Formen
# Zu empfehlen ist nur folgende zwei Formen zu nutzen:
# Textvergleich
if [[ "a" == "b" ]]; then
	echo "Gleich"
else
	echo "Unleich"
fi
# Numerischer vergleich
if (( "3" == "4" )); then
	echo "Gleich"
else
	echo "Ungleich"
fi
# Alternative Syntax
# Numerischer Vergleich
# if [ "a" -lt "b" ]  ...fi
# String Vergleich
# if [ "a" = "b" ] ... fi
# if [ "a" < "b" ] ...fi

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Diverse weitere if tests <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if [[ -f bashBootcamp.sh ]]; then
	echo "Found script"
else
	echo "script not found"
fi

if [[ -d bashBootcamp.sh ]]; then
	echo "Is directory"
else
	echo "Is no directory"
fi

# Und und oder vergleiche

V1="eins"
V2="zwei"
if [[ "$V1" == "eins" && "$V2" == "zwei" ]]; then
	echo "Beide sind OK"
fi

if [[ "$V1" == "eins" || "$V2" == "eins" ]]; then
	echo "Eines ist eins"
fi

# WHILE statement

b=true
while $b; do
	echo "Loop"
	b=false
done

while read -r line; do
	echo "$line"
done < bashBootcamp.sh

while read -r client; do
	echo "$line"
done < <(map -sP 192.168.0.0/24)

# break terminiert eine Schleife

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> FOR statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

for e in "1 2 3"; do
	echo "$e"
done

# oder

for (( i=0; i<10; i++ )); do
	echo -n "$i"
done

# continue führt weitere Loop aus

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> DO UNTIL statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

i=3
until (( i >= 0 )); do
	echo "$i"
	(( i--))
done

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> SWITCH statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

c=123
case $c in
	1* | *2*) echo "switch 1/2"
			;;
	3) echo "switch 3"
			;;
	*) echo "switch default"
esac

# Sichtbarkeit von Variablen
# - Kindprozesse sehen nur exportierte Variablen
export EXPORTEDVAR="4711"
NONEXPORTEDVAR="4712"
# ./bashBootcamp.sh # sieht nur EXPORTEDVAR
#

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Funktionen <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Aufrufparameter sind $1, $2 usw
# $0 sind alle Aufrufparameter
# Return ist der Returnwert des letzten Befehls oder explitit mit return
demo1() {
	echo "Funktion mit Aufrufparameter $1 und $2"
	return 0
}
demo1 "eins" "zwei"

# Variables sind global ausser sie werden mit local definiert
# Dadurch Rekursionen möglich
# Beispiel: bash Forkbomb https://www.cyberciti.biz/faq/understanding-bash-fork-bomb/
# Achtung: Default ist global in Funktionen, d.h. jede lokale Variable muss als local deklariert werden

var1="var1_extern"
demo4() {
	echo "demo: var1 extern in demo: $var1"
	local var1
	var1="$1"
	echo "demo: Var1 intern in demo: $var1"
	return 0
}
demo4 "var_intern"
echo "var1 extern: $var1"

# Returnwerte von Funktionen
# Exitcodes von 0-255
demo2() {
	return $1
}
demo2 0; echo $?
demo2 42; echo $?

# Ausgaben in stdout wie z.B. mit echo
demo5() {
	echo "$1"
}
demo5 "Eins"
demo5 "Zwei"

# bzw in einem Script die Ausgabe an eine Variable zuweisen

RETURNVAR="$(demo "Eins")"
echo "$RETURNVAR"

# Globale variablen

VARIABLE="eins"
demo3() {
	VARIABLE="$1"
}
echo "$VARIABLE"
demo3 "Zwei"
echo "$VARIABLE"

# Zuweisung an eine Variable dessen Name als Argument mitgereicht wird - printf -v

VARIABLE1="eins"
VARIABLE2="zwei"
demo6() {
	printf -v "$1" "%s", "$2"	# speichere Wert von $2 in der Variable mit dem Namen der in $1 steht
}
echo "$VARIABLE1 $VARIABLE2"
demo6 "VARIABLE1" "einseins"
demo6 "VARIABLE2" "zweizwei"
echo "$VARIABLE1 $VARIABLE2"

# Includes wie in C
# sourcen von shell Scripts, keine Ausführung aber alle dort definierten Variablen werden im Scripts bekanntgemacht (nicht nur exportierte Variablen)

source bashBootcamp.sh

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Here Doc <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Nutzung von konstantem Text in scripts

# bash expansion on
cat <<EOF
   Das Script steht in $PWD
EOF

# bash expansion off
cat <<'EOF'
   Das Script steht in $PWD
EOF

# String heredoc <<<

wc -c <<< "Hello world" # counts number of chars

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> IFS Nutzung <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Splitten eines Textes
# Achtung: Ohne ", da sonst kein splitting stattfindet

IFS="."
V="Das.ist.ein.Test"
AU=( $V )
AQ=( "$V" )
echo "${#AU[@]}"
for e in "${AU[@]}"; do
	echo "$e"
done
echo "${#AQ[@]}"
for e in "${AQ[@]}"; do
	echo "$e"
done
unset IFS						# IFS wieder auf default setzen

# Sauberer Weg da kein globbing genutzt wird

IFS="."
V="Das.ist.ein.Test"
read -a array <<< $V
for e in "${V[@]}"; do
   echo $e
done
unset IFS						# IFS wieder auf default setzen

# >>> parameter expansions <<<

# Default Werte für Variablen setzen, Texte ersetzen, Substring, 

man bash 2>/dev/null | grep -E 'Parameter Expansion | \${.+}$'

# >>> patterns <<<

# Patterns werden i.W. beim globbing genutzt
# Ausserdem beim test mit [[ .. == .. ]]

v="Hello world"

if [[ "$v" == *[w]* ]]; then
	echo "Found world"
fi

# Case statements

case "$v" in

	*world*) echo "Fund world"
			;;
esac			

# string manipulation

v="Hello world and universe"
vm=${v/world*/earth}				# replace world (bash parameter expansion)
echo "$vm"

###########################################################################################
#
# ### Programmieraufgaben ###
#
###########################################################################################

:<<SKIP

Anforderungen an alle Scripts:

1.	Ausreichende Eingabeprüfung
2. 	Im Fehlerfalle eine Meldung schreiben und mit RC 1 das Script beenden
3.	Im Erfolgsfall RC 0 liefern
4.	Den vorgegebenen Scriptnamen nutzen
5.	Jedes Script mit shellcheck prüfen und korrigieren
6.	Hinweise müssen nicht befolgt werden, es gibt viele Wege nach Rom :-D

1. 	countfiles.sh [directory] [extension]?
	Beispiel: countfiles.sh ~ *.sh oder countfiles.sh /home/$LOGNAME *.jpg oder countfiles.sh und anschliessende Eingabe von *.sh
	Sucht in einem Verzeichnis rekursiv nach allen Dateien, die eine bestimmte Extension haben und gib am Ende aus, wieviele Dateien gefunden wurden.
	Die Eingabe der Extension soll vom Terminal angefragt werden wenn sie nicht eingegeben wurde. Ansonsten ist es der erste Aufrufparameter

2. 	fibonacci.sh [number]?
	Beispiel: finbonacci.sh 10
	Berechnet die Fibonaccizahlen iterativ und rekursiv. Dabei die Eingabe (ersten Parameter) auf korrektes Format überprüfen.

3. 	testipv4.sh [IPv4]
	Testet eine IPv4 auf korrekte Schreibweise
	Optional: teste ob es eine valide extene IPv4 ist, also keine private IP (Class A,B,C oder LL)
	10.0.0.0 – 10.255.255.255 (Klasse A)
	172.16.0.0 – 172.31.255.255 (Klasse B)
	192.168.0.0 – 192.168.255.255 (Klasse C)
	169.254.0.0 – 169.254.255.255 (Link-Local)

4. 	highlow.sh
	Implementierung des High-Low Spiels
	Ausgabe des minimalen (0) und maximalen (100) Wertes und einlesen des Tipps in einer Loop
	Test ob match und ansonsten weiterfragen
	Dabei mitzählen wie häufig geraten wird
	Optional: Binärer Suche - die optimalsten Suchstrategie - anwenden und die Anzahl optimaler Versuche am Ende des Spiels ausgeben

5.	weatherin.sh [cityname]?
	Holt Wetterdaten von einem beliebigen Ort per curl und gib sie aus
	curl "https://nominatim.openstreetmap.org/search?q=Renningen&format=json&limit=1"
	curl "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
	Eingabe des Ortes und Ausgabe von Temperatur und Windgeschwindigkeit und -richtung
	Fehlerfall abfangen falls Ort nicht gefunden wurde
	Tipp für Fortgeschrittene: jq nutzen (sudo apt install jq)

6.	findactivedevices.sh [localnet] [-i|-d]?
	Sucht nach allen Geräten im lokalen Netz und Ausgabe der IP Adressen sowie der DNS Namen
	Installation von nmap: sudo apt install nmap
    nmap -sP 192.168.0.0/24 sucht alle aktiven IPs mit ihren DNS Namen
	Optional: Per Option wird die Liste nach IPv4 (Optione -i, numerisch sortiert) und DNS Namen (Option -d, alphabetisch sortiert) sortiert ausgegeben

7.	countchars.sh [filename]
	Zählen der Häufigkeit von Buchstaben und Ausgabe der 10 häufigsten Zeichen  mit ihrer % Häufigkeit
	Hinweis: sort Befehl

8. 	denumber.sh [filename]
	Ersetzen von Ziffern 0-9 durch den entsprechenden Text null, eins, zwei, ... neun
	Hinweis: Associatives Array und here doc

SKIP
