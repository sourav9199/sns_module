provider "aws" {
  region = var.aws_region

}

module "policy" {
  source           = "app.terraform.io/abcd92/policy/sns"
  version          = "1.1.0"
  account_id       = var.id
  sns_name         = var.name
  sns_display_name = var.dis_name
  user_policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Second",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "sns:Publish",
      "Resource": "arn:aws:sns:${var.aws_region}:${var.id}:${var.name}",
      "Condition": {
        "ArnEquals": {
        "aws:SourceArn": "arn:aws:sns:${var.aws_region}:${var.id}:${var.name}"
        }
      }
    }
  ]
}
POLICY
}
