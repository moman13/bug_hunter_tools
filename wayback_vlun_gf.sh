#!/bin/bash

redirect(){
echo $1 | waybackurls | httpx -silent -timeout 2 -threads 100 | gf redirect | anew redirect.txt
}

