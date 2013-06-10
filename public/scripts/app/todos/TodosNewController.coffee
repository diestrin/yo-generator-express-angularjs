# New Todo controller.
# ------------------
angular.module('myAwesomeApp').controller 'TodosNewController', (Todos, $location) ->

    # View title.
    @title = 'Create new Todo'

    # Save new Todo.
    @create = =>
        Todos.create @data, (response) ->
            $location.path '/todos/' + response.data._id

    # Return controller data.
    return @