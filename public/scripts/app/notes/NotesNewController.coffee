# New Note controller.
# ------------------
angular.module('myAwesomeApp').controller 'NotesNewController', (Notes, $location) ->

    # Save new Note.
    @create = =>
        Notes.create @data, (response) ->
            $location.path '/notes/' + response.data._id

    # Return controller data.
    return @
    