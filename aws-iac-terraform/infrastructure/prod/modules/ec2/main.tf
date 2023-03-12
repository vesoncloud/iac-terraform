//************************************************************************************
// aws production EC2
//************************************************************************************

// back configuration for vpc.tfstate
data "terraform_remote_state" "vpc_configuration" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = var.remote_state_key
    region = var.aws_region
  }
}

module "vpc_configuration" {
  source = "../vpc"

}

// declare local variables
locals {
  vpc_id                        = module.vpc_configuration.vpc_id//""//data.terraform_remote_state.vpc_configuration.outputs.vpc_id
  public_subnet_id              = module.vpc_configuration.public_subnet_1_id//""//data.terraform_remote_state.vpc_configuration.outputs.public_subnet_1_id
  private_subnet_id             = module.vpc_configuration.private_subnet_1_id//""//data.terraform_remote_state.vpc_configuration.outputs.private_subnet_1_id
  amazon_ami_linux_t2_micro     = var.amazon_ami_linux_t2_micro
  win_server_2012_r2            = var.win_server_2012_r2
  public_security_group_name    = var.public_security_group_name
  tcp_protocol_name             = var.tcp_protocol_name
  ec2_instance_type             = var.ec2_instance_type
  ec2_key_Pair_name             = var.ec2_key_Pair_name
  ec2_instance_volume           = var.ec2_instance_volume
  volume_size_30                = var.volume_size_30
}

// create the security group
resource "aws_security_group" "ec2_public_security_group" {
  description = "Internet reaching access for EC2 Instance"
  name = local.public_security_group_name
  vpc_id = local.vpc_id

  ingress {
    from_port   = 80
    protocol    = local.tcp_protocol_name
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol  = local.tcp_protocol_name
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3389
    protocol  = "TCP"
    to_port   = 3389
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// EC2 role
resource "aws_iam_role" "ec2_iam_role" {
  name               = "my-ec2-iam-role"
  assume_role_policy = <<EOF
{
"Version" : "2012-10-17",
"Statement" :
   [
    {
      "Effect" : "Allow",
       "Principal" : {
        "Service" : ["ec2.amazonaws.com", "application-autoscaling.amazonaws.com"]
       },
       "Action" : "sts:AssumeRole"
    }
  ]
}
EOF
}

// EC2 policy
resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  name   = "my-iam-ec2-policy"
  role   = aws_iam_role.ec2_iam_role.id
  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
    "Effect": "Allow",
    "Action": [
        "ec2:*",
        "elasticloadbalancing:*",
        "cloudwatch:*",
        "logs:*"
       ],
       "Resource": "*"
     }
   ]
}
EOF
}

// ec2 instance profile role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2-Instance-Profile"
  role = aws_iam_role.ec2_iam_role.name

  tags = {
    Name = "my_ec2_instances"
  }
}

// EC2 launch configuration for linux t2 micro
resource "aws_launch_configuration" "ec2_linux_t2_micro_launch_configuration" {
  name                 = "aws_linux_t2_micro"
  image_id             = local.amazon_ami_linux_t2_micro
  instance_type        = local.ec2_instance_type
  key_name             = local.ec2_key_Pair_name
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups      = [aws_security_group.ec2_public_security_group.id]
  associate_public_ip_address = true
  enable_monitoring           = false

  root_block_device {
    volume_size           = 8
    volume_type           = local.ec2_instance_volume
    delete_on_termination = true
  }

  ebs_block_device {
    device_name     = "ebs-t2-micro"
    encrypted       = true
    volume_size     = 8
    volume_type     = local.ec2_instance_volume
  }
}

// EC2 launch configuration for windows server
resource "aws_launch_configuration" "ec2_win_server_configuration" {
  name          = "aws_windows_server"
  image_id      = "ami-0c2b0d3fb02824d92" // windows server 2022
  instance_type = "t2.micro"
  key_name      = local.ec2_key_Pair_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups             = [aws_security_group.ec2_public_security_group.id]
  associate_public_ip_address = true
  enable_monitoring           = false

  root_block_device {
    volume_size           = local.volume_size_30
    volume_type           = local.ec2_instance_volume
    delete_on_termination = true
  }

  ebs_block_device {
    device_name     = "ebs-t2-win-server"
    encrypted       = true
    volume_size     = local.volume_size_30
    volume_type     = local.ec2_instance_volume
  }
}

// provision the EC2 Instance with auto-scaling group
resource "aws_autoscaling_group" "ec2_auto_scaling_group" {
  name = "EC2-ASG"
  max_size = 1
  min_size = 1
  desired_capacity = 1
  launch_configuration      = aws_launch_configuration.ec2_linux_t2_micro_launch_configuration.name
  health_check_grace_period = 150
  force_delete              = true
  termination_policies      = ["OldestInstance"]

  vpc_zone_identifier       = [local.public_subnet_id]
}

//




































