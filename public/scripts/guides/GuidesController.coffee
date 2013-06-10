# Guides controller.
# ------------------
window.GuidesController = angular.module('myAwesomeApp').controller 'GuidesController', (guides, $scope) ->

    # View title.
    @title = 'Generator documentation.'

    # Guides list.
    @list = guides

    # Return controller data.
    return @


# Resolver for Guides controller.
# -------------------------------
GuidesController.resolve = ($q, Guides) ->
    defer = $q.defer()

    # Get all guide documents.
    Guides.getList().then (guides) ->
        defer.resolve(guides)

    defer.promise

# Inject services to resolver.
GuidesController.resolve.$inject = [ '$q', 'Guides' ]