# install docker
# curl -sSL https://get.docker.com | sh #autoinstall
sudo usermod -aG docker pi

# samba
#sudo apt-get install -y samba samba-common-bin #autoinstall
#sudo rm  /etc/samba/smb.conf #autoinstall
sudo nano /etc/samba/smb.conf
	[global]
	workgroup = WORKGROUP
	netbios name = RaspberryPi
	server string = share
	security = user
	map to guest = bad user
	browseable = yes

	[homepi]
	path = /home/pi
	writeable = yes
	browseable = yes
	guest ok = no

sudo smbpasswd -a pi
sudo systemctl restart smbd

#mosquitto
# docker pull eclipse-mosquitto #autoinstall

docker run -it --restart unless-stopped -p 1883:1883 eclipse-mosquitto

# gits
git clone https://github.com/MichMich/MagicMirror.git
git clone https://github.com/sergge1/mqtt_clients.git
git clone https://github.com/kolserdav/mmcontroller.git

bash -c "$(curl -sL https://raw.githubusercontent.com/MichMich/MagicMirror/master/installers/raspberry.sh)"



modules:
cd ~/MagicMirror/modules
git clone https://github.com/Jopyth/MMM-Remote-Control.git
git clone https://github.com/ronny3050/email-mirror.git email
git clone https://github.com/mboskamp/MMM-PIR.git
cd ~/MagicMirror/modules/MMM-Remote-Control
npm install
cd ~/MagicMirror/modules/email
npm install
cd ~/MagicMirror/modules/MMM-PIR
npm install


# prevent wpa_supplicant from starting on boot
sudo systemctl mask wpa_supplicant.service

# rename wpa_supplicant on the host to ensure that it is not used.
sudo mv /sbin/wpa_supplicant /sbin/no_wpa_supplicant

# kill any running processes named wpa_supplicant
sudo pkill wpa_supplicant

docker pull cjimti/iotwifi
docker run --rm --privileged --restart unless-stopped --net host cjimti/iotwifi

	# ssid": "iot-wifi-cfg-3",
	# wpa_passphrase":"iotwifipass",


#tuning-up
sudo nano /boot/config.txt
disable_splash=1
