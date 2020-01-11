#/bin/bash

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log
echo -e "\e[96mСКРИПТ ВСТАНОВЛЕННЯ ЗАПУЩЕНО...\e[0m" | tee -a $logfile

normal=`echo "\033[m"`
msgcolor=`echo "\033[01;31m"` # bold red
menu=`echo "\033[36m"` #Blue
number=`echo "\033[33m"` #yellow

printf "${number}  1. ${menu}Видалити необов'язкові пакети на Raspberry? (Y/n)? ${normal}"
choiceDelUnnecessaryApp=n read choiceDelUnnecessaryApp
printf "${number}  2. ${menu}Встановити оновлення всіх пакетів на Raspberry? (Y/n)? ${normal}"
choiceInstRaspbUpdates=y read choiceInstRaspbUpdates
printf "${number}  3. ${menu}Встановити Docker? (Y/n)? ${normal}"
choiceInstDocker=y read choiceInstDocker
printf "${number}  4. ${menu}Встановити сервер Samba? (Y/n)? ${normal}"
choiceInstSamba=y read choiceInstSamba
printf "${number}  5. ${menu}Встановити NodeJS? (Y/n)? ${normal}"
choiceInstNodeJS=y read choiceInstNodeJS
printf "${number}  6. ${menu}Завантажити docker-контейнер MQTT брокера Eclipse-Mosquitto? (Y/n)? ${normal}"
choiceInstMosquitto=y read choiceInstMosquitto
printf "${number}  7. ${menu}Встановити сервіс PM2? (Y/n)? ${normal}"
choiceInstPM2=y read choiceInstPM2
printf "${number}  8. ${menu}Відключити скрінсейвер? (Y/n)? ${normal}"
choiceDisableScreensaver=y read choiceDisableScreensaver
printf "${number}  9. ${menu}Встановити анімацію вкл\вимкн SmartMirror? (Y/n)? ${normal}"
choiceMirrorSplash=y read choiceMirrorSplash
printf "${number}  10. ${menu}Відключити заставку включення та 4 полуниці при ввімкненні? (Y/n)? ${normal}"
choiceDisableBerries=y read choiceDisableBerries
printf "${number}  11. ${menu}Встановити автозапуск MagicMirror з декстоп-інтерфейсом? (Y/n)? ${normal}"
choiceAutostartMMWithDesctop=y read choiceAutostartMMWithDesctop
printf "${number}  12. ${menu}Встановити автозапуск MagicMirror БЕЗ декстоп-інтерфейсу? (Y/n)? ${normal}"
choiceAutostartMMWithOutDesctop=y read choiceAutostartMMWithOutDesctop
printf "${number}  13. ${menu}Клонувати MagicMirror? (Y/n)? ${normal}"
choiceCloneMagicMirror=y read choiceCloneMagicMirror
printf "${number}  14. ${menu}Встановити MagicMirror? (Y/n)? ${normal}"
choiceInstallMagicMirror=y read choiceInstallMagicMirror
printf "${number}  15. ${menu}Завантажити та встановити модулі MagicMirror? (Y/n)? ${normal}"
choiceCloneAndInstallMMModules=y read choiceCloneAndInstallMMModules
printf "${number}  16. ${menu}Завантажити на встановити MMController? (Y/n)? ${normal}"
choiceCloneAndInstallMMController=y read choiceCloneAndInstallMMController
printf "${number}  17. ${menu}Завантажити клієнти MQTT? (Y/n)? ${normal}"
choiceCloneMQTTClients=y read choiceCloneMQTTClients
printf "${number}  18. ${menu}Встановити пакети: jsonschema, paho-mqtt та rpi_ws281x? (Y/n)? ${normal}"
choiceCloneAndInstallPackages=y read choiceCloneAndInstallPackages

# uninstall unnecessary apps on raspberry
if [[ $choiceDelUnnecessaryApp =~ ^[Yy]$ ]]; then
	sudo /home/pi/smsetup/uninstall.sh
fi

# install updates to raspberry
if [[ $choiceInstRaspbUpdates =~ ^[Yy]$ ]]; then
	echo 'Встановлюю оновлення Raspbian'
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get clean -y
	sudo apt-get autoremove -y
	echo 'Оновлення Raspbian встановлено'
fi

# install docker
if [[ $choiceInstDocker =~ ^[Yy]$ ]]; then
	echo 'Встановлюю Docker'
	sudo curl -sSL https://get.docker.com | sh
	sudo usermod -aG docker pi
	echo 'Docker встановлено'
fi

# install samba
if [[ $choiceInstSamba =~ ^[Yy]$ ]]; then
	echo 'Встановлюю SAMBA SERVER'
	#sudo apt-get install -y samba samba-common-bin
	sudo rm /etc/samba/smb.conf
	sudo cp /home/pi/services/files/smb.conf /etc/samba

	#sudo smbpasswd -a pi
	sudo systemctl restart smbd
	echo 'Встановлюю SAMBA успішно встановлено'
fi

# install NodeJS
if [[ $choiceInstNodeJS =~ ^[Yy]$ ]]; then
	echo 'Встановлюю Nodejs'
	sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs
	echo 'Nodejs встановлено'
fi

