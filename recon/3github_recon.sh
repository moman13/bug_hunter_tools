#!/bin/bash

sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}

dirsearch(){
python3 ~/tools/dirsearch/dirsearch.py -u $1  -t 10 -H 'X-FORWARDED-FOR: 127.0.0.1' -r   -e php,txt,js,html,* --deep-recursive --recursion-status=403,200,302 -i 200,302,403

}

cat $1 | while read line
do
   dirsearch $line
   sendNotification "search was done $line"
done

#sudo nohup  ./dirsearch.sh mydomins >> log.out 2>&1 &





