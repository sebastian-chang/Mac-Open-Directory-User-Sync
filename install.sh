#!/bin/sh

brew install rsync ssh-copy-id
brew upgrade rsync ssh-copy-id
sudo mv login.sh logout.sh syncUpload.Sh /usr/local/sbin/
sudo mv com.syncstartup.plist com.synclogout.plist /Library/LaunchAgents/
sudo mv com.checkfile.plist /Library/LaunchDaemons/
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub tbdadmin@server-04
sudo mkdir /private/.sync
sudo chmod -R 777 /private/.sync
cp ~/.ssh/known_hosts /private/.sync
cp ~/.ssh/id_rsa /private/.sync
chmod 604 /private/.sync/id_rsa
sudo mv README.txt /private/.sync/
sudo su << EOF
mkdir ~/.ssh/
cp /private/.sync/known_hosts ~/.ssh/
cp /private/.sync/id_rsa ~/.ssh/
chmod 600 ~/.ssh/id_rsa
exit
EOF
