output "metric_filter_id" {
  value       = aws_cloudwatch_log_metric_filter.metric_filter.id
  description = "The ID of the metric filter"
}

output "metric_filter_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.metric_alarm.arn
  description = "The arn of the metric filter alarm"
}

output "metric_alarm_tags" {
  value       = aws_cloudwatch_metric_alarm.metric_alarm.tags_all
  description = "A mapping of tags to assign to the resource."
}
