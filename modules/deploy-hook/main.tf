resource "heroku_addon" "deploy_hook" {
    app  = var.app
    plan = "deployhooks:http"

    config = {
        url = var.url
    }
}
