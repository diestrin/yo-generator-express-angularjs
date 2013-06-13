# Notes Index controller.
# ------------------
angular.module('myAwesomeApp').controller 'NotesIndexController', (notes) ->

    # Notes list.
    @list = notes

    # Return controller data.
    return @


# Resolver for Notes Index controller.
# -------------------------------
window.NotesIndexControllerResolve = ($q, Notes) ->
    defer = $q.defer()

    # Get all Notes.
    Notes.all (notes) ->
        defer.resolve(notes)

    defer.promise

# Inject services to resolver.
NotesIndexControllerResolve.$inject = [ '$q', 'Notes' ]
