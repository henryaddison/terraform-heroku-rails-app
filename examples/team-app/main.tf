provider "heroku" {
    version = "~> 2.0"
}

locals {
    environment = "test"
    bugsnag_api_key = ""
    repo = "https://github.com/henryaddison/my-rails-app"
}

module "heroku_app" {
    source  = "henryaddison/rails-app/heroku"
    version = "0.0.4"

    environment = local.environment
    custom_domain = "terraform-team-example.hja22.co.uk"
    app_name_prefix = "terraform-team-example"
    region = "eu"
    config_vars = {}
    sensitive_config_vars = {}
    enable_acm = true
    db_plan = "hobby-dev"
    queue_redis_plan = "hobby-dev"
    cache_redis_plan = "hobby-dev"
    heroku_team_name = "hja22"
    papertrail_addon_name = ""

    deploy_hook_urls = [
        "https://build.bugsnag.com/heroku?apiKey=${local.bugsnag_api_key}&releaseStage=${local.environment}&repository=${urlencode(local.repo)}"
    ]
}
