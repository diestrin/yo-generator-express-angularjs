# Application routes module.
module.exports = (app) ->

    # API routes.
    app.namespace '/api', ->

        # Notes resource.
        app.resource 'notes', require '../app/notes/NotesController'
