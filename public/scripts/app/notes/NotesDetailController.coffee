# Notes Detail controller.
# ------------------
angular.module('myAwesomeApp').controller 'NotesDetailController', (note, $location) ->

    # Note.
    @data = note

    # Delete Note.
    @remove = ->
        if confirm 'Are you sure you want to delete this Note?'
            @data.remove().then (response) ->
                $location.path '/'

    # Return controller data.
    return @


# Resolver for Notes Detail controller.
# -------------------------------
window.NotesDetailControllerResolve = ($q, $route, Notes) ->
    defer = $q.defer()
    id    = $route.current.params.id

    # Get Note.
    Notes.one id, (note) ->
        defer.resolve(note)

    defer.promise

# Inject services to resolver.
NotesDetailControllerResolve.$inject = [ '$q', '$route', 'Notes' ]
