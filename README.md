# AWS metric filter alarm Terraform module

Terraform module that creates AWS CloudWatch metric filter and alarm

## Usage

```hcl
module "my_metric_filter_alarm" {
  source = "dwp/metric-filter-alarm/aws"

  log_group_name   = "MyLogGroup"
  metric_namespace = "MyMetricNamespace"
  pattern          = "ERROR"
  alarm_name       = "MyAlarm"
}
```

## Examples

The following example creates a CloudWatch Log Group, Alarm and SNS Topic. The Alarm monitors the Log Group for "ERROR" and if there are more than five occurrences within one hour the Alarm will go into an "ALARM" state and a notification will be sent to the SNS Topic

```hcl
resource "aws_cloudwatch_log_group" "MyLogGroup" {
  name = "MyLogGroup"
}

resource "aws_sns_topic" "MyTopic" {
  name         = "MyTopic"
  display_name = "My Topic"
}

module "my_metric_filter_alarm" {
  source = "dwp/metric-filter-alarm/aws"

  log_group_name    = aws_cloudwatch_log_group.MyLogGroup.name
  metric_namespace  = "MyMetricNamespace"
  pattern           = "ERROR"
  alarm_name        = "MyAlarm"
  alarm_action_arns = [aws_sns_topic.MyTopic.arn]
  period            = "3600"
  threshold         = "5"
  statistic         = "Sum"
}
```