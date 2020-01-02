sudo chmod u+x tempcontrol.sh

systemd forum discussion
https://blog.skbali.com/2019/03/start-a-script-on-boot-using-systemd/

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

