# Edit Todo controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosEditController', (todo, $location) ->

    # Todo.
    @data = todo

    # Edit Todo.
    @update = =>
        @data.put().then (response) =>
            $location.path '/todos/' + @data._id

    # Return controller data.
    return @


# Resolver for Todos Edit controller.
# -------------------------------
window.TodosEditControllerResolve = ($q, $route, Todos) ->
    defer = $q.defer()
    id    = $route.current.params.id

    # Get Todo.
    Todos.one id, (todo) ->
        defer.resolve(todo)

    defer.promise

# Inject services to resolver.
TodosEditControllerResolve.$inject = [ '$q', '$route', 'Todos' ]
