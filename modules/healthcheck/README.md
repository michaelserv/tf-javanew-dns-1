# Route53 Records

This module creates and configures health check and its related AWS CloudWatch alarms.

## Usage

```hcl
module "route53_health_check" {
  source = "../modules/healthcheck"
  providers = {
    aws = aws.us-east-1
  }

  environment          = var.environment
  dns_name             = "sample.com"
  alarm_actions        = [module.sns_topic.sns_topic_arn]
  health_check_path    = "/"
  health_check_regions = ["us-east-1", "us-west-1", "us-west-2"]

  depends_on = [module.sns_topic]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 3.63.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.63.0 |
| aws.us-east-1 | >= 3.63.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_actions | Actions to execute when this alarm transitions. | `list(string)` | n/a | yes |
| alarm\_name\_suffix | Suffix for cloudwatch alarm name to ensure uniqueness. | `string` | `""` | no |
| disable | Disable health checks | `bool` | `false` | no |
| dns\_name | Fully-qualified domain name (FQDN) to create. | `string` | n/a | yes |
| environment | Environment tag (e.g. prod). | `string` | n/a | yes |
| failure\_threshold | Failure Threshold (must be less than or equal to 10) | `string` | `"3"` | no |
| health\_check\_path | Resource Path to check | `string` | `""` | no |
| health\_check\_regions | AWS Regions for health check | `list(string)` | <pre>[<br>  "us-east-1",<br>  "us-west-1",<br>  "us-west-2"<br>]</pre> | no |
| request\_interval | Request Interval (must be 10 or 30) | `string` | `"30"` | no |

## Outputs

| Name | Description |
|------|-------------|
| https\_healthcheck\_id | The ARN of the HTTPS health check |
| http\_healthcheck\_id | The ARN of the HTTP health check |
| https\_cloudwatch\_metric\_alarm\_arn | The ARN of the HTTPS CloudWatch metric |
| http\_cloudwatch\_metric\_alarm\_arn | The ARN of the HTTP CloudWatch metric |
