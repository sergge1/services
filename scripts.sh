#/bin/bash

if [ -z "$BASH_VERSION" ]
then
    exec bash "$0" "$@"
fi

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log

choiceDelUnnecessaryApp=n
read -p "Видаляти необов'язкові пакети на Raspberry? (y/N)?" choiceDelUnnecessaryApp
choiceInstRaspbUpdates=y
read -p "Встановлювати оновлення всіх пакетів на Raspberry? (Y/n)?" choiceInstRaspbUpdates
choiceInstDocker=y
read -p "Встановлювати Docker? (Y/n)?" choiceInstDocker
choiceInstSamba=y
read -p "Встановлювати сервер Samba? (Y/n)?" choiceInstSamba
choiceInstNodeJS=y
read -p "Встановлювати NodeJS? (Y/n)?" choiceInstNodeJS
choiceInstMosquitto=y
read -p "Завантажувати docker-контейнер MQTT брокера Eclipse-Mosquitto? (Y/n)?" choiceInstMosquitto
choiceInstPM2=y
read -p "Встановлювати сервіс PM2? (Y/n)?" choiceInstPM2
choiceDisableScreensaver=y
read -p "Відключити скрінсейвер? (Y/n)?" choiceDisableScreensaver
choiceMirrorSplash=y
read -p "Встановлювати анімацію вкл\вимкн SmartMirror? (Y/n)?" choiceMirrorSplash
choiceDisableBerries=y
read -p "Відключити заставку включення та 4 полуниці при ввімкненні? (Y/n)?" choiceDisableBerries
choiceAutostartMMWithDesctop=y
read -p "Встановити автозапуск MagicMirror з декстоп-інтерфейсом? (Y/n)?" choiceAutostartMMWithDesctop
choiceAutostartMMWithOutDesctop=y
read -p "Встановити автозапуск MagicMirror БЕЗ декстоп-інтерфейсу? (Y/n)?" choiceAutostartMMWithOutDesctop
choiceCloneMagicMirror=y
read -p "Клонувати MagicMirror? (Y/n)?" choiceCloneMagicMirror
choiceInstallMagicMirror=y
read -p "Встановлювати MagicMirror? (Y/n)?" choiceInstallMagicMirror
choiceCloneAndInstallMMModules=y
read -p "Завантажити та встановити модулі MagicMirror? (Y/n)?" choiceCloneAndInstallMMModules
choiceCloneAndInstallMMController=y
read -p "Завантажити на встановити MMController? (Y/n)?" choiceCloneAndInstallMMController
choiceCloneMQTTClients=y
read -p "Завантажити клієнти MQTT? (Y/n)?" choiceCloneMQTTClients
choiceCloneAndInstallPackages=y
read -p "Встановити пакети: jsonschema, paho-mqtt та rpi_ws281x? (Y/n)?" choiceCloneAndInstallPackages

# uninstall unnecessary apps on raspberry
if [[ $choiceDelUnnecessaryApp =~ ^[Yy]$ ]]; then
	sudo /home/pi/services/uninstall.sh
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
	sudo apt-get install -y samba samba-common-bin
	sudo rm /etc/samba/smb.conf
	sudo cp /home/pi/services/files/smb.conf /etc/samba

	sudo smbpasswd -a pi
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
	sudo /home/pi/services/screensaveroff.sh
	echo 'Скрінсейвер відключено'
fi

# install SmartMirror splashscreen
if [[ $choiceMirrorSplash =~ ^[Yy]$ ]]; then
	bash $logdir1/sm_splash/splashinst.sh
fi

# disable splash screen and 4 raspberries
if [[ $choiceDisableBerries =~ ^[Yy]$ ]]; then
	sudo echo disable_splash=1 >>/boot/config.txt
	sudo echo logo.nologo >>/boot/cmdline.txt
fi

#autostart MM with Desktop
if [[ $choiceAutostartMMWithDesctop =~ ^[Yy]$ ]]; then
	sudo echo npm start --prefix /home/pi/MagicMirror >>/etc/xdg/lxsession/LXDE-pi/autostart
fi

#autostart MM withOUT Desktop
if [[ $choiceAutostartMMWithOutDesctop =~ ^[Yy]$ ]]; then
	sudo echo npm start --prefix /home/pi/MagicMirror >>/home/pi/.config/lxsession/LXDE-pi/autostart
fi

# clone MagicMirror git
if [[ $choiceCloneMagicMirror =~ ^[Yy]$ ]]; then
	sudo rm -rf home/pi/MagicMirror
	sudo git clone --depth=1 https://github.com/MichMich/MagicMirror.git /home/pi/MagicMirror
fi

# install MagicMirror
if [[ $choiceInstallMagicMirror =~ ^[Yy]$ ]]; then
	npm -y install --prefix /home/pi/MagicMirror
	cp -f /home/pi/services/files/config.js /home/pi//MagicMirror/config/config.js
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

# clone MQTT clients
if [[ $choiceCloneMQTTClients =~ ^[Yy]$ ]]; then
	echo 'Клоную гіт mqtt_clients'
	sudo rm -rf home/pi/mqtt_clients
	git clone --depth=1 https://github.com/sergge1/mqtt_clients.git /home/pi/mqtt_clients
	echo 'Гіт mqtt_clients успішно склоновано'
fi

# install Python packages (to SUDO)
if [[ $choiceCloneAndInstallPackages =~ ^[Yy]$ ]]; then
	echo 'Встановлюю пакети jsonschema, paho-mqtt та rpi_ws281x'
	sudo pip install jsonschema
	sudo pip install paho-mqtt
	sudo pip install rpi_ws281x
	echo 'Пакети jsonschema, paho-mqtt та rpi_ws281x встановлено'
fi

# clone and install MM controller
if [[ $choiceCloneAndInstallMMController =~ ^[Yy]$ ]]; then
	sudo rm -rf home/pi/MagicMirror
	git clone --depth=1 https://github.com/kolserdav/mmcontroller.git /home/pi/mmcontroller
	npm -y install --prefix /home/pi/mmcontroller
fi

#use rpi_background.jpg as background picture
