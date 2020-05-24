output "web_url" {
    description = "The web (HTTP) URL that the application can be accessed at by default."
    value = module.heroku_app.web_url
}

output "heroku_hostname" {
    description = "A hostname for the Heroku application, suitable for pointing DNS records."
    value = module.heroku_app.heroku_hostname
}

output "heroku_app_name" {
    description = "Name of the Heroku app."
    value = module.heroku_app.heroku_app_name
}
