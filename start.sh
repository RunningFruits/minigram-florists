#!/bin/bash 
nohup java -Xms512m -Xmx512m -jar wechat_order-0.0.1-SNAPSHOT.jar > /dev/null 2>&1 &
#record the process id
echo $!>pid
