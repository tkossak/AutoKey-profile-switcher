#!/bin/bash

AK_DEFAULT_FOLDER=~/.config/autokey
AK_SCRIPT_FOLDER=~/Dropbox/Private/Linux/AutoKey_scripts
NEW_PROFILE=$1

if [[ $# = 0 ]]; then
    echo 'Usage:
aks [ OPTIONS | PROFILE_NAME ]

OPTIONS:
-l | --list  - list available profiles
'
exit
fi


if [[ $1 = '-l' || $1 = '--list' ]]; then
    ls ${AK_SCRIPT_FOLDER}
    exit
fi

if [[ ! -d ${AK_SCRIPT_FOLDER}/${NEW_PROFILE} ]]; then
  echo Error: Profile doesn\'t exist > /dev/stderr
  exit
fi

if [[ -d ${AK_DEFAULT_FOLDER} && ! -L ${AK_DEFAULT_FOLDER} ]]; then
  echo Error: autokey is normal folder - save it in scripts folder and remove the orginal one > /dev/stderr
  exit
fi

pkill -15 autokey-gtk

while [[ -n $(pgrep autokey-gtk) ]]; do
  sleep 0.1
done

if [[ -L ${AK_DEFAULT_FOLDER} ]]; then
  rm ${AK_DEFAULT_FOLDER} 
fi

ln -s ${AK_SCRIPT_FOLDER}/${NEW_PROFILE} ${AK_DEFAULT_FOLDER}
ls -l ${AK_DEFAULT_FOLDER}

nohup autokey-gtk >/dev/null 2>&1 &  
