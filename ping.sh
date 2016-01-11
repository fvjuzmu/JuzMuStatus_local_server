#!/bin/bash

#base files
maclist="/home/thora/temp/maclist.txt"
foundmacs="/home/thora/temp/foundmacs.txt"
juzIstOffen=false

#get macs
nmap -n -sP -T4 192.168.1.1/24 | grep -i -o '[0-9A-F]\{2\}\(:[0-9A-F]\{2\}\)\{5\}' > $foundmacs

#check if some of the VIP macs are in the foundmacs list
while read mac; do
  if `grep "$mac" "$maclist" > /dev/null`; then
    juzIstOffen=true
  fi
done < $foundmacs 

if $juzIstOffen; then
 wget -q -O /dev/null "http://foerderverein-juzmu.de/juzmustatus/updjuzoff.php?status=1"
else
 wget -q -O /dev/null "http://foerderverein-juzmu.de/juzmustatus/updjuzoff.php?status=0"
fi
