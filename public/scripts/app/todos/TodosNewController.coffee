# New Todo controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosNewController', (Todos, $location) ->

    # Save new Todo.
    @create = =>
        Todos.create @data, (response) ->
            $location.path '/todos/' + response.data._id

    # Return controller data.
    return @
    