#!/bin/bash
read -p "Input redis port : " port

export PORT=${port}
useradd redis
echo 'redis ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

if [[ -f /usr/bin/apt ]]
then
	echo -e "Using Debian/Ubuntu distribution \n"
	su -p redis -c '
		whoami
		sudo apt update && sudo apt install -y redis-server 
		redis-server --port ${PORT} --daemonize yes'

elif [[ -f /usr/bin/dnf ]]
then
	echo -e "Using RHEL/CentOS distribution \n"
	su -p redis -c '
		whoami
		sudo dnf update && sudo dnf install -y redis 
		redis-server --port ${PORT} --daemonize yes'

else
	echo "please use based Debian/RHEL distribution"
fi