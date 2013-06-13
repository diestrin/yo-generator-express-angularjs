# Configure ExpressJS web server.

# Module dependencies.
# --------------------
express   = require 'express'

# Export module.
# --------------
module.exports = (app, env, config) ->

    # Server configuration.
    app.configure ->

        # Configuration for development environment.
        if env is 'development'

            # Enable Express logger.
            app.use express.logger()

            # Enable LiveReload middleware.
            {livereloadSnippet} = require 'grunt-contrib-livereload/lib/utils'
            app.use livereloadSnippet

        # Configuration for production environment.
        else if env is 'production'

            # Enable gzip compression for public assets.
            app.use express.compress()

        # General configuration.
        # ----------------------
        app.use express.favicon config.public + 'favicon.ico'
        app.use express.bodyParser()
        app.use express.methodOverride()

        # Enable ExpressJS router.
        app.use app.router
