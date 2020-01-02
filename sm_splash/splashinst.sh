#!/bin/bash
# sudo chmod +x splashinst.sh
# sudo ./splashinst.sh

sudo rm -rf /usr/share/plymouth/themes/smartmirror

sudo cp -r /smartmirror /usr/share/plymouth/themes/

sudo plymouth-set-default-theme -R smartmirror
