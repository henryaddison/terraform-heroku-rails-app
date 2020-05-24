provider "heroku" {
    version = "~> 2.0"
}

module "heroku_app" {
    source  = "henryaddison/rails-app/heroku"
    version = "0.0.3"

    environment = "test"
    custom_domain = ""
    app_name_prefix = "tf-personal-example"
    region = "eu"
    config_vars = {}
    sensitive_config_vars = {}
    enable_acm = false
    db_plan = "hobby-dev"
    queue_redis_plan = ""
    cache_redis_plan = ""
    bugsnag_api_key = ""
    repo = "https://github.com/henryaddison/my-rails-app"
    heroku_team_name = ""
    papertrail_addon_name = ""
}
