#/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt-get clean -y
sudo apt-get autoremove -y

#SAMBA
sudo apt-get install -y samba samba-common-bin # требует одно подтверждение при установке (Yes/No), по-умолчанию выбрано то что нужно (No)
sudo cp /etc/samba/smb.conf /etc/samba/smb.confbackup
sudo rm /etc/samba/smb.conf
sudo cp /home/pi/smsetup/files/smb.conf /etc/samba
sudo smbpasswd -a pi
sudo systemctl restart smbd

#NodeJS
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

#Docker
sudo curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi

#Eclipse-mosquitto server
sudo docker pull eclipse-mosquitto
sudo docker run -it -p 1883:1883 --restart=always eclipse-mosquitto


#MagicMirror
sudo rm -rf home/pi/MagicMirror
git clone --depth=1 https://github.com/MichMich/MagicMirror.git /home/pi/MagicMirror
cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js

cd /home/pi/MagicMirror/modules
git clone --depth=1 https://github.com/Jopyth/MMM-Remote-Control.git
git clone --depth=1 https://github.com/ronny3050/email-mirror.git email
git clone --depth=1 https://github.com/sergge1/MMM-PIR-Sensor.git
git clone --depth=1 https://github.com/javiergayala/MMM-mqtt.git
git clone --depth=1 https://github.com/cybex-dev/MMM-MQTT-Publisher.git
git clone --depth=1 https://github.com/AgP42/MMM-SmartWebDisplay.git
git clone --depth=1 https://github.com/mboskamp/MMM-PIR.git

npm -y install --prefix /home/pi/MagicMirror &&

npm -y install --prefix /home/pi/MagicMirror/modules/MMM-Remote-Control &&
npm -y install --prefix /home/pi/MagicMirror/modules/email &&
npm -y install --prefix /home/pi/MagicMirror/modules/MMM-mqtt &&
npm -y install --prefix /home/pi/MagicMirror/modules/MMM-MQTT-Publisher &&
cd /home/pi/MagicMirror/modules/MMM-PIR
npm -y install --prefix /home/pi/MagicMirror/modules/MMM-PIR &&
npm -y install --prefix /home/pi/MagicMirror/modules/MMM-PIR electron-rebuild &&
/home/pi/MagicMirror/modules/MMM-PIR/node_modules/.bin/electron-rebuild
