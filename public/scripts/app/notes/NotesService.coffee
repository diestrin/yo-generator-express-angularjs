angular.module('myAwesomeApp').factory 'Notes', (Restangular) ->

    # Service methods.
    # ----------------

    # Get all Notes.
    all : (callback) ->
        Restangular.all('notes').getList().then (notes) ->
            callback notes

    # Create a Note.
    create : (data, callback) ->
        Restangular.all('notes').post(data).then (response) ->
            callback response

    # Get one Note.
    one : (id, callback) ->
        Restangular.one('notes', id).get().then (note) ->
            callback note
