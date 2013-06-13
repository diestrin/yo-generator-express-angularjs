# Edit Note controller.
# ------------------
angular.module('myAwesomeApp').controller 'NotesEditController', (note, $location) ->

    # Note.
    @data = note

    # Edit Note.
    @update = =>
        @data.put().then (response) =>
            $location.path '/notes/' + @data._id

    # Return controller data.
    return @


# Resolver for Notes Edit controller.
# -------------------------------
window.NotesEditControllerResolve = ($q, $route, Notes) ->
    defer = $q.defer()
    id    = $route.current.params.id

    # Get Note.
    Notes.one id, (note) ->
        defer.resolve(note)

    defer.promise

# Inject services to resolver.
NotesEditControllerResolve.$inject = [ '$q', '$route', 'Notes' ]
