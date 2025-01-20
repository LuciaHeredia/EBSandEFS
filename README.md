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
* Download **AWS CLI** and verify if it’s properly installed with the command:
  ```
  $ aws --version
  ```
* Create **AWS Access Key**:
  - Go to your AWS account overview.
  - Account menu in the upper-right (has your name on it), press "Security Credentials".
  - In section "Access keys", press "Create access key".
  - Save Access Key in a secure location.
* Configure and login the necessary IAM user with **AWS CLI**:
  ```
  $ aws configure
  ```
  Here we’ll need the access key and secret key for the IAM user, as well as the region id (can be found beside the region name in your AWS account):
  ```
  AWS Access Key ID [None]: accesskey
  AWS Secret Access Key [None]: secretkey
  Default region name [None]: us-west-2
  Default output format [None]:
  ```
  To update just the region name:
  ```
  $ aws configure
  AWS Access Key ID [****]:
  AWS Secret Access Key [****]:
  Default region name [us-west-1]: us-west-2
  Default output format [None]:
  ```
* Launch an **EC2 instance** using **AWS CLI** (specify the necessary details: **AMI ID, instance type, key pair, subnet, security group, and tags**):
  - Get **AMI ID**:
    - Go to "ec2 Dashboard".
    - Then in the left menu click on "Images", and then "AMI Catalog".
    - Here you'll find a list of base images from AWS along with the **AMI ID**.
  - Get **VPC ID** and **Subnet Id**:
    - Go to the "VPC dashboard" and click on "VPCs", here you will get the "VPC ID".
    - Then in the left menu click on "Virtual private cloud", then "Subnets", and search with the "VPC ID" to list all the subnets associated with that **VPC** and copy the "Subnet ID".
  - Setting up **SSH key pair**, in order to authenticate our EC2 instance:
    ```
    $ aws ec2 create-key-pair \       
      --key-name  <your key name> \
      --query '<your query>' --output text > ~/.ssh/<key-file-name>
    ```
  - Setting up a **security group**, in order to control who has access to that instance:
    ```
    $ aws ec2 create-security-group --group-name <group name> --description "rules for this group" --vpc-id <vpc-xxxx>
    ```
  - Finally, Launching the instance:
    ```
    $ aws ec2 run-instances \
      --image-id <ami-id> \
      --instance-type <instance-type> \
      --key-name <ec2-key-pair-name> \
      --subnet-id <subnet-id> \
      --security-group-ids <security-group-id> \
      --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=<instance-name>}]'
    ```
* Create an **EBS volume** in the same **availability zone** and attach it to the launched **EC2 instance**.
  ```
  ???????????????????????????
  ```
### Step 2: Mount EBS Volume Using UserData
* Create a **UserData script ( userdata.sh )** to be executed during instance launch.
* The script should format the **EBS volume**, create a mount point, and mount the volume.
* Ensure the **UserData script** is made executable:
  ```
  chmod +x userdata.sh
  ```
* Launch the **EC2 instance**, including the **UserData script** for automatic **EBS volume** setup.

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
