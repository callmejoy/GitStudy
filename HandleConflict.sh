#! /bin/bash
rm ~/dump.rdb
echo start dump REDIS_DATA
scp root@CodeInDevBranch:/var/lib/redis/dump.rdb ~/

ssh root@120.25.12.63 > /dev/null 2>&1 << eeooff
redisPID=`pidof redis-server`
if [ $redisPID!="" ]; then
    kill $redisPID
fi
exit
eeooff

echo start upload REDIS_DATA
scp ~/dump.rdb root@120.25.12.63:/var/lib/redis/
rm ~/dump.rdb


chmod 777 /var/lib/redis/dump.rdb
/etc/init.d/redis-server start
exit
eeooff

echo done!
