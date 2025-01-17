# Explanation:
## EBS (Elastic Block Store):
* An ***Amazon EBS Volume*** is a durable, block-level storage device that can be attached to ***Amazon EC2 instances***. <br/>
* Useful for storing data that requires frequent updates, such as system drives for instances or databases. <br/>
* They are specific to an ***availability zone*** and can be migrated between zones using ***snapshots***, but they cannot be attached to instances in different zones. <br/>
* It can be created during the process of creating an ***EC2 instance*** or as standalone volumes and attached to running ***EC2 instances***. <br/>

## EFS (Elastic File System):
* An ***AWS EFS volume*** is a scalable, simple, and managed file storage service, provided by ***Amazon Web Services (AWS)***. <br/>
* Useful for applications that require shared storage(from a ***file system***) across multiple ***Amazon Elastic Container Service (ECS) tasks*** or ***Amazon EC2 instances***. <br/>
* They are designed to be highly available and scalable, automatically adjusting ***storage capacity*** as you add or remove files. <br/>

<br/>

# Tasks + Steps:
## Mission 1: Launch EC2 Instance with EBS Volume and UserData
### Step 1: Launch EC2 Instance with EBS Volume
* Launch an EC2 instance using AWS CLI.
* Specify the necessary details, including AMI ID, instance type, key pair, subnet, security group, and tags.
* Create an EBS volume in the same availability zone and attach it to the launched EC2 instance.
### Step 2: Mount EBS Volume Using UserData
* Create a UserData script ( userdata.sh ) to be executed during instance launch.
* The script should format the EBS volume, create a mount point, and mount the volume.
* Ensure the UserData script is made executable ( chmod +x userdata.sh ).
* Launch the EC2 instance, including the UserData script for automatic EBS volume setup.

## Mission 2: Create and Mount EFS Volume
### Step 1: Create an EFS Volume
* Navigate to the AWS Management Console and access the EFS service.
* Create a new EFS file system, specifying VPC, name, performance mode, and throughput mode.
* Configure network access, including selecting VPC and defining security groups.
* Review and create the file system.
### Step 2: Mount EFS Volume on EC2 Instance
* Install the EFS mount helper on the EC2 instance using the package manager.
* Create a mount point on the EC2 instance for the EFS volume.
* Mount the EFS volume to the specified mount point.
* Access the DNS name of the EFS file system from the console for mounting on EC2 instances.
