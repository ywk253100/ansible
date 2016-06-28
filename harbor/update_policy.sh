#!/bin/bash

harbor_endpoint=http://10.117.4.231
harbor_username=admin
harbor_password=Harbor12345
policy_ids=(1 4 5 6 7 8 9 10 11 12)
enabled=$1

create_target(){
	harbor_endpoint=$1
	harbor_username=$2
	harbor_password=$3
	target_name=$4
	target_endpoint=$5
	target_username=$6
	target_password=$7
	curl -X POST -u $username:$password -d '{"name":"'$target_name'","endpoint":"'$target_endpoint'","username":"'$target_username'","password":"'$target_password'"}' $endpoint
}

create_policy(){
	harbor_endpoint=$1
        harbor_username=$2
        harbor_password=$3
        policy_name=$4
	project_id=$5
}

update_policy(){
	harbor_endpoint=$1
        harbor_username=$2
        harbor_password=$3
	policy_id=$4
	enabled=$5
	curl -H "Content-Type: application/json" -X PUT -u $harbor_username:$harbor_password -d '{"enabled":'$enabled'}' $harbor_endpoint/api/policies/replication/$policy_id/enablement
}


#for policy_id in "${policy_ids[@]}"
for (( i=2; i<=31; i=i+1 ));
do
        update_policy $harbor_endpoint $harbor_username $harbor_password $i $enabled
done
