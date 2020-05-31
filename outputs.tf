output "web_url" {
  description = "The web (HTTP) URL that the application can be accessed at by default."
  value       = heroku_app.app.web_url
}

output "heroku_hostname" {
  description = "A hostname for the Heroku application, suitable for pointing DNS records."
  value       = heroku_app.app.heroku_hostname
}

output "heroku_app_name" {
  description = "Name of the Heroku app."
  value       = heroku_app.app.name
}
