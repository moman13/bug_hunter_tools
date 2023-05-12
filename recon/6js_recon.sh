#!/bin/bash

sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}


dirsearch(){
python3 ~/tools/dirsearch/dirsearch.py -u $1  -t 10 -H 'X-FORWARDED-FOR: 127.0.0.1' -r   -e php,txt,js,html,* --deep-recursive --recursion-status=403,200,302 -i 200,302,403

}
grapjs(){
echo $1 | xargs -P 500 -a domains -I@ sh -c 'nc -w1 -z -v @ 443 2>/dev/null && echo @' | xargs -I@ -P10 sh -c 'gospider -a -s "https://@" -d 2 | grep -Eo "(http|https)://[^/\"].*\.js+" | sed "s#\] \- #\n#g" | anew'

}

gauGrepJs(){
    gau $1 |grep -iE '\.js'|grep -ivE '\.json'|sort -u  >> ${1}_JS.txt
}

getEndPointFromJsFiles(){
cat $1 | while read url;do python3 ~/tools/LinkFinder/linkfinder.py -d -i $url -o cli ; done > endpoint.txt
}
 gau https://www.gymshark.com/ --subs | grep -iE '\.js'|grep -ivE '\.json'|sort -u  >> filesJS.txt

 cat filesJS.txt|xargs -n2 -I@ bash -c "echo -e '\n[URL]: @\n'; python3 ~/tools/LinkFinder/linkfinder.py -i @ -o cli" >> JSPathsWithUrl.txt
#sudo nohup  ./dirsearch.sh mydomins >> log.out 2>&1 &

#cat wayback.txt | grep ".js$" | uniq | sort >> js_files.txt



