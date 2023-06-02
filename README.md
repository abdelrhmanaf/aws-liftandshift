# aws-liftandshift
Deploying and Provisioning multi tier APP on AWS 

# prerequisites 
 1. AWSCLI
 2. Maven
# Steps
 1. creating Security Groups  (Backend, Elastic Load Balancer, App) and key pair
 2. Launching Ec2 instances with Userdata from userdata directory
 3. create Route 53 private hosted zone to add Backend Servers (db01, mc01, rmq01)
 4. Build the artifact Locally and copy it to S3 bucket 
 5.  Create role for S3 access  Ec2 and modify IAM role for app server and cp the artifact to app server
 6. Setup loadbalncer
 7. Setup Auto Scaling group for app server
