#!/bin/bash
DOMAIN=$3

DIRECTORY=~/bughunter/target/$DOMAIN/${DOMAIN}_content_discovery
mkdir $DIRECTORY


sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}
dirsearch(){
python3 ~/tools/dirsearch/dirsearch.py -u $1  -t 10 -H 'X-FORWARDED-FOR: 127.0.0.1' -r   --deep-recursive=3 --recursion-status=403,200,302 -o $DIRECTORY/dirsearch.txt
}

mygobuster(){
	gobuster   -u $1 -w $2 -t 10 -l  -o $DIRECTORY/gobuster.txt
}


myfuff(){

	ffuf -w $2 -u $1/FUZZ  -maxtime-job 10 -recursion -recursion-depth 2 -o $DIRECTORY/myfuff.txt
}

#ffuf -w ~/wordlist/httparchive_directories_1m_2022_02_28.txt -u $1  -H "X-FORWARDED-FOR: 127.0.0.1" -maxtime-job 10 -recursion -recursion-depth 2 -o myfuff.txt

mybfac(){
	DIRECTORY=~/bughunter/target/bhgre/${1}_content_discovery
	bfac --url $1 -o  $DIRECTORY/mybfac.txt
}

gobusterdiscoverdir(){
   DIRECTORY=~/bughunter/target/bhgre/${1}_content_discovery
	gobuster   -u $1 -w $2 -t 10 -l  -o $DIRECTORY/gobuster.txt
}

cat $1 | while read line
do

   gobusterdiscoverdir $line ~/wordlist/httparchive_directories_1m_2022_02_28.txt
   mybfac $line
   sendNotification "search was done $line"
done


"cat $1 | while read line
do
  dirsearch $line

	mygobuster $line ~/wordlist/httparchive_directories_1m_2022_02_28.txt

	mybfac $line
done"




#gobuster   -u dev.leadsengine.bhgre.com -w ~/wordlist/httparchive_directories_1m_2022_02_28.txt -t 10 -l  -o $DIRECTORY/gobuster.txt
#./content_discovery.sh stgadvantage.realogy.com ~/wordlist/httparchive_directories_1m_2022_02_28.txt stgadvantage
