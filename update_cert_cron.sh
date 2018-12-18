$ cat update_cert_cron.sh 
#!/bin/bash
# createed by wanglin at 20181208

logfile="/tmp/update_cert_cron.log"
echo $(date +%Y%m%d-%H%M%S) >> $logfile

# request new cert
docker run -it --rm --name alidns -e ALI_SECRET_ID=xxx -e ALI_SECRET_KEY=xxx -v /data/ssl/:/etc/letsencrypt/ hub.digi-sky.com/base/alidns:1.0.0 2>&1 >> $logfile

if [ $? -eq 0 ];then
    # generate config files with new cert
    cd /home/docker/gitlab/harbor && ./prepare --with-clair 2>&1 >> $logfile
    
    # restart container
    su - docker -c "cd /home/docker/gitlab/harbor && docker-compose stop" 2>&1 >> $logfile
    su - docker -c "cd /home/docker/gitlab/harbor && docker-compose start" 2>&1 >> $logfile
fi
