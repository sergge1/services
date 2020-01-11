#/bin/bash

if [ -z "$BASH_VERSION" ]
then
    exec bash "$0" "$@"
fi

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log

choiceMirrorSplash=y
read -p "Встановлювати анімацію вкл\вимкн SmartMirror? (Y/n)?" choiceMirrorSplash
if [[ $choiceMirrorSplash =~ ^[Yy]$ ]]; then
	bash $logdir/sm_splash/splashinst.sh
fi

