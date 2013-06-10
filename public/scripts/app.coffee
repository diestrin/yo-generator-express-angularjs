# Awesome Application.
# --------------------
# Scaffolding sample for the Express-AngularJS generator for Yeoman.
# 
# Dependencies:
# - Restangular (https://github.com/mgonto/restangular)

angular.module('myAwesomeApp', [ 'restangular' ])

    # Application configuration.
    .config (RestangularProvider, $routeProvider) ->

        # API base URL.
        RestangularProvider.setBaseUrl '/models'

        # Application routes.
        $routeProvider

        .when '/guides',
            controller  : 'GuidesController as guides'
            templateUrl : 'templates/guides/GuidesView.html'
            resolve     :
                guides : GuidesController.resolve

        .otherwise
            redirectTo : '/guides'

    # Application runtime configuration and events.
    .run ($rootScope) ->

        # Show loading message on route change start.
        $rootScope.$on '$routeChangeStart', (event, next, current) ->
            $rootScope.loading = true

        # Hide loading message on route change success.
        $rootScope.$on '$routeChangeSuccess', (event, next, current) ->
            $rootScope.loading = false