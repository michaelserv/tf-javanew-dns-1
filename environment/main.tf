###############################################################################
# Providers
###############################################################################
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

###############################################################################
# Terraform main config block
###############################################################################
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      version = ">= 3.63.0"
    }
  }
}

locals {
  zone_name = sort(keys(module.zone1.route53_zone_zone_id))[0]
  tags = {
    Environment = var.environment
  }
}

###############################################################################
# Modules - SNS
###############################################################################
module "sns_topic" {
  source  = "../modules/sns"

  name  = "route53-health-check"
  email = ["sample@gmail.com"]
}

###############################################################################
# Modules - Route53 Healthcheck and CloudWatch Alarm
###############################################################################
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

###############################################################################
# Modules - Zones
###############################################################################
module "zone1" {
  source = "../modules/zones"

  zones = {
    "public-zone-example1.com" = {
      comment = "public-zone-example1.com - 1st public hosted zone"
    }
  }

  tags = local.tags
}

################################################################################
# Modules - Records
################################################################################
module "records_for_zone1" {
  source = "../modules/records"

  # zone_id = "ZZS0XOO8XXXXX" ### USE THIS IF PUBLIC ZONE IS ALREADY CREATED
  zone_name = local.zone_name

  records = [
    # {
    #   name = ""
    #   type = "A"
    #   ttl  = 3600
    #   records = [
    #     "3.25.123.178",
    #   ]
    # },
    # {
    #   name = "s3-bucket"
    #   type = "A"
    #   alias = {
    #     name    = module.s3_bucket.s3_bucket_website_domain
    #     zone_id = module.s3_bucket.s3_bucket_hosted_zone_id
    #   }
    # },
    # {
    #   name           = "geo"
    #   type           = "CNAME"
    #   ttl            = 5
    #   records        = ["europe.test.example.com."]
    #   set_identifier = "europe"
    #   geolocation_routing_policy = {
    #     continent = "EU"
    #   }
    # },
    # {
    #   name = "cloudfront"
    #   type = "A"
    #   alias = {
    #     name    = module.cloudfront.cloudfront_distribution_domain_name
    #     zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
    #   }
    # },
    # {
    #   name           = "test"
    #   type           = "CNAME"
    #   ttl            = 5
    #   records        = ["test.example.com."]
    #   set_identifier = "test-primary"
    #   weighted_routing_policy = {
    #     weight = 90
    #   }
    # },
    # {
    #   name           = "test"
    #   type           = "CNAME"
    #   ttl            = 5
    #   records        = ["test2.example.com."]
    #   set_identifier = "test-secondary"
    #   weighted_routing_policy = {
    #     weight = 10
    #   }
    # },
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
