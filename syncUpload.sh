#!/bin/sh

# Variables

userName=$(cat /private/.sync/checkFile)
remotePath=tbdadmin@server-04:/Volumes/TBD-OWC_8TB_02/Home/
syncFolderPath="/Users/./"$userName"/Desktop/Sync-Folder/"
libraryFilePath="/Users/./"$userName"/Library/Preferences/"
premiereFilePath="/Users/./"$userName"/Documents/Adobe/Premiere Pro/"
premiereUserPath="/Profile-"$userName"/"
mediaComposerFilePath="/Users/./Shared/AvidMediaComposer/Avid Users/"$userName"/"
dock="com.apple.dock.plist"
finder="com.apple.finder.plist"
wacom="com.wacom."
spaces="com.apple.spaces.plist"
terminal="com.apple.Terminal.plist"

if [ -f "/private/.sync/checkFile" ] && [ "userName" != "tbdadmin" ]
then
	rsync -aRPt --exclude="*.mov" --exclude="*.mp4" --exclude="*.mxf" --exclude="*.m4v"  --exclude="*.mpg" --exclude="*.mpeg" --exclude="*.m2v" --max-size=1G --delete -e 'ssh -i /private/.sycn/id_rsa' "$syncFolderPath" "$premiereFilePath"*"$premiereUserPath" "$mediaComposerFilePath" "$remotePath"
	rsync -aRPt -e 'ssh -i /private/.sync/id_rsa' "$libraryFilePath""$dock" "$libraryFilePath""$finder" "$libraryFilePath""$wacom"*".prefs" "$libraryFilePath""$spaces" "$libraryFilePath""$terminal" "$remotePath"
	rm /private/.sync/checkFile
fi

find /tmp/ -user $userName -exec rm -rf {} \;
exit