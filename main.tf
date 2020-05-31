terraform {
  required_version = ">= 0.12, < 0.13"
}

locals {
  app_name = "${var.app_name_prefix}-${var.environment}"
}

resource "heroku_app" "app" {
  name   = local.app_name
  region = var.region

  dynamic "organization" {
    for_each = var.heroku_team_name == "" ? [] : [var.heroku_team_name]
    content {
      name = organization.value
    }
  }

  config_vars = var.config_vars

  sensitive_config_vars = var.sensitive_config_vars

  buildpacks = [
    "heroku/nodejs",
    "heroku/ruby"
  ]

  acm = var.enable_acm
}

resource "heroku_app_feature" "dyno-metadata" {
  app  = heroku_app.app.name
  name = "runtime-dyno-metadata"
}

resource "heroku_addon" "pg" {
  app  = heroku_app.app.name
  plan = "heroku-postgresql:${var.db_plan}"
}

resource "heroku_domain" "domain" {
  count    = length(var.custom_domain) > 0 ? 1 : 0
  app      = heroku_app.app.name
  hostname = var.custom_domain
}

module "queue" {
  source = "./modules/heroku-redis"

  name = "queue"
  app  = heroku_app.app.name
  plan = var.queue_redis_plan
}

module "cache" {
  source = "./modules/heroku-redis"

  name = "cache"
  app  = heroku_app.app.name
  plan = var.cache_redis_plan
}

resource "heroku_addon" "deploy_hook" {
  for_each = toset(var.deploy_hook_urls)

  app  = heroku_app.app.name
  plan = "deployhooks:http"

  config = {
    url = each.value
  }
}

data "heroku_addon" "papertrail_addon" {
  count = length(var.papertrail_addon_name) > 0 ? 1 : 0
  name  = var.papertrail_addon_name
}

resource "heroku_addon_attachment" "papertrail-attachment" {
  count    = length(var.papertrail_addon_name) > 0 ? 1 : 0
  app_id   = heroku_app.app.name
  addon_id = data.heroku_addon.papertrail_addon[0].id
}
