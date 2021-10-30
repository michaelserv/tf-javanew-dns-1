###############################################################################
# Outputs - Zone 1
###############################################################################
output "route53_zone_zone_id" {
  description = "Zone ID of Route53 zone"
  value       = module.zone1.route53_zone_zone_id
}

output "route53_zone_name_servers" {
  description = "Name servers of Route53 zone"
  value       = module.zone1.route53_zone_name_servers
}

output "route53_zone_name" {
  description = "Name of Route53 zone"
  value       = module.zone1.route53_zone_name
}

###############################################################################
# Outputs - Records for Zone 1
###############################################################################
output "route53_record_name" {
  description = "The name of the record"
  value       = module.records_for_zone1.route53_record_name
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.records_for_zone1.route53_record_fqdn
}

###############################################################################
# Outputs - SNS for Zone 1
###############################################################################
output "sns_topic_arn" {
  description = "ARN of SNS topic"
  value       = module.sns_topic.sns_topic_arn
}

###############################################################################
# Outputs - Healthchecks and CloudWatch alarm for Zone 1
###############################################################################
output "https_healthcheck_id" {
  description = "The ARN of the HTTPS health check"
  value       = module.route53_health_check.https_healthcheck_id
}

output "http_healthcheck_id" {
  description = "The ARN of the HTTP health check"
  value       = module.route53_health_check.http_healthcheck_id
}

output "https_cloudwatch_metric_alarm_arn" {
  description = "The ARN of the HTTPS CloudWatch metric"
  value       = module.route53_health_check.https_cloudwatch_metric_alarm_arn
}

output "http_cloudwatch_metric_alarm_arn" {
  description = "The ARN of the HTTP CloudWatch metric"
  value       = module.route53_health_check.http_cloudwatch_metric_alarm_arn
}
