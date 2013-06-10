angular.module('myAwesomeApp').controller 'GuidesController', (guides, $scope) ->

    # View title.
    @title = 'Generator documentation.'

    # Guides list.
    @list = guides

    # Return controller data.
    return @