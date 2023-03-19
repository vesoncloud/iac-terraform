//************************************************************************************
// aws IAM ROLES/POLICIES MODULE
//************************************************************************************

locals {
  aws_daily_ec2_config       = var.aws_daily_ec2_config
  gathering_ec2_config       = var.gathering_ec2_config

  s3_ec2_config_bucket_arn   = var.s3_ec2_config_bucket_arn
  s3_ec2_config_EC2_folder   = var.s3_ec2_config_EC2_folder
}
//************************************************************************************
// aws assume role or trust policies
//************************************************************************************
data "aws_iam_policy_document" "assume_role" {
   version   = "2012-10-17"
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [
        "lambda.amazonaws.com",
        "states.amazonaws.com",
        "events.amazonaws.com"
      ]
      type        = "Service"
    }
  }
}

//************************************************************************************
// gathering-ec2-config policy document
//************************************************************************************
data "aws_iam_policy_document" "gathering_ec2_config_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "CloudWatchLoggingLogGroup"
    effect = "Allow"
    actions = ["logs:CreateLogGroup"]
    resources = ["arn:aws:lambda:us-east-1:279398764131:/log-group:/aws/lambda/gathering-ec2-config:log-stream:*"]
  }
  statement {
    sid = "CloudWatchLoggingLogStream"
    effect = "Allow"
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:lambda:us-east-1:279398764131:/log-group:/aws/lambda/gathering-ec2-config"]
  }
  statement {
    sid = "AccessToEc2Configuration"
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["arn:aws:lambda:us-east-1:279398764131:function:access-s3-bucket"]
  }
  statement {
    sid = "WriteResultsToS3"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging"
    ]
    resources = [local.s3_ec2_config_EC2_folder]
  }
  statement {
    sid = "ListBucket"
    effect = "Allow"
    actions = ["s3:ListBucket"]
    resources = ["*"]
  }
  statement {
  sid = "ReadConfigResults"
  effect = "Allow"
  actions = ["s3:GetObject"]
  resources = [local.s3_ec2_config_EC2_folder]
  }
}

// aws policy for lambda access to ec2 and s3 bucket
resource "aws_iam_policy" "gathering_ec2_config_policy" {
  description = "AWS policy for lambda access to ec2 and s3 bucket"
  name        = local.gathering_ec2_config
  policy      = data.aws_iam_policy_document.gathering_ec2_config_policy_document.json
}

// aws role for lambda access to ec2 and s3 bucket
resource "aws_iam_role" "gathering_ec2_config_role" {
  description = "AWS role for lambda access to ec2 and s3 bucket"
  name               = local.gathering_ec2_config
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

// AWS attach aws-ec2-config to the role
resource "aws_iam_role_policy_attachment" "aws_ec2_config_policy_attachment" {
  policy_arn = aws_iam_policy.gathering_ec2_config_policy.arn
  role       = aws_iam_role.gathering_ec2_config_role.name
}

//************************************************************************************
// aws-daily-ec2-config policy document
//************************************************************************************
data "aws_iam_policy_document" "aws_daily_ec2_config_policy_document" {
  version = "2012-10-17"

  statement {
    sid = "CloudWatchLoggingLogGroup"
    effect = "Allow"
    actions = ["logs:CreateLogGroup"]
    resources = ["arn:aws:lambda:us-east-1:279398764131:/log-group:/aws/lambda/aws-daily-ec2-config:log-stream:*"]
  }
  statement {
    sid = "CloudWatchLoggingLogStream"
    effect = "Allow"
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:lambda:us-east-1:279398764131:/log-group:/aws/lambda/aws-daily-ec2-config"]
  }
  statement {
    sid = "InvokeStepFunctions"
    effect = "Allow"
    actions = [
      "states:StartExecution",
      "states:StopExecution"
    ]
    resources = ["*"]
  }
  statement {
    sid = "StepFunctionsLogging"
    effect = "Allow"
    actions = [
            "logs:CreateLogDelivery",
            "logs:GetLogDelivery",
            "logs:UpdateLogDelivery",
            "logs:DeleteLogDelivery",
            "logs:ListLogDeliveries",
            "logs:PutLogEvents",
            "logs:PutResourcePolicy",
            "logs:DescribeResourcePolicies",
            "logs:DescribeLogGroups"
        ]
    resources = ["*"]
  }
}

// aws policy for lambda access to step functions
resource "aws_iam_policy" "aws_daily_ec2_config_policy" {
  description = "AWS policy for lambda access to ec2 and s3 bucket"
  name        = local.aws_daily_ec2_config
  policy      = data.aws_iam_policy_document.aws_daily_ec2_config_policy_document.json
}

// aws role for lambda access to step functions
resource "aws_iam_role" "aws_daily_ec2_config_role" {
  description = "AWS role for lambda access to ec2 and s3 bucket"
  name               = local.aws_daily_ec2_config
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

// AWS attach policy to the role
resource "aws_iam_role_policy_attachment" "aws_daily_ec2_config_policy_attachment" {
  policy_arn = aws_iam_policy.aws_daily_ec2_config_policy.arn
  role       = aws_iam_role.aws_daily_ec2_config_role.name
}









