provider "aws" {
  region = "eu-west-1"

  default_tags {

    tags = {
      Application      = "DataWorks"                              # As per our definition on ServiceNow
      Function         = "Data and Analytics"                     # As per our definition on ServiceNow
      Environment      = local.hcs_environment[local.environment] # Set up locals as per Tagging doc requirements https://engineering.dwp.gov.uk/policies/hcs-cloud-hosting-policies/resource-identification-tagging/
      Business-Project = "PRJ0022507"                             # This seems to replace costcode as per the doc https://engineering.dwp.gov.uk/policies/hcs-cloud-hosting-policies/resource-identification-tagging/
      DWX-Aplication   = "terratest"
    }
  }

  assume_role {
    role_arn = "arn:aws:iam::${var.test_account}:role/${var.assume_role}"

  }

}

variable "assume_role" {
  type        = string
  default     = "ci"
  description = "Role to assume"
}

variable "test_account" {
  type        = string
  description = "Test AWS Account number"

}


resource "aws_cloudwatch_log_group" "terratest_log_group" {
  name = "TerratestLogGroup"
}

resource "aws_sns_topic" "terratest_topic" {
  name         = "TerratestTopic"
  display_name = "Terratest Topic"
}

module "terratest_metric_filter_alarm" {
  source = "../"

  log_group_name    = aws_cloudwatch_log_group.terratest_log_group.name
  metric_namespace  = "TerratestNamespace"
  pattern           = "ERROR"
  alarm_name        = "TerratestAlarm"
  alarm_action_arns = [aws_sns_topic.terratest_topic.arn]
  period            = "3600"
  threshold         = "5"
  statistic         = "Sum"
}
