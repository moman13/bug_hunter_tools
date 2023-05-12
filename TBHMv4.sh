#!/bin/bash
DOMAIN=$1
DIRECTORY=/root/bughunter/target/${DOMAIN}/${DOMAIN}_recon 
mkdir /root/bughunter/target/${DOMAIN}

sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}

#http://bgp.he.net

#ASN Enumeration
echo $1 | metabigor net --org -o $DIRECTORY/metabigor.txt

#amass intel -asn 14523s

python ~/tools/domLink/domLink.py -D $DOMAIN -o $DIRECTORY/domLink.txt

#Ad/Analytics Relationships
#https://builtwith.com/relationships/twitch.tv
python ~/tools/domLink/domLink.py -D $DOMAIN -o $DIRECTORY/domLink.txt
echo $DOMAIN | python3 ~/bughunter/tools/getrelationship.py >>  $DIRECTORY/getrelationship.txt
#google dork 
# '@copyright' inurl $DOMAIN
#shoden search

hakrawlerfunction(){
	echo $1 | hakrawler -d 3 -h 'X-FORWARDED-FOR: 127.0.0.1' -u >> $DIRECTORY/hakrawler.txt
    sendNotification "hakrawler function is done"
}

gospiderfunction(){
	gospider -s $1 -o $DIRECTORY/gospider.txt -c 10 -d 3 --other-source --include-subs -H "X-FORWARDED-FOR: 127.0.0.1" 
    sendNotification "gospider function is done $1"
}

subDomainizerfunction(){
	python3 SubDomainizer.py -u $1 -o $DIRECTORY/subDomainizerfunction.txt -gt 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 -g -gop $DIRECTORY/subDomainizer_github_function.txt
	sendNotification "SubDomainizer function is done $1"
}

massscanfunction(){
	masscan -p1-65535 -iL $1 --max-rate 1800 -oG $DIRECTORY/masscan.log
}

dmasscan(){
	./dnmasscan.sh $1 -p1-65535 -oG masscan.log --rate=500
}
brutespray(){
	python3 ~/bughunter/tools/brutespray.py --file nmap.xml --threads 5 --hosts 5
}

nmaponservice(){
	Nmap service scan -oG
}
