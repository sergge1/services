# sm_splash
Скрипт добавляет анимацию в стиле СмартМиррор
на завершение работы и при включении.


sudo rm -rf /usr/share/plymouth/themes/smartmirror

sudo cp -r /smartmirror /usr/share/plymouth/themes/

sudo plymouth-set-default-theme -R smartmirror

Убрать радуга-квадрат при включении:
sudo nano /boot/config.txt	добавить disable_splash=1 
Убрать 4 клубники в верхнем левом углу при включении
sudo nano /boot/cmdline.txt добавить  logo.nologo


Использовать в качестве заставки на рабочий стол (выровнять по центру)
rpi_background.jpg