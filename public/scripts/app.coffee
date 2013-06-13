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

        # List all notes.
        .when '/notes',
            controller  : 'NotesIndexController as notes'
            templateUrl : 'templates/views/notes/NotesIndexView.html'
            resolve     :
                notes : NotesIndexControllerResolve

        # Create new note.
        .when '/notes/new',
            controller  : 'NotesNewController as note'
            templateUrl : 'templates/views/notes/NotesNewView.html'

        # View a note.
        .when '/notes/:id',
            controller  : 'NotesDetailController as note'
            templateUrl : 'templates/views/notes/NotesDetailView.html'
            resolve     :
                note : NotesDetailControllerResolve

        # Edit a note.
        .when '/notes/:id/edit',
            controller  : 'NotesEditController as note'
            templateUrl : 'templates/views/notes/NotesEditView.html'
            resolve     :
                note : NotesEditControllerResolve

        .otherwise
            redirectTo : '/notes'

    # Application runtime configuration and events.
    .run ($rootScope) ->

        # Show loading message on route change start.
        $rootScope.$on '$routeChangeStart', (event, next, current) ->
            $rootScope.loading = true

        # Hide loading message on route change success.
        $rootScope.$on '$routeChangeSuccess', (event, next, current) ->
            $rootScope.loading = false