#!/bin/bash
# By Alphabug
# Github https://github.com/AlphabugX/csOnvps
Alphabug_CS_PATH=`pwd`

function radom_key(){
    KEY=`uuid | md5sum |awk -F' ' '{ print $1}'`
    echo $KEY
}
sudo apt update && sudo apt install unrar uuid dos2unix -y

# rm -rf *.tar*
# 改K8 CS的默认配置，改成随机

IP="184.75.223.219"
PASSWORD=`radom_key`
KEYPASS=`radom_key`

dos2unix ./cobaltstrike4/teamserver
chmod 777 ./cobaltstrike4/*
cd ./cobaltstrike4/


PORT=20648
# 配置teamserver
sed -i "s/SET_TEAMSERVER_PORT/$PORT/g" teamserver
sed -i "s/SET_TEAMSERVER_KEY/$KEYPASS/g" teamserver

install_log="$cobaltstrike4/install.log"

echo "[+] Teamserver IP:" $IP >> $install_log
echo "[+] Teamserver Port:" $PORT >> $install_log
echo "[+] Teamserver Password:" $PASSWORD >> $install_log
echo "[+] Teamserver keyStorePassword:" $KEYPASS >> $install_log


nohup ./teamserver $IP $PASSWORD &

PID=`sudo ps -ef | grep $PASSWORD |awk -F" " '{ print $2 }' |tr "\n" " "` >> $install_log
echo "[+] Teamserver PID:" $PID >> $install_log
echo "[*] Teamserver stop Command: kill -KILL " $PID >> $install_log
# echo "[!] Remove Sun JDK Command:"  >> $install_log
# echo Zm9yIGl0ZW0gaW4gYGxzIC1sc2EgL3Vzci9iaW4vIHxncmVwIGpkayB8YXdrIC1GIiAiICd7IHByaW50ICQxMH0nYDsgZG8gZWNobyAiRGVsIC91c3IvYmluLyIkaXRlbTtybSAtcmYgIi91c3IvYmluLyIkaXRlbTtkb25lCg== | base64 -d >> $install_log
echo "[!] Remove Alphabug_CS Command: rm -rf "$Alphabug_CS_PATH  >> $install_log
cat $install_log
if [ ! -d "$Alphabug_CS_PATH/log" ]; then
    mkdir $Alphabug_CS_PATH/log
fi

mv $install_log $Alphabug_CS_PATH/log/`date +%Y%m%d_%H%M%S.log`
# uninstall script
#uninstall=./cobaltstrike4/uninstall.sh

echo "kill -KILL " $PID >> $uninstall
#chmod +x $uninstall
echo "[+] Install_Log Saved to file:" $install_log
echo "[+] uninstall.sh Saved to file:" $uninstall
