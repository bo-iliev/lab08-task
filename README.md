# Redundant WordPress Deployment on AWS Using Terraform

## 1. Architecture Overview

![Architecture Overview](https://github.com/bo-iliev/lab08-task/assets/71664336/8855ba1f-9d62-4dad-8803-58ba18ed79fc)


### 1.1 System Components

- **EC2 with Auto Scaling Group**: Hosts WordPress instances with scaling managed based on metrics like CPU utilization, ensuring responsive performance under varying loads.
- **Elastic Load Balancer (ELB)**: Distributes traffic across EC2 instances, providing high availability and fault tolerance, and reroutes traffic from unhealthy instances.
- **Amazon RDS**: Hosts the MySQL database with daily backups, 7-day transaction log retention, and automated patching and scaling.
- **ElastiCache**: Caches frequently accessed WordPress data, reducing database load and improving site speed.
- **Amazon S3**: Stores WordPress static content (images, JS, CSS) with an integrated Amazon S3 plugin for faster load times.
- **Amazon CloudWatch**: Monitors AWS services' health and performance, tracking metrics and logs, setting alarms, and reacting to changes.
- **Amazon VPC**: Configured with distinct public and private subnets. The network, named "wordpress-vpc," enhances security and functionality.
  
  - **Public Subnets**: Each tagged as "wp-public-subnet-{key}", enables public internet access and hosts services like the ELB.
  
  - **Private Subnets**: Each tagged as "wp-private-subnet-{key}", used for internal services like RDS and ElastiCache, without direct public internet access.

- **Internet Gateway & NAT Gateway**: "wordpress-igw" provides internet access. "wordpress-nat" in a public subnet enables private subnet internet access for updates while keeping them private.

- **Route Tables**: Separate public and private route tables for appropriate traffic routing. Public routes to the internet gateway, and private routes via the NAT gateway.

- **Security Groups**: 
  - **Bastion Host Security Group ("bastion-sg")**: For secure SSH access.
  - **EC2 Security Group ("ec2-sg")**: Manages traffic to EC2 instances.
  - **ELB Security Group ("elb-sg")**: Controls traffic to the ELB.
  - **RDS Security Group ("rds-sg")**: Regulates MySQL traffic to RDS.
  - **ElastiCache Security Group ("elasticache-sg")**: Manages Redis traffic to ElastiCache.

- **Route 53**: Manages DNS, directing traffic to the ELB.

## 2. Deployment Procedure

This section outlines the steps to deploy the WordPress infrastructure on AWS using Terraform. A visual representation of the infrastructure components created by Terraform is provided to enhance understanding.

### 2.1 Prerequisites

- AWS account with administrative access.
- Terraform installed on your local machine.
- Basic knowledge of AWS services and Terraform syntax.

### 2.2 Steps

1. **VPC Setup**: 
    - Deploy "wordpress-vpc" with a specified CIDR block.
    - Create public and private subnets in defined availability zones with appropriate CIDR blocks.
    - Set up "wordpress-igw" and "wordpress-nat" for internet access and routing.

2. **Route Tables and Associations**:
    - Configure a public route table to route traffic to the internet gateway.
    - Set up a private route table to route internal traffic via the NAT Gateway.
    - Associate each subnet with the respective route table.

3. **Security Groups Configuration**:
    - Define and apply security groups for Bastion Host, EC2 instances, ELB, RDS, and ElastiCache.

4. **ELB Configuration**: 
    - Create an ELB in the public subnet with health checks for EC2 instances.

5. **RDS Setup**: 
    - Deploy an RDS instance within a private subnet with appropriate configurations.

6. **ElastiCache Implementation**: 
    - Define and create an ElastiCache cluster accessible only from EC2 instances.

7. **S3 Bucket Creation**: 
    - Create an S3 bucket for static files with appropriate access permissions.

8. **Route 53 Configuration**: 
    - Set up DNS records pointing to the ELB.

9. **CloudWatch Monitoring**: 
    - Create metrics and alarms for monitoring and notifications.

There should be a total of 36 items that Terraform will add:

![image](https://github.com/bo-iliev/lab08-task/assets/71664336/55068b4b-aa68-4688-a67e-4746360bc60b)

After that the infrastructure should be ready to use:

# ![image](https://github.com/bo-iliev/lab08-task/assets/71664336/9fadf950-6e4d-4036-90fa-008a0e644d0c)

# ![image](https://github.com/bo-iliev/lab08-task/assets/71664336/1d4e02dc-d5cc-487f-a576-2dc23fb0e8ba)


## 3. Recovery Procedures

### 3.1 Backup Strategy

- **RDS Backups**: Utilize RDS's automated backup feature. Ensure backups are taken daily and retained for a specified duration. Document how to perform a point-in-time recovery using these backups.

- **S3 Data Preservation**: Implement versioning and lifecycle policies on the S3 bucket to ensure data durability and recoverability.

### 3.2 Disaster Recovery

- **RDS Recovery**: Provide detailed steps on restoring the RDS instance from automated backups or snapshots in case of data corruption or loss.

- **EC2 Recovery**: Auto Scaling automatically replaces unhealthy instances. Detail any manual intervention steps if required, such as updating AMIs or scaling policies.

- **S3 Recovery**: Outline the process for recovering data from S3 backups, including how to restore previous versions of files or recover deleted files.

### 3.3 Monitoring and Alerts

- **CloudWatch Alarms**: Detail the process of responding to CloudWatch alarms, including common issues and troubleshooting steps for EC2, RDS and ELB.

- **Performance Metrics**: List key performance metrics that should be monitored for each AWS component to ensure optimal operation.

## 4. Further Improvements and Discussion Points

- **CI/CD Pipeline**: Implement a CI/CD pipeline to automate the deployment of infrastructure changes.
- **CI/CD Pipeline**: Implement a CI/CD pipeline to automate the deployment of WordPress changes. This would depend on the way the WordPress site is managed. For example, if it's managed via Git, you could use a CI/CD tool like Jenkins to automatically deploy changes to the site.
- **Install S3 Plugin**: Install the S3 and CloudFront plugin to automatically upload static files to S3.
- **Shared Storage for wp-content?**: Consider using a shared storage solution like Amazon EFS for wp-content to ensure that all EC2 instances have access to the same files like plugins and themes.
- **Add more config options**: Add more configuration options to the Terraform modules, such as the ability to specify the number of EC2 instances, the instance type, the RDS instance type, etc.
- **Implement SSL**: Implement SSL for the WordPress site using AWS Certificate Manager and the ELB.
---
