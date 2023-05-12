#!/bin/bash

sed -i -e 's/\r$//'  /root/bughunter/bash/url_parmeters.sh

getUrlParmeters 
nohup ./port_scanner.sh ips.txt bhgre.com >> log.out 2>&1 &
nohup python3 -m http.server >> server.out 2>&1 &

nohup myfufffile https://www.bhgre.com/bhgrelife/FUZZ >> myfufffile.out 2>&1 &


nohup ~/bughunter/bash/dirsearch.sh myfiles >> myfufffile.out 2>&1 &


nohup ./sub_domin_recon.sh nnss.gov >> sub_domin_recon.out 2>&1 &
ffuf -w -u https://kcnsc.doe.gov/FUZZ -H "X-FORWARDED-FOR: 127.0.0.1" -mc 200,302,403  -recursion -recursion-depth 2

ffuf -w ~/wordlist/httparchive_directories_1m_2022_02_28.txt -u https://a2e.energy.gov/FUZZ -H "Cookie: _ga=GA1.2.1713236660.1651606700; nmstat=23b6aee5-b809-4222-58ba-818650f7124c; XSRF-TOKEN=eyJpdiI6IkVndWlNa3o1VE5CanhyeWdiNzBmRHc9PSIsInZhbHVlIjoieXg3RXZNWkZvaFFxUzk5WVdLOFBCb2Y5aHBkUnNPNzZUaXU1TGNpeXBQV0FmKzMzakRwaW1mWEJZeFBLVEJ0Ni9rVStIS2FLdGtnOVAwN3ZGdWNKUmsyb3NQSFI0TTJDOVhhS2FINHNMQmFhdXNta2NvaDhaQjhZRTZvanIrblEiLCJtYWMiOiI3NGU5OGI1NDBmZThlMjQ4MjY0NjcyZmYwZDY1YmZkODU3MDRhOTA2ZjU1NTc1NzM2ZDFjZTVkZGFlOWRmZGM1IiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkNnekhEZVgwNGlxRERJYnY1U1BKcWc9PSIsInZhbHVlIjoiZ2dEL3I2S2pleGhvRjFkUnA4MWozM0pvS3VmNGNweUx3a2Z2TGhuR2wxUFo2a0ZhOU5rb2w4OTJ4SWMrZFU2MEJpTEozOUszNXV5REY1OGYvem8vK05sSmI1ZHNtSmRwOGVuaTFUKzA1TEhKcjJsY284ZWg0UHc5MUoxd0RIVDAiLCJtYWMiOiI5NGY5NDVkYTE2ZDQwYWU1NmRlZmFmZmRkNzRjYzM5YWQwZjk3NjM1ZmM2ZjQ4YzQwZjU4ZTU0OTAzYzU2Njg2IiwidGFnIjoiIn0%3D; _gid=GA1.2.677742741.1652512155; _gat=1" -mc 200,302,301,403  -recursion -recursion-depth 2




ffuf -w ~/wordlist/httparchive_directories_1m_2022_02_28.txt -u https://192.100.51.61:8443/FUZZ  -H "X-FORWARDED-FOR: 127.0.0.1" -maxtime-job 10 -recursion -recursion-de>
nohup ffuf -w ~/wordlist/httparchive_php_2022_02_28.txt -u https://192.100.51.61:8443//FUZZ  -H "X-FORWARDED-FOR: 127.0.0.1"  -recursion -recursion-depth 2 -o myfilefuff.txt >> myfufffile.out 2>&1 &

nohup ./reconftw.sh -d a2e.energy.gov -a -o ~/bughunter/target/reconftw/a2e.energy.gov >> log.out 2>&1 &

# subdomain Discover
python ~/tools/Sublist3r/sublist3r.py -b -d $DOMAIN -o $DIRECTORY/${DOMAIN}_sublist3r.txt

#python3 ~/tools/tld_scanner/tld_scanner.py -d realogy -o /root/bughunter/target/realogy.com/site-tld.txt
#cat alive.txt | sed 's/https\?:\/\///' > scan-ip.txt cut http

#altdns  -i $DIRECTORY/alldomain.txt -o "$DIRECTORY/altdns-wordlist.txt" -w ~/tools/SecLists/Discovery/DNS/shubs-subdomains.txt


getUrlParmeters

myfuffdir

myfufffile

dirsearch

nohup cat generatedomains.txt | httpx -ports 80,443,8080,8001,8009,280,591,583,832,981,1311,2480,4444,4445,4567,5000,5104,5800,7000,7001,7002,8008,8042,8088,8222,8243,8280,8281,8333,8530,8531,8887,8888,8443,8834,9080,9443,9981,12043,12046,16080,18091,10443,18092,81,300,593,1010,1311,2082,2087,2095,2096,5108,6543,7396,7474,8000,8001,8008,8014,8069,8080,8081,8880,8888,8983,9000,9043,9060,9090,9091,9200,9800,12443,20720.28017 >> alive_httpx.txt
 2>&1 &