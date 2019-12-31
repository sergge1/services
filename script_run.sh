#!/bin/bash

echo 'Приступаємо'



echo 'Приступаю до встановлення MagicMirror'




bash -c "$(curl -sL https://raw.githubusercontent.com/MichMich/MagicMirror/master/installers/raspberry.sh)"

echo 'Приступаю до встановлення модулів MagicMirror'
cd ~/MagicMirror/modules
git clone https://github.com/Jopyth/MMM-Remote-Control.git
git clone https://github.com/ronny3050/email-mirror.git email
git clone https://github.com/paviro/MMM-PIR-Sensor.git
git clone https://github.com/javiergayala/MMM-mqtt.git
git clone https://github.com/cybex-dev/MMM-MQTT-Publisher.git


echo 'Встановлюю REMOTECONTROL'
cd ~/MagicMirror/modules/MMM-Remote-Control
npm -y install
echo 'remotecontrol встановлено'

echo 'Встановлюю  EMAIL'
cd ~/MagicMirror/modules/email
npm -y install
echo 'email встановлено'


echo 'Встановлюю MMM-PIR-Sensor'
cd ~/MagicMirror/modules/MMM-PIR-Sensor
npm -y install
sudo usermod -a -G gpio pi
sudo chmod u+s /opt/vc/bin/tvservice && sudo chmod u+s /bin/chvt
echo 'MMM-PIR-Sensor встановлено'

echo 'Встановлюю MMM-mqtt'
cd ~/MagicMirror/modules/MMM-mqtt
npm -y install
echo 'MMM-mqtt встановлено'

echo 'Встановлюю MMM-MQTT-Publisher'
cd ~/MagicMirror/modules/MMM-MQTT-Publisher
npm -y install
echo 'MMM-MQTT-Publisher встановлено'

echo 'Модулі MagicMirror встановлено'

cp -f ~/mqtt_clients/help/config.js ~/MagicMirror/config/config.js
echo 'config файл скопійовано'


echo 'Встановлення всих програм із цього скрипта завершено'



# chmod +x script_run.sh
# ./script_run.sh
