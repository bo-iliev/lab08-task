resource "aws_key_pair" "wp_ssh_key" {
  key_name_prefix = "wp-demo-ssh"
  public_key      = var.ssh_public_key
}

data "template_file" "init" {
  template = file("${path.module}/user_data.tpl")

  vars = {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    db_host     = var.db_host
    redis_host  = var.redis_host
  }
}

resource "aws_launch_configuration" "lc" {
  name_prefix     = "wp-lc-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.wp_ssh_key.key_name
  security_groups = [var.security_group_id]
  user_data = data.template_file.init.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.lc.id
  vpc_zone_identifier  = var.subnet_ids
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_capacity

  load_balancers = [var.elb_name]

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
  depends_on = [aws_key_pair.wp_ssh_key]
}


resource "aws_instance" "bastion_host" {
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.wp_ssh_key.key_name
  subnet_id = var.public_subnet_id
  security_groups = [var.bastion_sg_id]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "BastionHost"
  }
}
