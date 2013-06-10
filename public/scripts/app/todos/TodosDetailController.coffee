# Todos Detail controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosDetailController', (todo, Todos, $location) ->

    # Todos list.
    @data = todo

    # Toggle edit form.
    @toggleEdit = =>
        @editing = !@editing

    # Edit Todo.
    @update = =>
        @data.put().then (response) =>
            @toggleEdit()

    # Delete Todo.
    @remove = ->
        
        if confirm 'Are you sure you want to delete this Todo?'
            Todos.remove @data._id, (response) ->
                console.log response
                $location.path '/'

    # Return controller data.
    return @


# Resolver for Todos Detail controller.
# -------------------------------
window.TodosDetailControllerResolve = ($q, $route, Todos) ->
    defer = $q.defer()
    id    = $route.current.params.id

    # Get all todo items.
    Todos.one id, (todo) ->
        defer.resolve(todo)

    defer.promise

# Inject services to resolver.
TodosDetailControllerResolve.$inject = [ '$q', '$route', 'Todos' ]