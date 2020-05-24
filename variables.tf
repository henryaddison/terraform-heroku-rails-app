# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

variable "app_name_prefix" {
  description = "The prefix for app being created"
  type        = string
}

variable "region" {
  description = "The Heroku region in which the app lives"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "config_vars" {
  description = "Config variables for the Heroku app"
  type        = map(string)
  default     = {}
}

variable "sensitive_config_vars" {
  description = "Sensitive config variables for the Heroku app to hide in output"
  type        = map(string)
  default     = {}
}

variable "custom_domain" {
  description = "The name of the environment we're deploying to (optional - leave blank if don't need a custom domain)"
  type        = string
  default = ""
}

variable "enable_acm" {
    description = "Whether to enable ACM"
    type = bool
    default = true
}

variable "db_plan" {
    description = "Name of the Heroku PG plan to use for the database"
    type = string
    default = "hobby-dev"
}

variable "queue_redis_plan" {
    description = "Name of the Heroku Redis plan to use as a backing store for the background job queue (optional - leave blank if don't need redis for a background job queue"
    type = string
    default = ""
}

variable "cache_redis_plan" {
    description = "Name of the Heroku Redis plan to use as a cache backing store (optional - leave blank if don't need redis for a cache)"
    type = string
    default = ""
}

variable "bugsnag_api_key" {
    description = "API key to hook up to Bugsnag (optional - leave blank if not linked to bugsnag)"
    type = string
    default = ""
}

variable "repo" {
    description = "Github repo (optional)"
    type = string
    default = ""
}

variable "heroku_team_name" {
    description = "Name of the team in which this app should live (optional - leave blank if no team)"
    type = string
    default = ""
}

variable "papertrail_addon_name" {
    description = "Name of the Papertrail Heroku addon which should be used to collect logs (leave blank if don't want to collect logs in papertrail)"
    type = string
    default = ""
}
