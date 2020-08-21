#!/bin/bash
rm output.txt
for profs in `aws configure list-profiles` 
do 
	echo -e "\n=====Listing Resoruces in Profile:'$profs'...====="
	echo -e "\n\n\n==========================================================================" >> output.txt
	echo -e "\n====================================================\n" >> output.txt
	echo -e "\n===== Listing Resoruces in Profile:'$profs'... =====\n" >> output.txt
	echo -e "\n====================================================\n" >> output.txt

	for region in `aws ec2 describe-regions --output text | cut -f4`
	do
     		echo -e "\n    Listing EC2 Instance in Profile $profs and region:'$region'..."
     		echo -e "\n    Listing EC2 Instances in region:'$region'and region:'$region'...  \n"  >> output.txt 
		aws ec2 describe-instances --output table  --filter "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,estatus:Tags[?Key=='estatus']|[0].Value,cliente:Tags[?Key=='cliente']|[0].Value,rds:Tags[?Key=='endpoint']|[0].Value,tecnologia:Tags[?Key=='tecnologia']|[0].Value,responsable:Tags[?Key=='responsable']|[0].Value}"  --region $region --profile $profs >> output.txt

     		echo -e "\n    Listing RDS Instances in Profile $profs and region:'$region'... "
     		echo -e "\n    Listing RDS Instances in region:'$region'...\n">> output.txt
      		aws rds describe-db-instances --query "DBInstances[*].{Endpoit:Endpoint.Address,name:DBInstanceIdentifier,Engine:Engine,EngineVersion:EngineVersion,GB:AllocatedStorage,Estatus:DBInstanceStatus}" --output table --region $region --profile $profs >> output.txt

	done
done 
