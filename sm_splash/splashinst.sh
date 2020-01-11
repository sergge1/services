#!/bin/bash
logdirTmp="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo rm -rf /usr/share/plymouth/themes/smartmirror

sudo cp -r $logdirTmp/smartmirror /usr/share/plymouth/themes/

sudo plymouth-set-default-theme -R smartmirror
