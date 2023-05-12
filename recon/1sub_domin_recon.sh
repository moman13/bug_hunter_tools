#!/bin/bash
DOMAIN=$1
DIRECTORY=/root/bughunter/target/${DOMAIN}/${DOMAIN}_recon 
mkdir /root/bughunter/target/${DOMAIN}

sendNotification(){
	curl -s "https://api.telegram.org/bot5093387182:AAG538f80XvIshHwNHRGoICU18vYX8a6mG0/sendMessage?chat_id=@myvpsmoman&text=$1"
}

getfilecount(){

	echo "file count after $1" 
	cat $DIRECTORY/$2 >> $DIRECTORY/alldomain.txt
	cat $DIRECTORY/alldomain.txt  | wc -l 

}
crtsh(){
curl -s https://crt.sh/?Identity=%.$1 | grep ">*.$1" | sed 's/<[/]*[TB][DR]>/\n/g' | grep -vE "<|^[\*]*[\.]*$1" | sort -u | awk 'NF'
}
jldcme(){
curl -s "https://jldc.me/anubis/subdomains/$1" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" 
}
securitytrails(){
curl -s --request GET --url https://api.securitytrails.com/v1/domain/$1/subdomains?apikey=cBpSpk58BLEoGa4ya00IFqz7V9Q5gn2b | jq '.subdomains[]' | sed 's/\"//g' >test.txt 2>/dev/null && sed "s/$/.$1/" test.txt | sed 's/ //g' && rm test.txt
}
dnsscancn(){
for ((i=1;i<=1000;i++)); do 
	curl -i -k -s -L -X POST "https://dnsscan.cn/dns.html?keywords=$1&page=${i}" -d "ecmsfrom=&show=&num=&classid=0&keywords=$1" | grep -oE "[a-zA-Z0-9._-]+\.$1" | sort -u ; done
}

amassbigscope(){
	amass intel -org $1 -max-dns-queries 2500 | awk -F, '{print $1}' ORS=',' | sed 's/,$//' | xargs -P3 -I@ -d ',' amass intel -asn @ -max-dns-queries 2500
}

rapiddns(){
curl -s "https://rapiddns.io/subdomain/$1?full=1" \
 | grep -oP '_blank">\K[^<]*' \
 | grep -v http \
 | sort -u
}
getBufferover(){

curl -s https://dns.bufferover.run/dns?q=$1 |jq -r .FDNS_A[] | sed -s 's/,/\n/g' | httpx -silent | anew

}

mkdir $DIRECTORY


subfinder -d  $DOMAIN  -recursive -silent -t 200 -o  $DIRECTORY/${DOMAIN}_subfinder.txt
getfilecount subfinder ${DOMAIN}_subfinder.txt
sendNotification "subfinderdone $DOMAIN"


amass enum --passive -d $DOMAIN  -o $DIRECTORY/${DOMAIN}_amass.txt
getfilecount amass ${DOMAIN}_amass.txt

amass enum  -src -ip -brute -min-for-recursive 2 -d $DOMAIN -o $DIRECTORY/${DOMAIN}_amass_active.txt

getfilecount amass_active ${DOMAIN}_amass_active.txt

assetfinder --subs-only $DOMAIN > $DIRECTORY/${DOMAIN}_assetfinder_active.txt

getfilecount assetfinder ${DOMAIN}_assetfinder_active.txt


gau --subs $DOMAIN  | cut -d / -f 3 | sort -u >> $DIRECTORY/alldomain.txt

crtsh  $DOMAIN >>  $DIRECTORY/alldomain.txt 
jldcme $DOMAIN >>  $DIRECTORY/alldomain.txt 
dnsscancn $DOMAIN >>  $DIRECTORY/alldomain.txt 
securitytrails $DOMAIN >>  $DIRECTORY/alldomain.txt
rapiddns $DOMAIN >>  $DIRECTORY/alldomain.txt
getBufferover $DOMAIN >> $DIRECTORY/alldomain.txt
sendNotification "crtsh jldcme securitytrails securitytrails  $DOMAIN done"

cat $DIRECTORY/alldomain.txt | sort -u >> $DIRECTORY/alldomain.txt
cat  $DIRECTORY/alldomain.txt  | dnsgen -w ~/tools/SecLists/Discovery/DNS/dns-Jhaddix.txt -f - > $DIRECTORY/generatedomains.txt

echo "DnsGen Don "
echo "Run Httpro For Http & Https "

python3 ~/tools/vhosts-sieve/vhosts-sieve.py -d $DIRECTORY/alldomain.txt -o $DIRECTORY/vhosts.txt

sendNotification "start httprobe  $DOMAIN"

cat  $DIRECTORY/alldomain.txt | httpx -ports 80,443,8080,8001,8009,280,591,583,832,981,1311,2480,4444,4445,4567,5000,5104,5800,7000,7001,7002,8008,8042,8088,8222,8243,8280,8281,8333,8530,8531,8887,8888,8443,8834,9080,9443,9981,12043,12046,16080,18091,10443,18092,81,300,593,1010,1311,2082,2087,2095,2096,5108,6543,7396,7474,8000,8001,8008,8014,8069,8080,8081,8880,8888,8983,9000,9043,9060,9090,9091,9200,9800,12443,20720,28017 | anew  $DIRECTORY/alive.txt
cat  $DIRECTORY/generatedomains.txt | httpx -ports 80,443,8080,8001,8009,280,591,583,832,981,1311,2480,4444,4445,4567,5000,5104,5800,7000,7001,7002,8008,8042,8088,8222,8243,8280,8281,8333,8530,8531,8887,8888,8443,8834,9080,9443,9981,12043,12046,16080,18091,10443,18092,81,300,593,1010,1311,2082,2087,2095,2096,5108,6543,7396,7474,8000,8001,8008,8014,8069,8080,8081,8880,8888,8983,9000,9043,9060,9090,9091,9200,9800,12443,20720,28017 |anew  $DIRECTORY/alive.txt

#sendNotification "start subTackover  $DOMAIN"
#python3 ~/tools/takeover/takeover.py -l $DIRECTORY/alive.txt -t 10  -o $DIRECTORY/takeover_results.txt



sendNotification "all done please check http://143.198.73.83:8080/  $DOMAIN"





