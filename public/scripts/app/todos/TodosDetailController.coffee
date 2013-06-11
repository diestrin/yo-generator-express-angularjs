# Todos Detail controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosDetailController', (todo, $location) ->

    # Todo.
    @data = todo

    # Delete Todo.
    @remove = ->
        if confirm 'Are you sure you want to delete this Todo?'
            @data.remove().then (response) ->
                $location.path '/'

    # Return controller data.
    return @


# Resolver for Todos Detail controller.
# -------------------------------
window.TodosDetailControllerResolve = ($q, $route, Todos) ->
    defer = $q.defer()
    id    = $route.current.params.id

    # Get Todo.
    Todos.one id, (todo) ->
        defer.resolve(todo)

    defer.promise

# Inject services to resolver.
TodosDetailControllerResolve.$inject = [ '$q', '$route', 'Todos' ]
