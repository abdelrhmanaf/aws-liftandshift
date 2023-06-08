# Deploying a Multi-Tier Application on AWS Using Lift and Shift Strategy

This repository contains code and configuration files for deploying a multi-tier application on AWS using the Lift and Shift strategy with EC2 instances and user data. The application consists of Nginx, Tomcat, RabbitMQ, Memcache, and MySQL.

## Prerequisites

Before you can deploy the application using this repository, you'll need to have the following:

- An AWS account
- Basic knowledge of AWS services and Lift and Shift strategy
- An artifact of the application ready to be deployed
- Git installed on your local machine
- AWS CLI installed on your local machine
- Amazon S3 bucket for storing the application artifact
- Key pair for SSH access to EC2 instances

## Getting Started

To get started with deploying the multi-tier application on AWS using the Lift and Shift strategy, follow these steps:

1. Clone this repository to your local machine using the following command:

2. Navigate to the repository directory:

3. Create a security group for the backend server:

```
aws ec2 create-security-group --group-name Backend --description "Security Group for Backend Server"
```

4. Create a security group for the Elastic Load Balancer:

```
aws ec2 create-security-group --group-name ELB --description "Security Group for Elastic Load Balancer"
```

5. Create a security group for the application server:

```
aws ec2 create-security-group --group-name App --description "Security Group for Application Server"
```

6. Launch EC2 instances with user data from the userdata directory:

```
aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --instance-type t2.micro --key-name <your-key-name> --security-group-ids <backend-security-group-id> --subnet-id <your-subnet-id> --user-data file://userdata/backend.sh
aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --instance-type t2.micro --key-name <your-key-name> --security-group-ids <app-security-group-id> --subnet-id <your-subnet-id> --user-data file://userdata/nginx.sh
```

7. Create a Route 53 private hosted zone to add backend servers (db01, mc01, rmq01):

```
aws route53 create-hosted-zone --name <your-domain-name> --caller-reference <your-caller-reference> --hosted-zone-config Comment="Private Hosted Zone for Backend Servers"
```

8. Build the artifact locally and copy it to the S3 bucket:

```
aws s3 cp <your-artifact> s3://<your-bucket-name>/<your-artifact-name>
```

9. Create a role for S3 access EC2:

```
aws iam create-role --role-name <your-role-name> --assume-role-policy-document file://userdata/s3-role.json
```

10. Modify the IAM role for the application server and copy the artifact to the application server:

```
aws ec2 modify-instance-attribute --instance-id <your-instance-id> --iam-instance-profile Name=<your-role-name>
scp -i <your-key-name>.pem <your-artifact> ec2-user@<your-instance-ip>:/home/ec2-user/
```

11. Set up a load balancer:

```
aws elb create-load-balancer --load-balancer-name <your-load-balancer-name> --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=8080" --security-groups <elb-security-group-id> --subnets <your-subnet-id>
```

12. Set up an auto scaling group for the application server:

```
aws autoscaling create-auto-scaling-group --auto-scaling-group-name <your-auto-scaling-group-name> --launch-configuration-name <your-launch-configuration-name> --min-size 1 --max-size 3 --desired-capacity 2 --availability-zones <your-availability-zones> --load-balancer-names <your-load-balancer-name>
```

## Conclusion

By following the steps outlined in this README file, you can deploy your multi-tier application on AWS using the Lift and Shift strategy with EC2 instances and user data. If you have any questions or issues, please feel free to reach out to the me
