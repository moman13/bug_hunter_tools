#!/bin/bash
PATH_TO_DIRSEARCH="/home/moman/tools/dirsearch"
PATH_TO_="/home/moman/tools/dirsearch"
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon 
echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY84 Chapter 
nmap $DOMAIN > $DIRECTORY/nmap
echo "The results of nmap scan are stored in $DIRECTORY/nmap."
$PATH_TO_DIRSEARCH/dirsearch.py -u $DOMAIN -e php –simple-report=$DIRECTORY/dirsearch 2
echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch."


