Example usage to create a personal app with no Redis addons, no ACM, no custom domain.

```
terraform init
HEROKU_EMAIL="$(heroku auth:whoami)}" HEROKU_API_KEY="$(heroku auth:token)" terraform apply
```
