#!/bin/bash
#bash to run on moderator mongo pod
while :
do
if [ -f '/tmp/mongors.log' ]
then
    break
fi
export REPLICATION_STATUS=$(mongo --host mongo-pod-0.mongo-service -u $MONGO_INITDB_ROOT_USERNAME -p "$MONGO_INITDB_ROOT_PASSWORD" <<EOF
rs.status()
EOF
)
echo $REPLICATION_STATUS
sleep 30
mongo --host mongo-pod-0.mongo-pod -u $MONGO_INITDB_ROOT_USERNAME -p "$MONGO_INITDB_ROOT_PASSWORD" <<EOF
rs.initiate()
EOF
mongo --host mongo-pod-0.mongo-pod -u $MONGO_INITDB_ROOT_USERNAME -p "$MONGO_INITDB_ROOT_PASSWORD"  <<EOF 
rsconf = rs.conf()
rsconf.members = [{ _id: 0, host: "mongo-pod-0.mongo-service:27017" }, { _id: 1, host: "mongo-pod-1.mongo-service:27017" }]
rs.reconfig(rsconf, {force: true})
rs.status()
db.isMaster()
rs.conf()
rs.status()
EOF
    echo  $(date) "Replication is done SUCCESSFULLY" >> /tmp/mongors.log
    sleep 10
    break
done




