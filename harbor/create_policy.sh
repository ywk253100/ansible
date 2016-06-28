#!/bin/bash

harbor_endpoint=http://10.117.4.231
harbor_username=admin
harbor_password=Harbor12345
project_ids=(2 3 4 5 6 7 8 9 10 11)
target_ids=(2 3 4)
enabled=$1

create_policy(){
        endpoint=$1
        username=$2
        password=$3
        policy_name=$4
        project_id=$5
	target_id=$6
	curl -H "Content-Type: application/json" -X POST -u $username:$password -d '{"name":"'$policy_name'","project_id":'$project_id',"target_id":'$target_id',"enabled":0}' $endpoint/api/policies/replication/
}

for project in "${project_ids[@]}"
do
	for target in "${target_ids[@]}"
	do
		create_policy $harbor_endpoint $harbor_username $harbor_password ${project}_$target $project $target
	done
done
