# Application routes module.
module.exports = (app) ->

    # API routes.
    app.namespace '/api', ->

        # Guides resource.
        app.resource 'todos', require '../app/todos/TodosController'
