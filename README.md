# Redundant WordPress Deployment on AWS Using Terraform

## 1. Architecture Overview

![Architecture Overview](https://github.com/bo-iliev/lab08-task/assets/71664336/f4ff509c-5142-451e-8615-7aca47a52d04)



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


## 3.2 Disaster Recovery

**RDS Recovery**:
1. **Identify the Issue**: Determine the nature and extent of the data corruption or loss.
2. **Access RDS Console**: Go to the Amazon RDS console and navigate to the 'Snapshots' section.
3. **Choose a Backup**: Select an appropriate automated backup or manual snapshot based on the time before corruption or loss occurred.
4. **Restore the Database**: Click on the 'Restore' button for the chosen backup. Configure the DB instance settings as required.
5. **Validate Data**: Once the restoration process is complete, validate the integrity and completeness of the data.
6. **Update DNS or Connection Strings**: If the restored DB instance has a new endpoint, update the DNS records or connection strings in your application.

**EC2 Recovery**:
1. **Monitoring Health**: Auto Scaling monitors the health of EC2 instances and automatically replaces instances marked as unhealthy.
2. **Manual Interventions**:
   - **Update AMIs**: If an instance failure is due to outdated AMIs, update them with the latest configurations and patches.
   - **Adjust Scaling Policies**: In case of traffic spikes or changes in load patterns, modify the scaling policies to ensure optimal performance.
   - **Manual Replacement**: In rare cases, manually terminate and replace instances if Auto Scaling doesn't respond as expected.

**S3 Recovery**:
1. **Versioning Enabled Buckets**: For S3 buckets with versioning enabled, navigate to the bucket and locate the file needing recovery.
2. **Restore Previous Versions**: Select the desired version of the file from the list of versions and download or restore it.
3. **Recover Deleted Files**: If a file was deleted, it can still be recovered if versioning is enabled. Find the delete marker of the file and delete it to restore the file.
4. **Non-Versioned Buckets**: For buckets without versioning, recovery relies on S3 backup mechanisms like cross-region replication or manual backups.

## 3.3 Monitoring and Alerts

### CloudWatch Alarms Setup and Configuration

This Terraform setup configures CloudWatch alarms to monitor key metrics across the infrastructure, ensuring timely alerts and proactive management.

1. **AWS SNS Topic for Alarms**: A dedicated SNS topic, `cloudwatch-alarms-topic`, is created to aggregate alarm notifications.
   
2. **EC2 CPU Utilization Alarm**:
   - **Alarm Name**: `ec2-cpu-utilization`
   - **Metric**: Monitors CPU utilization of EC2 instances within the specified Auto Scaling group.
   - **Threshold**: Set to trigger at or above 75% CPU utilization, averaged over two consecutive periods of 60 seconds.

3. **ELB Unhealthy Hosts Alarm**:
   - **Alarm Name**: `elb-unhealthy-hosts`
   - **Metric**: Tracks the count of unhealthy hosts in the specified ELB.
   - **Threshold**: Triggers if there is at least one unhealthy host, averaged over two consecutive periods of 300 seconds.

4. **RDS CPU Utilization Alarm**:
   - **Alarm Name**: `rds-cpu-utilization`
   - **Metric**: Monitors the CPU utilization of the specified RDS instance.
   - **Threshold**: Set to activate at or above 85% CPU utilization, averaged over two periods of 60 seconds.

5. **ElastiCache Redis CPU Utilization Alarm**:
   - **Alarm Name**: `elasticache-redis-cpu-utilization`
   - **Metric**: Observes CPU utilization of the ElastiCache Redis cluster.
   - **Threshold**: Set to alarm at or above 85% CPU utilization, averaged across two periods of 60 seconds.


## 4. Further Improvements and Discussion Points

- **CI/CD Pipeline for Infra**: Implement a CI/CD pipeline to automate the deployment of infrastructure changes.
- **CI/CD Pipeline for WP**: Implement a CI/CD pipeline to automate the deployment of WordPress changes. This would depend on the way the WordPress site is managed. For example, if it's managed via Git, you could use a CI/CD tool like Jenkins to automatically deploy changes to the site.
- **Install S3 Plugin**: Install the S3 and CloudFront plugin to automatically upload static files to S3.
- **Shared Storage for wp-content?**: Consider using a shared storage solution like Amazon EFS for wp-content to ensure that all EC2 instances have access to the same files like plugins and themes.
- **Add more config options**: Add more configuration options to the Terraform modules, such as the ability to specify the number of EC2 instances, the instance type, the RDS instance type, etc.
- **Implement SSL**: Implement SSL for the WordPress site using AWS Certificate Manager and the ELB.
---
