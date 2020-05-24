Example usage to create a team app with queue and cache Redis addons, ACM enabled, a custom domain.

```
terraform init
HEROKU_EMAIL="$(heroku auth:whoami)}" HEROKU_API_KEY="$(heroku auth:token)" terraform apply
```
