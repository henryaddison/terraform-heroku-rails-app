# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "url" {
  description = "URL to hit each deploy"
  type        = string
}

variable "app" {
  description = "Name of the Heroku app to which to attach the deploy hook"
  type        = string
}
