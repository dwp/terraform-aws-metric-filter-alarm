resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  log_group_name = "${var.log_group_name}"
  "metric_transformation" {
    name = "${var.metric_filter_name != "" ? var.metric_filter_name : var.alarm_name}"
    namespace = "${var.metric_namespace}"
    value = "1"
  }
  name = "${var.metric_filter_name != "" ? var.metric_filter_name : var.alarm_name}"
  pattern = "${var.pattern}"
}

resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  alarm_name = "${var.alarm_name}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods = "${var.evaluation_periods}"
  metric_name = "${aws_cloudwatch_log_metric_filter.metric_filter.name}"
  namespace = "${var.metric_namespace}"
  period = "${var.period}"
  threshold = "${var.threshold}"
  statistic = "${var.statistic}"
  alarm_actions = "${var.alarm_action_arns != "" ? var.alarm_action_arns : ""}"
}