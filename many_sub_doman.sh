#!/bin/bash

cat $1 | while read line
do
   ./sub_domin_recon.sh $line
done
