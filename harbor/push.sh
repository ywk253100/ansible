#!/bin/bash
ip=10.117.4.231
username=admin
password=Harbor12345

images=(data:500m harbor_log:latest ubuntu:14.04 mysql:5.6)
projects=(sync_001 sync_002 sync_003 sync_004 sync_005 sync_006 sync_007 sync_008 sync_009 sync_010)

tag(){
        src=$1
        dst=$2
	docker tag $src $dst
}

login(){
        endpoint=$1
        username=$2
        password=$3
        docker login -u $username -p $password $endpoint
}

push(){
        image=$1
        docker push $image
}

pushImage(){
        src=$1
        ip=$2
        project=$3
        username=$4
        password=$5

	tag $src $ip/$project/$src \
        && login $ip $username $password \
	&& push $ip/$project/$src
}

for project in "${projects[@]}"
do
	for image in "${images[@]}"
	do
		pushImage $image $ip $project $username $password
	done
done

