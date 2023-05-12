#!/bin/bash
DOMAIN=$2
DIRECTORY=/root/bughunter/target/${DOMAIN}/${DOMAIN}_url
mkdir /root/bughunter/target/${DOMAIN}



sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}

gospiderRun(){
    gospider -s $1 -o gospider.txt -c 10 -d 1 --other-source --include-subs

   # gospider -s https://www.bhgre.com -o gospider.txt -c 10 -d 1 --other-source --include-subs
    sendNotification "go spired was done"
}
gaufunction(){
    gau $1 --subs --o gau.txt
     sendNotification "go gaufunction was done"
}
waybackUrl(){

     echo $1 | waybackurls >> wayback.txt
      sendNotification "go way back was done"
}
hakrawlerfunction(){

    echo $1 |   hakrawler -d 3 >> hakrawler.txt
      sendNotification "go hakrawler was done"
}

paramspider(){
 python3 ~/tools/ParamSpider/paramspider.py --domain $1 --output paramspider.txt --exclude woff,css,js,png,svg,php,jpg
}



gospiderRun $1
gaufunction $1
waybackUrl $1
hakrawlerfunction $1
paramspider $1

