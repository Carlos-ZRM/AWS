

# Concepts
- vpc 
	- A virtual private cloud (VPC) is a virtual network dedicated to your AWS account. It is logically isolatedfrom other virtual networks in the AWS Cloud. You can launch your AWS resources, such as Amazon EC2instances, into your VPC. You can specify an IP address range for the VPC, add subnets, associate securitygroups, and configure route tables
- Subnet
	- A subnet is a range of IP addresses in your VPC. You can launch AWS resources into a specified subnet.Use a public subnet for resources that must be connected to the internet, and a private subnet forresources that won't be connected to the internet
-  Default vpc 
	- Includes an internet gateway, and each default subnet is a public subnet. Each instance that you launch into a default subnet has a private IPv4 address and a public IPv4 address. These instances can communicate with the internet through the internet gateway. An internet gateway enablesyour instances to connect to the internet through the Amazon EC2 network edge
	- 
	
> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTg3NzI0NTg1NywtMTcyMzk0ODYzNywtMz
Y4MzgxMDcwXX0=
-->