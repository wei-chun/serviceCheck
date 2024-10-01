#!/bin/sh

mapfile < /root/shadowsocks_pid
echo "${MAPFILE[@]}"

dt=$(date '+%Y-%m-%d %H:%M:%S');

if [ ! -f /root/shadowsocks_pid ]; then
    echo "$dt ===> PID file not found!" >> /root/ss_status.log
    # Do something knowing the pid file is not exists, i.e. the process with $PID is not running
    ssserver -c /etc/shadowsocks.json -d start --pid-file /root/shadowsocks_pid
elif ps -p ${MAPFILE[@]} > /dev/null; then
    echo "$dt ===> ${MAPFILE[@]} is running"  >> /root/ss_status.log
else
    echo "$dt ===> ${MAPFILE[@]} is not running" >> /root/ss_status.log
    # Do something knowing the pid is not exists, i.e. the process with $PID is not running
    ssserver -c /etc/shadowsocks.json -d start --pid-file /root/shadowsocks_pid
fi
