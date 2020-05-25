resource "heroku_addon" "redis" {
    count = length(var.plan) > 0 ? 1 : 0

    app  = var.app
    plan = "heroku-redis:${var.plan}"
}

resource "heroku_addon_attachment" "redis" {
    count = length(var.plan) > 0 ? 1 : 0

    app_id  = var.app
    addon_id = heroku_addon.redis[0].id
    name = var.name
}
