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
        RestangularProvider.setBaseUrl '/api'

        # Models default Primary Key.
        RestangularProvider.setRestangularFields
            id : '_id'

        # Application routes.
        $routeProvider

        # List all todos.
        .when '/todos',
            controller  : 'TodosIndexController as todos'
            templateUrl : 'templates/views/todos/TodosIndexView.html'
            resolve     :
                todos : TodosIndexControllerResolve

        # Create new todo.
        .when '/todos/new',
            controller  : 'TodosNewController as todo'
            templateUrl : 'templates/views/todos/TodosNewView.html'

        # View a todo.
        .when '/todos/:id',
            controller  : 'TodosDetailController as todo'
            templateUrl : 'templates/views/todos/TodosDetailView.html'
            resolve     :
                todo : TodosDetailControllerResolve

        # Edit a todo.
        .when '/todos/:id/edit',
            controller  : 'TodosEditController as todo'
            templateUrl : 'templates/views/todos/TodosEditView.html'
            resolve     :
                todo : TodosEditControllerResolve

        .otherwise
            redirectTo : '/todos'

    # Application runtime configuration and events.
    .run ($rootScope) ->

        # Show loading message on route change start.
        $rootScope.$on '$routeChangeStart', (event, next, current) ->
            $rootScope.loading = true

        # Hide loading message on route change success.
        $rootScope.$on '$routeChangeSuccess', (event, next, current) ->
            $rootScope.loading = false