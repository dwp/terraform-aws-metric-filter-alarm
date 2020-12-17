variable "log_group_name" {
  type        = string
  description = "The name of the log group to associate the metric filter with"
}

variable "metric_namespace" {
  type        = string
  description = "The destination namespace of the CloudWatch metric"
}

variable "metric_value" {
  type        = string
  description = "The value of the CloudWatch metric"
  default     = "1"
}

variable "pattern" {
  type        = string
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events"
}

variable "alarm_name" {
  type        = string
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
}

variable "alarm_description" {
  type        = string
  description = "The description for the alarm"
  default     = ""
}

variable "metric_filter_name" {
  type        = string
  description = "A name for the metric filter"
  default     = ""
}

variable "alarm_action_arns" {
  type        = list(string)
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)"
  default     = []
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  type        = string
  description = "The number of periods over which data is compared to the specified threshold"
  default     = "1"
}

variable "period" {
  type        = string
  description = "The period in seconds over which the specified statistic is applied"
  default     = "60"
}

variable "threshold" {
  type        = string
  description = "The value against which the specified statistic is compared"
  default     = "0"
}

variable "statistic" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Sum"
}

variable "notification_type" {
  type        = string
  description = "The severity of this alarm. Either of the following is supported: Info, Warning, Error"
  default     = "Warning"
}

variable "severity" {
  type        = string
  description = "The severity of this alarm. Either of the following is supported: Low, Medium, High, Critical"
  default     = "Medium"
}
