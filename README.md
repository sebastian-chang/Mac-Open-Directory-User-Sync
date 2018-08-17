# Mac-Open-Directory-User-Sync
Mimics Apple Open Directory home sync

These are shell scripts meant to mimic the discontinued Home Sync from Apple's Open Directory services.  This will sync your users preferences, files and folders of your choosing to a dedicated server and back down to another machine.  Ideal for offices or schools that have end users move from station to station.

It uses three scripts, two LaunchAgents and one LaunchDaemon.

# Prerequisites

Client machines must have Homebrew installed and ssh-copy-id script for administrators use. 

Server must have most matching version of rsync as client machines.  Rsync will be installed on client machines during setup phase.

Place the three scripts in /usr/local/sbin/

Create the folder /private/.sync

Place com.syncstartup.plist and com.synclogout.plist in /Library/LaunchAgents/

Place com.checkfile.plist in /LibraryLaunchDaemons/

# How it works

When the user logs into the machine both Launch Agents and Daemons are started.  

com.syncstart.plist immediately calls the login.sh.  Starting with Mac OS X 10.12 Sierra, Apple no longer creates mobile home users so each time a user logs into a machine for the first time it goes through its creating a new user process.  We check to see if this user has logged into this machine before by checking to see if ~/.ssh folder exists, if it doesn't we create the folder and wait 10 seconds to allow the machine to finish going through its initial setup phase.  After that has been completed it pulls all user files from the server to the local computer.  Refreshes the Dock and Finder to apply the newly added changes.

com.synclogout.plist calls logout.sh which starts up waits for a logout signal to be sent to the computer.  Once a logout signal has been issued we create a file in /private/.sync with the current username in the file

com.checkfile.plist calls syncUpload.sh as soon as the machine is finished booting up and continues to call syncUpload.sh every 10 seconds.   syncUpload.sh looks for a file called checkFile in /private/.sync, if the file is there it will then read the name of the user that has just logged out and start to preform the copy to the server.  Once the copy has been completed it will remove all tmp files that were created by the user who just logged out allowing the next user to use the same services.

# Work in progress

Creating an installer to places files in correct location for administrator.  Script take care of end user.
