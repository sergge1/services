#!/bin/bash

# chmod +x autoinstall.sh
# ./autoninstall.sh

# install docker
curl -sSL https://get.docker.com | sh

# samba
sudo apt-get install -y samba samba-common-bin
sudo rm  /etc/samba/smb.conf

#mosquitto
docker pull eclipse-mosquitto

echo 'Приступаю до встановлення Python scripts'
sudo pip install jsonschema
sudo pip install paho-mqtt
sudo pip install rpi_ws281x

echo 'Встановлюю Nodejs'
cd ~
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
echo 'Nodejs встановлено'

echo 'Встановлюю pm2'
sudo npm install -g pm2
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi

echo 'pm2 встановлено'

echo 'Встановлюю mmcontroller'
cd ~
git clone https://github.com/kolserdav/mmcontroller.git
cd ~/mmcontroller
npm install
cd ~
echo 'Гіт mmcontroller склоновано та встановлено'