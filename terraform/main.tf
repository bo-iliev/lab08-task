module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = "10.0.0.0/16"
  public_subnets = {
    "subnet1" = {
      cidr_block = "10.0.3.0/24"
      az         = "eu-central-1a"
    },
    "subnet2" = {
      cidr_block = "10.0.4.0/24"
      az         = "eu-central-1b"
    }
  }
  private_subnets = {
    "subnet1" = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-central-1a"
    },
    "subnet2" = {
      cidr_block = "10.0.2.0/24"
      az         = "eu-central-1b"
    }
  }
}

module "ec2" {
  source = "./modules/ec2"

  ami_id               = var.ami_id
  instance_type        = "t2.micro"
  public_subnet_id = module.vpc.public_subnet_ids[0]
  subnet_ids           = module.vpc.private_subnet_ids
  bastion_sg_id         = module.vpc.bastion_security_group_id
  security_group_id    = module.vpc.ec2_security_group_id
  instance_name        = "WordPressInstance"
  ssh_public_key       = var.ssh_public_key
  asg_max_size         = 3
  asg_min_size         = 1
  asg_desired_capacity = 2
  elb_name             = module.elb.elb_name
  db_name = var.db_name
  db_user = var.db_username
  db_password = var.db_password
  db_host              = module.rds.db_endpoint
  redis_host           = module.elasticache.elasticache_redis_endpoint
}

module "elb" {
  source = "./modules/elb"

  public_subnet_ids     = module.vpc.public_subnet_ids
  elb_security_group_id = module.vpc.elb_security_group_id
}

module "rds" {
  source = "./modules/rds"

  db_allocated_storage       = 20
  db_storage_type            = "gp2"
  db_engine                  = "mysql"
  db_engine_version          = "8.0.33"
  db_instance_class          = "db.t2.micro"
  db_name                    =  var.db_name
  db_username                = var.db_username
  db_password                = var.db_password
  db_parameter_group_name    = "default.mysql8.0"
  db_subnet_ids              = module.vpc.private_subnet_ids
  rds_security_group_id      = module.vpc.rds_security_group_id
  db_backup_retention_period = 7
  db_backup_window           = "03:00-04:00"
  db_maintenance_window      = "Sun:04:00-Sun:05:00"
}

module "s3_cloudfront" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "elasticache" {
  source = "./modules/elasticache"

  subnet_ids       = module.vpc.private_subnet_ids
  cluster_id       = "wp-redis-cluster"
  node_type        = "cache.t2.micro"
  num_cache_nodes  = 1
  security_group_id = module.vpc.elasticache_security_group_id
}

module "route53_elb_record" {
  source = "./modules/route53"

  hosted_zone_id = var.hosted_zone_id
  record_name    = var.record_name
  elb_dns_name   = module.elb.elb_dns_name     
  elb_zone_id    = module.elb.elb_zone_id      
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  ec2_autoscaling_group_name  = module.ec2.autoscaling_group_name
  elb_name                    = module.elb.elb_name
  rds_instance_identifier     = module.rds.db_instance_id
  elasticache_cluster_id      = module.elasticache.redis_cluster_id
}

