#!/bin/bash
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
#add line_ npm start --prefix /home/pi/MagicMirror

#добавить автостарт без загрузки интерфейса:
nano /home/pi/.config/lxsession/LXDE-pi/autostart
#и добавить строку_ npm start --prefix /home/pi/MagicMirror
