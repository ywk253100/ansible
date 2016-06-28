#!/bin/bash

ip=172.17.0.5
policy_id=105
repository=sync_001/ubuntu
operation=transfer

create(){
	ip=$1
	policy_id=$2
	repository=$3
	operation=$4
	curl -H "Content-Type: application/json" -X POST -d '{"policy_id":'$policy_id',"repository":"'$repository'","operation":"'$operation'"}' http://$ip/api/jobs/replication
}


for(( i=0;i<10;i=i+1 ));
do
	create $ip $policy_id $repository $operation
done
