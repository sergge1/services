#/bin/bash

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log
echo -e "\e[96mСКРИПТ ВСТАНОВЛЕННЯ ЗАПУЩЕНО...\e[0m" | tee -a $logfile

normal=$(echo "\033[m")
boldRed=$(echo "\033[01;31m")   #bold Red
boldGreen=$(echo "\033[01;92m") #bold Green
green=$(echo "\033[01;92m")     #bold Green
boldBlue=$(echo "\033[01;36m")  #bold Blue
blue=$(echo "\033[36m")         #Blue
yellow=$(echo "\033[33m")       #Yellow

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

# uninstall unnecessary apps on raspberry
if [[ $choiceDelUnnecessaryApp =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Видаляю необов'язкове ПЗ${normal}"
	sudo /home/pi/smsetup/uninstall.sh
	printf "${boldGreen}Необов'язкове ПЗ видалено${normal}"
	echo ''
fi

# install updates to raspberry
if [[ $choiceInstRaspbUpdates =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю оновлення Raspbian${normal}"
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt-get clean -y
	sudo apt-get autoremove -y
	printf "${boldGreen}Оновлення Raspbian встановлено${normal}"
	echo ''
fi

# install docker
if [[ $choiceInstDocker =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю Docker${normal}"
	sudo curl -sSL https://get.docker.com | sh
	sudo usermod -aG docker pi
	printf "${boldGreen}Docker встановлено${normal}"
	echo ''
fi

# install samba
if [[ $choiceInstSamba =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю SAMBA SERVER${normal}"
	printf "${green}Встановлюю додаток SAMBA${normal}"
	sudo apt-get install -y samba samba-common-bin
	printf "${green}Додаток успішно встановлено${normal}"
	echo ""
	printf "${green}Копіюю налаштування ${blue}/home/pi/smsetup/files/smb.conf >> /etc/samba${normal}"
	sudo rm /etc/samba/smb.conf
	sudo cp /home/pi/smsetup/files/smb.conf /etc/samba
	printf "${green}Налаштування Samba скопійовано${normal}"
	#sudo smbpasswd -a pi
	printf "${green}Запускаю Samba сервіс${normal}"
	sudo systemctl restart smbd
	printf "${green}Samba сервіс успішно запущено${normal}"
	printf "${boldGreen}Встановлюю SAMBA успішно встановлено${normal}"
	echo ''
fi

# install NodeJS
if [[ $choiceInstNodeJS =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю Nodejs${normal}"
	sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
	sudo apt-get install -y nodejs
	printf "${boldGreen}Nodejs встановлено${normal}"
	echo ''
fi

#mosquitto
if [[ $choiceInstMosquitto =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Завантажую докер-контейнер Eclipse-Mosquitto${normal}"
	sudo docker pull eclipse-mosquitto
	printf "${boldGreen}Контейнер Eclipse-Mosquitto завантажено${normal}"
	echo ''
fi

# pm2 install
if [[ $choiceInstPM2 =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю pm2${normal}"
	sudo npm install -g pm2
	pm2 startup
	printf "${boldGreen}pm2 встановлено${normal}"
	echo ''
fi

# disable screensaver
if [[ $choiceDisableScreensaver =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Відключаю скрінсейвер${normal}"
	sudo /home/pi/smsetup/screensaveroff.sh
	printf "${boldGreen}Скрінсейвер відключено${normal}"
	echo ''
fi

# install SmartMirror splashscreen
if [[ $choiceMirrorSplash =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю анімацію при ввімкненні та вимкненні${normal}"
	bash $logdir/sm_splash/splashinst.sh
	printf "${boldGreen}Анімацію при ввімкненні та вимкненні налаштована${normal}"
	echo ''
fi

# disable splash screen and 4 raspberries
if [[ $choiceDisableBerries =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Відключаю відображення кольорового екерану та полуниць при ввімкненні${normal}"
	sudo su -c "echo disable_splash=1 >> /boot/config.txt"
	sudo su -c "echo logo.nologo >> /boot/cmdline.txt"
	printf "${boldGreen}Відображення кольорового екерану та полуниць при ввімкненні вимкнено${normal}"
	echo ''
fi

#autostart MM with Desktop
if [[ $choiceAutostartMMWithDesctop =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Автостарт ММ з графічною оболонкою${normal}"
	sudo -u root echo npm start --prefix /home/pi/MagicMirror >>/etc/xdg/lxsession/LXDE-pi/autostart
	printf "${boldGreen}Ввімкнено автостарт ММ з графічною оболонкою${normal}"
	echo ''
fi

#autostart MM withOUT Desktop
if [[ $choiceAutostartMMWithOutDesctop =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Автостарт ММ БЕЗ графічної оболонки${normal}"
	sudo -u root echo npm start --prefix /home/pi/MagicMirror >>/home/pi/.config/lxsession/LXDE-pi/autostart
	printf "${boldGreen}Автостарт ММ БЕЗ графічної оболонки ввімкнено${normal}"
	echo ''
fi

# clone MagicMirror git
if [[ $choiceCloneMagicMirror =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Клонування пакету MagicMirror${normal}"
	sudo rm -rf home/pi/MagicMirror
	printf "${green}Видалили папку ~/MagicMirror, якщо така існувала${normal}"
	git clone --depth=1 https://github.com/MichMich/MagicMirror.git /home/pi/MagicMirror
	printf "${green}Склонували пакет MagicMirror${normal}"
	sudo cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
	printf "${green}Скопіювали файл налаштувань MagicMirror${normal}"
	printf "${boldGreen}Пакет MagicMirror успішно склоновано${normal}"
	echo ''
fi

# install MagicMirror
if [[ $choiceInstallMagicMirror =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю пакет MagicMirror${normal}"
	npm -y install --prefix /home/pi/MagicMirror
	sudo cp -f /home/pi/smsetup/files/config.js /home/pi/MagicMirror/config/config.js
	printf "${boldGreen}Пакет MagicMirror успішно встановлений${normal}"
	echo ''
fi

# install and clone MM modules
if [[ $choiceCloneAndInstallMMModules =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Приступаю до встановлення модулів MagicMirror${normal}"
	printf "${green}Клоную модулі MagicMirror${normal}"
	cd /home/pi/MagicMirror/modules
	git clone --depth=1 https://github.com/Jopyth/MMM-Remote-Control.git
	git clone --depth=1 https://github.com/ronny3050/email-mirror.git email
	git clone --depth=1 https://github.com/paviro/MMM-PIR-Sensor.git
	git clone --depth=1 https://github.com/javiergayala/MMM-mqtt.git
	git clone --depth=1 https://github.com/cybex-dev/MMM-MQTT-Publisher.git
	git clone --depth=1 https://github.com/AgP42/MMM-SmartWebDisplay.git
	git clone --depth=1 https://github.com/mboskamp/MMM-PIR.git
	printf "${green}Модулі MagicMirror успішно встановлені${normal}"
	echo ''
	printf "${green}Встановлюю REMOTECONTROL${normal}"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-Remote-Control
	printf "${green}remotecontrol встановлено${normal}"
	echo ''
	printf "${green}Встановлюю  EMAIL${normal}"
	npm -y install --prefix /home/pi/MagicMirror/modules/email
	printf "${green}email встановлено${normal}"
	echo ''
	printf "${green}Встановлюю MMM-mqtt${normal}"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-mqtt
	printf "${green}MMM-mqtt встановлено${normal}"
	echo ''
	printf "${green}Встановлюю MMM-MQTT-Publisher${normal}"
	npm -y install --prefix /home/pi/MagicMirror/modules/MMM-MQTT-Publisher
	printf "${green}MMM-MQTT-Publisher встановлено${normal}"
	echo ''
	printf "${green}Встановлюю /MMM-PIR${normal}"
	sudo npm -y install --prefix /home/pi/MagicMirror/modules/MMM-PIR
	printf "${green}MMM-PIR встановлено${normal}"
	echo ''
	printf "${boldGreen}Модулі MagicMirror встановлено${normal}"
	echo ''
fi

# install Python packages (to SUDO)
if [[ $choiceCloneAndInstallPackages =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлюю пакети ${blue}jsonschema${boldGreen}, ${blue}paho-mqtt${boldGreen} та ${blue}rpi_ws281x${normal}"
	pip install jsonschema
	sudo pip install paho-mqtt
	sudo pip install rpi_ws281x
	printf "${boldGreen}Пакети ${blue}jsonschema${boldGreen}, ${blue}paho-mqtt${boldGreen} та ${blue}rpi_ws281x${boldGreen} встановлено${normal}"
	echo ''
fi

# clone MQTT clients
if [[ $choiceCloneMQTTClients =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Клоную гіт mqtt_clients${normal}"
	rm -rf home/pi/mqtt_clients
	git clone --depth=1 https://github.com/sergge1/mqtt_clients.git /home/pi/mqtt_clients
	printf "${boldGreen}Гіт mqtt_clients успішно склоновано${normal}"
	echo ''
fi

# clone and install MM controller
if [[ $choiceCloneAndInstallMMController =~ ^[Yy]$ ]]; then
	printf "${boldGreen}Встановлення пакету mmcontroller${normal}"
	rm -rf home/pi/MagicMirror
	git clone --depth=1 https://github.com/kolserdav/mmcontroller.git /home/pi/mmcontroller
	npm -y install --prefix /home/pi/mmcontroller
	printf "${boldGreen}Встановлення пакету mmcontroller успішно завершено${normal}"
	echo ''
fi

#use rpi_background.jpg as background picture
#docker run -p 1883:1883 --restart=always eclipse-mosquitto
