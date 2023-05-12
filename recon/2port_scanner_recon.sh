#!/bin/bash
DOMAIN=$2
DIRECTORY=~/bughunter/target/$DOMAIN/${DOMAIN}_port_scans
mkdir $DIRECTORY

sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}

converdomains(){

   while read l; do ip=$(dig +short $l|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1);echo "[+] '$l' => $ip";echo $ip >> ips.txt;done < $1

   #while read l; do ip=$(dig +short $l|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1);echo "[+] '$l' => $ip";echo $ip >> ips.txt;done < alive

}

masscanPortScan(){
masscan -p1-65535 -iL $1 --max-rate 1800 -oG $DIRECTORY/masssan.txt

sendNotification "done for $1 rustscan "
}
nmaprun(){
   nmap -sV -iL $1 -oN $DIRECTORY/nmap_scaned-port.txt --script=vuln

   sendNotification "done for  nmaprun "
}

masscanPortScan $1
nmaprun $1

