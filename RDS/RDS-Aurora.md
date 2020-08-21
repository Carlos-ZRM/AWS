
# Crear cluster de AWS Aurora 
## Requisitos 
- id subredes privadas 

# Crear sunet group 
``` console
aws rds create-db-subnet-group --db-subnet-group-name DB-a-SubnetG \
	--db-subnet-group-description "Descripcion de subnet group"  \
	--subnet-ids "subnet-idsubnet-zonaa" "subnet-idsubnet-zonab" \
	--profile default --region us-east-1
```


# Crear cluster de Aurora DB
aws rds create-db-cluster --db-cluster-identifier sample-cluster\
	--engine aurora-mysql --engine-version 5.7.12 \
	--master-username admin --master-user-password P4sSw0ord \
     	--db-subnet-group-name mysubnetgroup \
	--vpc-security-group-ids sg-seg-group

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjAwMjc3NjIzMV19
-->