# Todos Index controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosIndexController', (todos) ->

    # View title.
    @title = 'Todo list.'

    # Todos list.
    @list = todos

    # Return controller data.
    return @


# Resolver for Todos Index controller.
# -------------------------------
window.TodosIndexControllerResolve = ($q, Todos) ->
    defer = $q.defer()

    # Get all todo items.
    Todos.all (todos) ->
        defer.resolve(todos)

    defer.promise

# Inject services to resolver.
TodosIndexControllerResolve.$inject = [ '$q', 'Todos' ]