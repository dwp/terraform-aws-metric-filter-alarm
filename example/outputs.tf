output "terratest_log_group_id" {
  value       = aws_cloudwatch_log_group.terratest_log_group.id
  description = "The ID of the log group"
}

output "topic_arn" {
  value       = aws_sns_topic.terratest_topic.arn
  description = "The arn of the topic"
}

output "metric_filter_id" {
  value       = module.terratest_metric_filter_alarm.metric_filter_id
  description = "The ID of the metric filter"
}

output "metric_filter_alarm_arn" {
  value       = module.terratest_metric_filter_alarm.metric_filter_alarm_arn
  description = "The arn of the metric filter alarm"
}

output "metric_alarm_tags" {
  value       = module.terratest_metric_filter_alarm.metric_alarm_tags
  description = "A mapping of tags to assign to the resource."
}
