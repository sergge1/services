Скрипт добавляет сервис в systemd tempcontrol.
Сервис каждую минуту отслеживает температуру устройтва, и если она превышает 75 С,
то устройство отключается автоматически.

sudo chmod u+x tempcontrol.sh

systemd forum discussion
https://blog.skbali.com/2019/03/start-a-script-on-boot-using-systemd/


sudo cp /home/pi/services/tempcontrol/tempcontrol.service /etc/systemd/system/tempcontrol.service
sudo cp /home/pi/services/tempcontrol/tempcontrol.timer /etc/systemd/system/tempcontrol.timer

Отобржение лога всех операций в системе:
journalctl -e
ps -ef | grep monitor

Просмотреть работу отдельного сервиса:
systemctl status tempcontrol.service

Обновить системд команды

systemctl daemon-reload
systemctl enable tempcontrol.timer
systemctl start tempcontrol.timer

systemctl enable tempcontrol.service
systemctl start tempcontrol

Таймер в системД
https://unix.stackexchange.com/questions/198444/run-script-every-30-min-with-systemd
https://www.freedesktop.org/software/systemd/man/systemd.timer.html
https://seanmcgary.com/posts/how-to-use-systemd-timers/

