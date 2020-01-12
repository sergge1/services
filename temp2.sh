#/bin/bash

logdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
logfile=$logdir/install.log
echo -e "\e[96mСКРИПТ ВСТАНОВЛЕННЯ ЗАПУЩЕНО...\e[0m" | tee -a $logfile

normal=$(echo "\033[m")
boldRed=$(echo "\033[01;31m")   #bold Red
boldGreen=$(echo "\033[01;92m") #bold Green
green=$(echo "\033[92m")        #bold Green
boldBlue=$(echo "\033[01;36m")  #bold Blue
blue=$(echo "\033[36m")         #Blue
yellow=$(echo "\033[33m")       #Yellow

printf "${yellow}  2. ${blue}Встановити оновлення всіх пакетів на Raspberry? (Y/n)? ${normal}"
choiceInstRaspbUpdates=y
read choiceInstRaspbUpdates

if [[ $choiceInstRaspbUpdates =~ ^[Yy]$ ]]; then
    printf "${boldGreen}Відключаю скрінсейвер${normal}\n"
    bash /home/pi/smsetup/screensaveroff.sh
    printf "${boldGreen}Скрінсейвер відключено${normal}\n"
    echo ''
fi
