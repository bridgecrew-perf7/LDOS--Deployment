#!/bin/bash
# check Workshop-LDOS directory exists
# remove Workshop-LDOS/* 
# create Workshop-LDOS/directory
# clone remote git LDOS--Installation repository to /installers/Workshop-LDOS directory


# -------------------------------------------------------
dir="$/installers/Workshop-LDOS"
 
[ $# -eq 0 ] && { echo "Usage: $0 dirname"; exit 1; }
 
if [ -d "$dir" -a ! -h "$dir" ]
then
   echo "$dir found and copying over new files, please wait..."
   rm -rf "$/installers/Workshop-LDOS/*"
 else
   echo "Error: $dir not found or is symlink to $(readlink -f ${dir})."
fi






set -e

# settings / change this to your config
remoteHost=github.com
remoteUser=jporeilly
remoteDir="~/LDOS--Installation/"
remoteRepo=$(http://$remoteHost/$remoteUser "ls $remoteDir")
localDir="/installer/Workshop-LDOS"

# bail out if cant connect...
if [ -z "$remoteRepo" ]; then
    echo "Can't connect to remote GitHub repository"
    exit
fi

# check again if Workshop-LDOS exists locally
# if dir exists, clone the remote git repo into it
for gitRepo in $remoteRepo
do
  localRepoDir=$(echo ${localDir}${gitRepo}|cut -d'.' -f1)
  if [ -d $localRepoDir ]; then 	
		cloneCmd="git clone http://$remoteHost/$remoteUser/$remoteDir"
		cloneCmd=$cloneCmd"$gitRepo $localRepoDir"
		
		cloneCmdRun=$($cloneCmd 2>&1)

		echo -e "Running: \n$ $cloneCmd"
		echo -e "${cloneCmdRun}\n\n"
	fi
done

