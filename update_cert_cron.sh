#!/bin/bash
# createed by wanglin at 20181208
# run on every two month

logfile="/tmp/update_cert_cron.log"
echo "$(date +%Y%m%d-%H%M%S) update cert" >> $logfile

# run job at workday
if [ $(date +%u) -lt 5 ];then
    # request new cert
    # no -t with crontab
    docker run --rm --name alidns -e ALI_SECRET_ID=xxx -e ALI_SECRET_KEY=xxx -v /data/ssl/:/etc/letsencrypt/ hub.digi-sky.com/base/alidns:1.0.0 >> $logfile 2>&1
    
    if [ $? -eq 0 ];then
        # restart container
        echo "$(date +%Y%m%d-%H%M%S) update server" >> $logfile
        docker stop gitlabce_web_1 >> $logfile 2>&1
        docker start gitlabce_web_1 >> $logfile 2>&1
    fi
else
    echo "$(date +%Y%m%d-%H%M%S) dont run job at workend" >> $logfile
fi
