provider "heroku" {
    version = "~> 2.0"
}

module "heroku_app" {
    source  = "henryaddison/rails-app/heroku"
    version = "0.0.1"

    environment = "test"
    custom_domain = "terraform-team-example.hja22.co.uk"
    app_name_prefix = "terraform-team-example"
    region = "eu"
    config_vars = {}
    sensitive_config_vars = {}
    enable_acm = true
    db_plan = "hobby-dev"
    queue_redis_plan = "hobby-dev"
    cache_redis_plan = "hobby-dev"
    bugsnag_api_key = ""
    repo = "https://github.com/henryaddison/my-rails-app"
    heroku_team_name = "hja22"
    papertrail_addon_name = ""
}
