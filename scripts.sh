#/bin/bash

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}\n")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log
normal=$(echo "\033[m")
boldRed=$(echo "\033[01;31m")   #bold Red
boldGreen=$(echo "\033[01;92m") #bold Green
green=$(echo "\033[32m")        #Green
boldBlue=$(echo "\033[01;36m")  #bold Blue
blue=$(echo "\033[00;36m")      #Blue
titleBlue=$(echo "\033[01;96m") #bold Blue
yellow=$(echo "\033[00;33m")    #Yellow

echo ''
printf "${titleBlue}СКРИПТ ВСТАНОВЛЕННЯ ЗАПУЩЕНО...${normal}\n" | tee -a $logfile
echo ''

printf "${yellow}  1. ${blue}Видалити необов'язкові пакети на Raspberry? (Y/n)? ${normal}" | tee -a $logfile
choiceDelUnnecessaryApp=n
read choiceDelUnnecessaryApp

printf "${yellow}  2. ${blue}Встановити оновлення всіх пакетів на Raspberry? (Y/n)? ${normal}"
choiceInstRaspbUpdates=y
read choiceInstRaspbUpdates

printf "${yellow}  3. ${blue}Встановити Docker? (Y/n)? ${normal}"
choiceInstDocker=y
read choiceInstDocker

printf "${yellow}  4. ${blue}Встановити сервер Samba? (Y/n)? ${normal}"
choiceInstSamba=y
read choiceInstSamba

printf "${yellow}  5. ${blue}Встановити NodeJS? (Y/n)? ${normal}"
choiceInstNodeJS=y
read choiceInstNodeJS

printf "${yellow}  6. ${blue}Завантажити docker-контейнер MQTT брокера Eclipse-Mosquitto? (Y/n)? ${normal}"
choiceInstMosquitto=y
read choiceInstMosquitto

printf "${yellow}  7. ${blue}Встановити сервіс PM2? (Y/n)? ${normal}"
choiceInstPM2=y
read choiceInstPM2

printf "${yellow}  8. ${blue}Відключити скрінсейвер? (Y/n)? ${normal}"
choiceDisableScreensaver=y
read choiceDisableScreensaver

printf "${yellow}  9. ${blue}Встановити анімацію вкл\вимкн SmartMirror? (Y/n)? ${normal}"
choiceMirrorSplash=y
read choiceMirrorSplash

printf "${yellow}  10. ${blue}Відключити заставку включення та 4 полуниці при ввімкненні? (Y/n)? ${normal}"
choiceDisableBerries=y
read choiceDisableBerries

printf "${yellow}  11. ${blue}Встановити автозапуск MagicMirror з декстоп-інтерфейсом? (Y/n)? ${normal}"
choiceAutostartMMWithDesctop=y
read choiceAutostartMMWithDesctop

printf "${yellow}  12. ${blue}Встановити автозапуск MagicMirror БЕЗ декстоп-інтерфейсу? (Y/n)? ${normal}"
choiceAutostartMMWithOutDesctop=y
read choiceAutostartMMWithOutDesctop

printf "${yellow}  13. ${blue}Клонувати MagicMirror? (Y/n)? ${normal}"
choiceCloneMagicMirror=y
read choiceCloneMagicMirror

printf "${yellow}  14. ${blue}Встановити MagicMirror? (Y/n)? ${normal}"
choiceInstallMagicMirror=y
read choiceInstallMagicMirror

printf "${yellow}  15. ${blue}Завантажити та встановити модулі MagicMirror? (Y/n)? ${normal}"
choiceCloneAndInstallMMModules=y
read choiceCloneAndInstallMMModules

printf "${yellow}  16. ${blue}Завантажити на встановити MMController? (Y/n)? ${normal}"
choiceCloneAndInstallMMController=y
read choiceCloneAndInstallMMController

printf "${yellow}  17. ${blue}Завантажити клієнти MQTT? (Y/n)? ${normal}"
choiceCloneMQTTClients=y
read choiceCloneMQTTClients

printf "${yellow}  18. ${blue}Встановити пакети: jsonschema, paho-mqtt та rpi_ws281x? (Y/n)? ${normal}"
choiceCloneAndInstallPackages=y
read choiceCloneAndInstallPackages
echo ''

