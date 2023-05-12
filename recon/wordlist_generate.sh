#!/bin/bash
DOMAIN=$2
DIRECTORY=/root/bughunter/target/${DOMAIN}/${DOMAIN}_url
mkdir /root/bughunter/target/${DOMAIN}



sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}


python3 ~/tools/wordlist_generator/wordlist_generator.py -d $1 -a 20000 -files

python3 ~/tools/wordlist_generator/wordlist_generator.py -d $1 -a 20000 -dir 