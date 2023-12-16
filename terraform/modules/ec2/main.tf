resource "aws_key_pair" "wp_ssh_key" {
  key_name_prefix = "wp-demo-ssh"
  public_key      = var.ssh_public_key
}

resource "aws_launch_configuration" "lc" {
  name_prefix     = "wp-lc-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.wp_ssh_key.key_name
  security_groups = [var.security_group_id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.lc.id
  vpc_zone_identifier = var.subnet_ids
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.asg_desired_capacity

  load_balancers    = [var.elb_name]  

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
  depends_on = [ aws_key_pair.wp_ssh_key ]
}