#mosquitto
if [[ $choiceInstMosquitto =~ ^[Yy]$ ]]; then
	echo 'Завантажую докер-контейнер Eclipse-Mosquitto'
	sudo docker pull eclipse-mosquitto
	echo 'Контейнер Eclipse-Mosquitto завантажено'
fi

# pm2 install
if [[ $choiceInstPM2 =~ ^[Yy]$ ]]; then
	echo 'Встановлюю pm2'
	sudo npm install -g pm2
	pm2 startup
	echo 'pm2 встановлено'
fi

# disable screensaver
if [[ $choiceDisableScreensaver =~ ^[Yy]$ ]]; then
	echo 'Відключаю скрінсейвер'
	sudo /home/pi/smsetup/screensaveroff.sh
	echo 'Скрінсейвер відключено'
fi

# install SmartMirror splashscreen
if [[ $choiceMirrorSplash =~ ^[Yy]$ ]]; then
	bash $logdir/sm_splash/splashinst.sh
fi

# disable splash screen and 4 raspberries
if [[ $choiceDisableBerries =~ ^[Yy]$ ]]; then
	sudo su -c "echo disable_splash=1 >> /boot/config.txt"
	sudo su -c "echo logo.nologo >> /boot/cmdline.txt"
fi

#autostart MM with Desktop
if [[ $choiceAutostartMMWithDesctop =~ ^[Yy]$ ]]; then
	sudo -u root echo npm start --prefix /home/pi/MagicMirror >>/etc/xdg/lxsession/LXDE-pi/autostart
fi

#autostart MM withOUT Desktop
if [[ $choiceAutostartMMWithOutDesctop =~ ^[Yy]$ ]]; then
	sudo -u root echo npm start --prefix /home/pi/MagicMirror >>/home/pi/.config/lxsession/LXDE-pi/autostart
fi

# clone MagicMirror git
if [[ $choiceCloneMagicMirror =~ ^[Yy]$ ]]; then
	sudo rm -rf home/pi/MagicMirror
	git clone --depth=1 https://github.com/MichMich/MagicMirror.git /home/pi/MagicMirror
	sudo cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
fi

# install MagicMirror
if [[ $choiceInstallMagicMirror =~ ^[Yy]$ ]]; then
	npm -y install --prefix /home/pi/MagicMirror
	sudo cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
fi

# install and clone MM modules
if [[ $choiceCloneAndInstallMMModules =~ ^[Yy]$ ]]; then
	echo 'Приступаю до встановлення модулів MagicMirror'
	echo 'Клоную модулі MagicMirror'
	cd /home/pi/MagicMirror/modules
	git clone --depth=1 https://github.com/Jopyth/MMM-Remote-Control.git
	git clone --depth=1 https://github.com/ronny3050/email-mirror.git email
	git clone --depth=1 https://github.com/paviro/MMM-PIR-Sensor.git
	git clone --depth=1 https://github.com/javiergayala/MMM-mqtt.git
	git clone --depth=1 https://github.com/cybex-dev/MMM-MQTT-Publisher.git
	git clone --depth=1 https://github.com/AgP42/MMM-SmartWebDisplay.git
	git clone --depth=1 https://github.com/mboskamp/MMM-PIR.git

	echo 'Встановлюю REMOTECONTROL'
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-Remote-Control
	echo 'remotecontrol встановлено'

	echo 'Встановлюю  EMAIL'
	npm -y install --prefix /home/pi/MagicMirror/modules/email
	echo 'email встановлено'

	echo 'Встановлюю MMM-mqtt'
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-mqtt
	echo 'MMM-mqtt встановлено'

	echo 'Встановлюю MMM-MQTT-Publisher'
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-MQTT-Publisher
	echo 'MMM-MQTT-Publisher встановлено'

	echo 'Встановлюю /MMM-PIR'
	sudo npm -y install --prefix /home/pi/MagicMirror/modules/MMM-PIR
	echo '/MMM-PIR встановлено'
fi



# install Python packages (to SUDO)
if [[ $choiceCloneAndInstallPackages =~ ^[Yy]$ ]]; then
	echo 'Встановлюю пакети jsonschema, paho-mqtt та rpi_ws281x'
	pip install jsonschema
	sudo pip install paho-mqtt
	sudo pip install rpi_ws281x
	echo 'Пакети jsonschema, paho-mqtt та rpi_ws281x встановлено'
fi

# clone MQTT clients
if [[ $choiceCloneMQTTClients =~ ^[Yy]$ ]]; then
	echo 'Клоную гіт mqtt_clients'
	rm -rf home/pi/mqtt_clients
	git clone --depth=1 https://github.com/sergge1/mqtt_clients.git /home/pi/mqtt_clients
	echo 'Гіт mqtt_clients успішно склоновано'
fi

# clone and install MM controller
if [[ $choiceCloneAndInstallMMController =~ ^[Yy]$ ]]; then
	rm -rf home/pi/MagicMirror
	git clone --depth=1 https://github.com/kolserdav/mmcontroller.git /home/pi/mmcontroller
	npm -y install --prefix /home/pi/mmcontroller
fi

#use rpi_background.jpg as background picture
#docker run -p 1883:1883 --restart=always eclipse-mosquitto
