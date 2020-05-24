terraform {
    required_version = ">= 0.12, < 0.13"
}

locals {
  app_name = "${var.app_name_prefix}-${var.environment}"
}

resource "heroku_app" "app" {
    name = local.app_name
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
    count = length(var.custom_domain) > 0 ? 1 : 0
    app      = heroku_app.app.name
    hostname = var.custom_domain
}

resource "heroku_addon" "queue" {
    count = length(var.queue_redis_plan) > 0 ? 1 : 0
    app  = heroku_app.app.name
    plan = "heroku-redis:${var.queue_redis_plan}"
}

resource "heroku_addon_attachment" "queue" {
    count = length(var.queue_redis_plan) > 0 ? 1 : 0
    app_id  = heroku_app.app.name
    addon_id = heroku_addon.queue[0].id
    name = "app_queue"
}

resource "heroku_addon" "cache" {
    count = length(var.cache_redis_plan) > 0 ? 1 : 0
    app  = heroku_app.app.name
    plan = "heroku-redis:${var.cache_redis_plan}"
}

resource "heroku_addon_attachment" "cache" {
    count = length(var.cache_redis_plan) > 0 ? 1 : 0
    app_id  = heroku_app.app.name
    addon_id = heroku_addon.cache[0].id
    name = "app_cache"
}

resource "heroku_addon" "bugsnag-deployhook" {
    count = length(var.bugsnag_api_key) > 0 ? 1 : 0
    app  = heroku_app.app.name
    plan = "deployhooks:http"

    config = {
        url = "https://build.bugsnag.com/heroku?apiKey=${var.bugsnag_api_key}&releaseStage=${var.environment}&repository=${urlencode(var.repo)}"
    }
}

data "heroku_addon" "papertrail_addon" {
    count = length(var.papertrail_addon_name) > 0 ? 1 : 0
    name = var.papertrail_addon_name
}

resource "heroku_addon_attachment" "papertrail-attachment" {
    count = length(var.papertrail_addon_name) > 0 ? 1 : 0
    app_id  = heroku_app.app.name
    addon_id = data.heroku_addon.papertrail_addon[0].id
}
