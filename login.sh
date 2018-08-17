#!/bin/sh

# Variables

mediaComposerFilePath="Shared/AvidMediaComposer/Avid\ Users/"$USER"/"
sshDirectory=/Users/$USER/.ssh/
remotePath=tbdadmin@server-04:/Volumes/TBD-OWC_8TB_02/Home/./
syncFolderPath="/Desktop/Sync-Folder/"
libraryFilePath="/Library/Preferences/"
premiereFilePath="/Documents/Adobe/Premiere\ Pro/"
premiereUserPath="/Profile-"$USER"/"

# Check to see if user already has credentials to log into remote server.

if [ ! -d $sshDirectory ]
then
	mkdir "$sshDirectory"
	cp /private/.sync/known_hosts "$sshDirectory"
# In order for Finder to refresh with correct plist
	open /Applications
	sleep 10
	echo 'Welcome'
fi

# Copy files from remote server into correct file location

if [ "$USER" != "tbdadmin" ]
then
	rsync -aRPt -e  'ssh -i /private/.sync/id_rsa' "$remotePath"$USER"$libraryFilePath" "$remotePath""$mediaComposerFilePath" /Users/ > /tmp/test.log 2>&1
	rsync -aRPt --delete -e 'ssh -i /private/.sync/id_rsa' "$remotePath"$USER"$syncFolderPath" "$remotePath"$USER"$premiereFilePath"*"$premiereUserPath" /Users/ >> /tmp/test.log 2>&1
	sleep 1
	killall Dock
	sleep 2
	killall Finder
fi

# If user has never logged in before throughout the facility, create a sync folder with read me text file 

if [ ! -d /Users/$USER/$syncFolderPath ] && [ "$USER" != "tbdadmin" ]
then
	mkdir /Users/$USER/"$syncFolderPath" >> /tmp/test.log 2>&1
	cp /private/.sync/README.txt /Users/$USER/"$syncFolderPath"
fi

exit 0