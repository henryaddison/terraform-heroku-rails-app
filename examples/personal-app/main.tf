provider "heroku" {
  version = "~> 2.0"
}

locals {
  environment     = "test"
  bugsnag_api_key = ""
  repo            = "https://github.com/henryaddison/my-rails-app"
}

module "heroku_app" {
  source  = "henryaddison/rails-app/heroku"
  version = "0.0.4"

  environment           = local.environment
  custom_domain         = ""
  app_name_prefix       = "tf-personal-example"
  region                = "eu"
  config_vars           = {}
  sensitive_config_vars = {}
  enable_acm            = false
  db_plan               = "hobby-dev"
  queue_redis_plan      = ""
  cache_redis_plan      = ""
  heroku_team_name      = ""
  papertrail_addon_name = ""

  deploy_hook_urls = [
    "https://build.bugsnag.com/heroku?apiKey=${local.bugsnag_api_key}&releaseStage=${local.environment}&repository=${urlencode(local.repo)}"
  ]
}
