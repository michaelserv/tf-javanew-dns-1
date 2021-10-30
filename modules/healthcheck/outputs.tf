output "https_healthcheck_id" {
  description = "The ARN of the HTTPS health check"
  value       = element(concat(aws_route53_health_check.http.*.id, [""]), 0)
}

output "http_healthcheck_id" {
  description = "The ARN of the HTTP health check"
  value       = element(concat(aws_route53_health_check.https.*.id, [""]), 0)
}

output "https_cloudwatch_metric_alarm_arn" {
  description = "The ARN of the HTTPS CloudWatch metric"
  value       = element(concat(aws_cloudwatch_metric_alarm.http.*.arn, [""]), 0)
}

output "http_cloudwatch_metric_alarm_arn" {
  description = "The ARN of the HTTP CloudWatch metric"
  value       = element(concat(aws_cloudwatch_metric_alarm.https.*.arn, [""]), 0)
}
