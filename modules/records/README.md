# Route53 Records

This module creates DNS records in Route53 zone.

## Usage

```hcl
module "records_for_zone1" {
  source = "../modules/records"

  zone_name = local.zone_name

  records = [
    {
      name            = ""
      type            = "A"
      set_identifier  = "failover-primary"
      health_check_id = module.route53_health_check.http_healthcheck_id
      ttl            = 5
      records = [
        "3.208.22.61",
      ]
      failover_routing_policy = {
        type = "PRIMARY"
      }
    },
    {
      name           = ""
      type           = "A"
      set_identifier = "failover-secondary"
      ttl            = 5
      records = [
        "54.234.136.202",
      ]
      failover_routing_policy = {
        type = "SECONDARY"
      }
    }
  ]

  depends_on = [module.zone1, module.route53_health_check]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.49 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.49 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create DNS records | `bool` | `true` | no |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Whether Route53 zone is private or public | `bool` | `false` | no |
| <a name="input_records"></a> [records](#input\_records) | List of maps of DNS records | `any` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | ID of DNS zone | `string` | `null` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Name of DNS zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_record_fqdn"></a> [route53\_record\_fqdn](#output\_route53\_record\_fqdn) | FQDN built using the zone domain and name |
| <a name="output_route53_record_name"></a> [route53\_record\_name](#output\_route53\_record\_name) | The name of the record |
