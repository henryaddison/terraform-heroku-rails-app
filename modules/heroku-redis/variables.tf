# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "plan" {
    description = "Name of the Heroku Redis plan to use (leave blank for no add-on)"
    type = string
}

variable "app" {
    description = "Name of the Heroku app to which to attach the Redis add-on"
    type = string
}

variable "name" {
    description = "Name of the Heroku Redis add-on"
    type = string
}
