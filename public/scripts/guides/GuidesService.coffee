angular.module('myAwesomeApp').factory 'Guides', (Restangular) ->
    return Restangular.all 'guides'