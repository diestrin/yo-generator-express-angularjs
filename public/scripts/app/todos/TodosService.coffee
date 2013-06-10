angular.module('myAwesomeApp').factory 'Todos', (Restangular) ->

    # Service methods.
    # ----------------

    # Get all Todos.
    all : (callback) ->
        Restangular.all('todos').getList().then (todos) ->
            callback todos

    # Create a Todo.
    create : (data, callback) ->
        Restangular.all('todos').post(data).then (response) ->
            callback response

    # Get one Todo.
    one : (id, callback) ->
        Restangular.one('todos', id).get().then (todo) ->
            callback todo

    # Delete a Todo.
    remove : (id, callback) ->
        Restangular.one('todos', id).remove().then (response) ->
            callback response