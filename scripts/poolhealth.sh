#!/bin/bash 
EXITCODE=-1
STATUS=`/sbin/zpool status ${1} -x`


if [ "$?" = "0" ]; then 
  if [[ $STATUS == *"is healthy"*   ]]; then 
     EXITCODE=0
  else
     echo $STATUS
     EXITCODE=1
  # it's possible to check attional states
  #elif [[ $STATUS == *"DEGRADED"*   ]]; then
  #elif [[ $STATUS == *"FAULTED"*   ]]; then
  fi
else
  echo "Error running the zpool command!"
  EXITCODE=1
fi 

#echo $EXITCODE # for debug only
exit $EXITCODE