# uninstall unnecessary apps on raspberry
if [[ $choiceDelUnnecessaryApp =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Видаляю необов'язкове ПЗ${normal}\n"
	sudo /home/pi/smsetup/uninstall.sh
	printf "${boldGreen}Необов'язкове ПЗ видалено${normal}\n"
	echo ''
fi

# install updates to raspberry
if [[ $choiceInstRaspbUpdates =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю оновлення Raspbian${normal}\n"
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get clean -y
	sudo apt-get autoremove -y
	printf "${boldGreen}Оновлення Raspbian встановлено${normal}\n"
	echo ''
fi

# install docker
if [[ $choiceInstDocker =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю Docker${normal}\n"
	curl -sSL https://get.docker.com | sh
	sudo usermod -aG docker pi
	printf "${boldGreen}Docker встановлено${normal}\n"
	echo ''
fi

# install samba
if [[ $choiceInstSamba =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю SAMBA SERVER${normal}\n"
	printf "${green}Встановлюю додаток SAMBA${normal}\n"
	sudo apt-get install -y samba samba-common-bin
	printf "${green}Додаток успішно встановлено${normal}\n"
	printf "${green}Копіюю налаштування ${blue}/home/pi/smsetup/files/smb.conf >> /etc/samba${normal}\n"
	sudo rm /etc/samba/smb.conf
	sudo cp /home/pi/smsetup/files/smb.conf /etc/samba
	#sudo smbpasswd -a pi
	printf "${green}Запускаю Samba сервіс${normal}\n"
	sudo systemctl restart smbd
	printf "${boldGreen}Встановлюю SAMBA успішно встановлено${normal}\n"
	echo ''
fi

# install NodeJS
if [[ $choiceInstNodeJS =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю Nodejs${normal}\n"
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs
	printf "${boldGreen}Nodejs встановлено${normal}\n"
	echo ''
fi

#mosquitto
if [[ $choiceInstMosquitto =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Завантажую докер-контейнер Eclipse-Mosquitto${normal}\n"
	sudo docker pull eclipse-mosquitto
	printf "${boldGreen}Контейнер Eclipse-Mosquitto завантажено${normal}\n"
	echo ''
fi

# pm2 install
if [[ $choiceInstPM2 =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю pm2${normal}\n"
	sudo npm install -g pm2
	pm2 startup
	printf "${boldGreen}pm2 встановлено${normal}\n"
	echo ''
fi

# disable screensaver
if [[ $choiceDisableScreensaver =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Відключаю скрінсейвер${normal}\n"
	bash /home/pi/smsetup/screensaveroff.sh
	printf "${boldGreen}Скрінсейвер відключено${normal}\n"
	echo ''
fi

# install SmartMirror splashscreen
if [[ $choiceMirrorSplash =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю анімацію при ввімкненні та вимкненні${normal}\n"
	bash $logdir/sm_splash/splashinst.sh
	printf "${boldGreen}Анімацію при ввімкненні та вимкненні налаштована${normal}\n"
	echo ''
fi

# disable splash screen and 4 raspberries
if [[ $choiceDisableBerries =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Відключаю відображення кольорового екерану та полуниць при ввімкненні${normal}\n"
	sudo su -c "echo disable_splash=1 >> /boot/config.txt"
	sudo su -c "echo logo.nologo >> /boot/cmdline.txt"
	printf "${boldGreen}Відображення кольорового екерану та полуниць при ввімкненні вимкнено${normal}\n"
	echo ''
fi

#autostart MM with Desktop
if [[ $choiceAutostartMMWithDesctop =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Автостарт ММ з графічною оболонкою${normal}\n"
	sudo su -c "echo npm start --prefix /home/pi/MagicMirror >>/etc/xdg/lxsession/LXDE-pi/autostart"
	printf "${boldGreen}Ввімкнено автостарт ММ з графічною оболонкою${normal}\n"
	echo ''
fi

#autostart MM withOUT Desktop
if [[ $choiceAutostartMMWithOutDesctop =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Автостарт ММ БЕЗ графічної оболонки${normal}\n"
	sudo su -c "echo npm start --prefix /home/pi/MagicMirror >>/home/pi/.config/lxsession/LXDE-pi/autostart"
	printf "${boldGreen}Автостарт ММ БЕЗ графічної оболонки ввімкнено${normal}\n"
	echo ''
fi

# clone MagicMirror git
if [[ $choiceCloneMagicMirror =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Клонування пакету MagicMirror${normal}\n"
	sudo rm -rf home/pi/MagicMirror
	printf "${green}Видалили папку ~/MagicMirror, якщо така існувала${normal}\n"
	git clone --depth=1 https://github.com/MichMich/MagicMirror.git /home/pi/MagicMirror
	printf "${green}Склонували пакет MagicMirror${normal}\n"
	cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
	printf "${green}Скопіювали файл налаштувань MagicMirror${normal}\n"
	printf "${boldGreen}Пакет MagicMirror успішно склоновано${normal}\n"
	echo ''
fi

# install MagicMirror
if [[ $choiceInstallMagicMirror =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю пакет MagicMirror${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror
	sudo cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
	printf "${boldGreen}Пакет MagicMirror успішно встановлений${normal}\n"
	echo ''
fi

# install and clone MM modules
if [[ $choiceCloneAndInstallMMModules =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Приступаю до встановлення модулів MagicMirror${normal}\n"
	cd /home/pi/MagicMirror/modules
	printf "${green}Клоную модуль MMM-Remote-Control${normal}\n"
	git clone --depth=1 https://github.com/Jopyth/MMM-Remote-Control.git
	printf "${green}Клоную модуль email-mirror${normal}\n"
	git clone --depth=1 https://github.com/ronny3050/email-mirror.git email
	printf "${green}Клоную модуль MMM-PIR-Sensor${normal}\n"
	git clone --depth=1 https://github.com/paviro/MMM-PIR-Sensor.git
	printf "${green}Клоную модуль MMM-mqtt${normal}\n"
	git clone --depth=1 https://github.com/javiergayala/MMM-mqtt.git
	printf "${green}Клоную модуль MMM-MQTT-Publisher${normal}\n"
	git clone --depth=1 https://github.com/cybex-dev/MMM-MQTT-Publisher.git
	printf "${green}Клоную модуль MMM-SmartWebDisplay${normal}\n"
	git clone --depth=1 https://github.com/AgP42/MMM-SmartWebDisplay.git
	printf "${green}Клоную модуль MMM-PIR${normal}\n"
	git clone --depth=1 https://github.com/mboskamp/MMM-PIR.git
	echo ''
	printf "${green}Встановлюю REMOTECONTROL${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-Remote-Control
	echo ''
	printf "${green}Встановлюю  EMAIL${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror/modules/email
	echo ''
	printf "${green}Встановлюю MMM-mqtt${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-mqtt
	echo ''
	printf "${green}Встановлюю MMM-MQTT-Publisher${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-MQTT-Publisher
	echo ''
	printf "${green}Встановлюю /MMM-PIR${normal}\n"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-PIR
	printf "${green}Модулі встановлено${normal}\n"
	echo ''
	printf "${boldGreen}Модулі MagicMirror встановлено${normal}\n"
	echo ''
fi

# install Python packages (to SUDO)
if [[ $choiceCloneAndInstallPackages =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю пакети ${blue}jsonschema${boldGreen}, ${blue}paho-mqtt${boldGreen} та ${blue}rpi_ws281x${normal}\n"
	pip install jsonschema
	sudo pip install paho-mqtt
	sudo pip install rpi_ws281x
	printf "${boldGreen}Пакети ${blue}jsonschema${boldGreen}, ${blue}paho-mqtt${boldGreen} та ${blue}rpi_ws281x${boldGreen} встановлено${normal}\n"
	echo ''
fi

# clone MQTT clients
if [[ $choiceCloneMQTTClients =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Клоную гіт mqtt_clients${normal}\n"
	rm -rf home/pi/mqtt_clients
	git clone --depth=1 https://github.com/sergge1/mqtt_clients.git /home/pi/mqtt_clients
	printf "${boldGreen}Гіт mqtt_clients успішно склоновано${normal}\n"
	echo ''
fi

# clone and install MM controller
if [[ $choiceCloneAndInstallMMController =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлення пакету mmcontroller${normal}\n"
	rm -rf home/pi/MagicMirror
	git clone --depth=1 https://github.com/kolserdav/mmcontroller.git /home/pi/mmcontroller
	npm -y install --prefix /home/pi/mmcontroller
	printf "${boldGreen}Встановлення пакету mmcontroller успішно завершено${normal}\n"
	echo ''
fi

#use rpi_background.jpg as background picture
