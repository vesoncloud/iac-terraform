//********************************************************************
// AWS terraform variables
//********************************************************************

// this the aws region
variable "aws_region" {
  description = "This is the aws region to deploy the infrastructure"
  type        = string
  default     = "us-east-1"
}

//********************************************************************
// Remote State Bucket & Remote State Key
//********************************************************************
variable "remote_state_bucket" {
  description = "this is the bucket where the vpc state file is located"
  type = string
  default = "datalake-staging-daily-prod"
}

variable "remote_state_key" {
  description = "this is the bucket where the vpc.tfstate file is located"
  type = string
  default = "global/state/prod_terraform.tfstate"//"terraform-tfstates/layers/layer1/vpc.tfstate"
}

// Amazon Machine Image
variable "amazon_ami_linux_t2_micro" {
  description = "this is the amazon machine image for t2.micro"
  type        = string
  default     = "ami-0dfcb1ef8550277af"
}

variable "win_server_2012_r2" {
  description = "This microsoft windows server 2012 R2"
  type        = string
  default     = "ami-0de93df26018c01de"
}

// this is the name for ec2 public security group
variable "public_security_group_name" {
  description = "this is the name for public security group"
  type        = string
  default     = "ec2-public-sg"
}

// this is the protocol name
variable "tcp_protocol_name" {
  description = "this is the TCP protocol"
  type        = string
  default     = "TCP"
}

// this is the EC2 Instance Type
variable "ec2_instance_type" {
  description = "this is the EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

// this is the EC2 key-pair name
variable "ec2_key_Pair_name" {
  description = "this is the ec2 key-pair name"
  type        = string
  default     = "id_ed25519_linux"
}

// this is the ec2 volume
variable "ec2_instance_volume" {
  description = "this is the Instance volume"
  type        = string
  default     = "gp2"
}

variable "volume_size_30" {
  description = "This is the volume size for our EC2"
  type        = number
  default     = 30
}


