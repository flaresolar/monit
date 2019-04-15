#!/bin/bash
 STATUS=`/usr/sbin/hddtemp /dev/sd${1} --numeric`
 # set the required temprature to alert on at $2
 re='^[0-9]+$'
 if ! [[ $STATUS =~ $re ]] ; then
   echo "error: Not a number"
   TP=2
 elif [[ $STATUS -le $2 ]] ; then
     # all OK
     TP=0
     echo $STATUS # print out the temprature
 else 
     # implies FAILED
     TP=1
     echo $STATUS # print out the temprature
 fi
#echo $TP # for debug only
 exit $TP
