#!/bin/sh 
TP=-1
STATUS=`/usr/sbin/smartctl -H /dev/sd${1} | grep overall-health | awk 'match($0,"result:"){print substr($0,RSTART+8,6)}'`

/usr/sbin/smartctl -H /dev/sd${1} | grep overall-health
echo 
/usr/sbin/smartctl -l selftest /dev/sd${1}| sed '1,5d;$d'
echo 
/usr/sbin/smartctl -i /dev/sd${1} | sed '1,3d;$d'
#/usr/sbin/smartctl -a /dev/sd${1} | grep Serial


if [ "$?" = "0" ]; then 
  if [ "$STATUS" = "PASSED" ] 
  then
     # 1 implies PASSED
     TP=0
     #/usr/sbin/smartctl -H /dev/sd${1} | grep overall-health
     /usr/sbin/smartctl -q silent  -l selftest /dev/sd${1} || TP=1
     echo 
     /usr/sbin/smartctl -a /dev/sd${1} | grep "Self-test execution status:      (   0)" || (TP=1 && /usr/sbin/smartctl -a /dev/sd${1})
  else 
     # 2 implies FAILED
     /usr/sbin/smartctl -H /dev/sd${1}
     TP=1
  fi
else
  # error accessing the drive or the smartctl app
  echo "Error accessing drive or the smartctl command!"
  TP=1
fi 

 #echo $TP # for debug only
 exit $TP
