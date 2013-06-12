'use strict'

# Module dependencies.
path = require 'path'

module.exports = (grunt) ->

    # Load all Grunt tasks
    require('matchdep').filterAll('grunt-*').forEach grunt.loadNpmTasks

    # Grunt configuration.
    # --------------------
    grunt.initConfig

        # Load folders configuration.
        appConfig: grunt.file.readJSON './AppConfig.json'

        # Install Bower dependencies.
        bower:
            install:
                options:
                    install : true

        # Clean folders before compile assets.
        clean:
            bower   : 'lib'
            dev     : '<%= appConfig.app.dev %>'
            dist    : '<%= appConfig.app.dist %>'
            html    : '<%= appConfig.app.dev %>/**/*.html'
            scripts : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.scripts %>'
            styles  : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.styles %>'

        # Compile CoffeeScript.
        coffee:

            # Compile Coffee for development environment.
            dev:
                expand : true
                cwd    : '<%= appConfig.app.src %>/<%= appConfig.app.assets.scripts %>'
                dest   : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.scripts %>'
                src    : '**/*.coffee'
                ext    : '.js'

        # Compile Compass.
        compass:

            # Compile Compass for development environment.
            dev:
                options:
                    cssDir         : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.styles %>'
                    fontsDir       : '<%= appConfig.app.src %>/<%= appConfig.app.assets.fonts %>'
                    imagesDir      : '<%= appConfig.app.src %>/<%= appConfig.app.assets.images %>'
                    importPath     : '<%= appConfig.app.src %>/<%= appConfig.app.assets.lib %>'
                    javascriptsDir : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.scripts %>'
                    relativeAssets : true
                    sassDir        : '<%= appConfig.app.src %>/<%= appConfig.app.assets.styles %>'

        # Copy files to production folder.
        copy:
            dev:
                files: [
                    cwd    : '<%= appConfig.app.src %>'
                    dest   : '<%= appConfig.app.dev %>'
                    expand : true
                    src    : [ '**/*' ]
                ]

            dist:
                files: [
                    cwd    : '<%= appConfig.app.dev %>'
                    dest   : '<%= appConfig.app.dist %>'
                    dot    : true
                    expand : true
                    src    : [
                        '**'
                        '!**/lib/**'
                        '!**/*.jade'
                        '!**/<%= appConfig.app.assets.templates %>/**'
                        '!**/<%= appConfig.app.assets.scripts %>/**'
                        '!**/<%= appConfig.app.assets.styles %>/**'
                    ]
                ]

        # Start ExpressJS server.
        express:

            # Development environment.
            dev:
                options:
                    bases   : [
                        '<%= appConfig.app.dev %>'
                        '<%= appConfig.app.src %>'
                    ]
                    debug   : true
                    monitor : {}
                    port    : 3000
                    server  : path.resolve './<%= appConfig.app.server %>'

            # Production environment.
            dist:
                options:
                    bases   : [
                        '<%= appConfig.app.dist %>'
                    ]
                    port    : process.env.PORT or 3000
                    server  : path.resolve './<%= appConfig.app.server %>'

        # Minify HTML files.
        htmlmin:
            dist:
                options:
                    removeCommentsFromCDATA   : true
                    collapseWhitespace        : true
                    collapseBooleanAttributes : true
                    removeAttributeQuotes     : true
                    removeRedundantAttributes : true
                    useShortDoctype           : true
                    removeEmptyAttributes     : true
                    removeOptionalTags        : true

                files: [
                    expand : true
                    cwd    : '<%= appConfig.app.dist %>'
                    dest   : '<%= appConfig.app.dist %>'
                    src    : '**/*.html'
                ]

        # Compile Jade.
        jade:
            dev:
                files:
                    '<%= appConfig.app.dev %>/' : '<%= appConfig.app.src %>/**/*.jade'
            options:
                basePath     : '<%= appConfig.app.src %>'
                client       : false
                compileDebug : false
                pretty       : true

        # Generate anotations for angular injections.
        ngmin:
            dist:
                cwd    : '<%= appConfig.app.dist %>/<%= appConfig.app.assets.scripts %>'
                expand : true
                src    : [ '**/*.js' ]
                dest   : '<%= appConfig.app.dist %>/<%= appConfig.app.assets.scripts %>'

        # Inline AngularJS templates.
        ngtemplates:
            dist:
                options:
                    base   : '<%= appConfig.app.dev %>'
                    module : '<%= appConfig.app.ngModule %>'
                src  : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.templates %>/**/*.html'
                dest : '<%= appConfig.app.dev %>/<%= appConfig.app.assets.scripts %>/templates.js'

        # Open a web server with a given URL.
        open:
            server:
                path: 'http://localhost:3000'

        # Watch for changes in assets and compile.
        watch:
            coffee:
                files   : '<%= appConfig.app.src %>/<%= appConfig.app.assets.scripts %>/**/*.coffee'
                tasks   : 'compile:coffee'
                options :
                    livereload : true
            compass:
                files   : '<%= appConfig.app.src %>/<%= appConfig.app.assets.styles %>/**/*.{sass,scss}'
                tasks   : 'compile:compass'
                options :
                    livereload : true
            jade:
                files   : '<%= appConfig.app.src %>/**/*.jade'
                tasks   : 'compile:jade'
                options :
                    livereload : true

        # Use minified assets on HTML files depending on environment.
        usemin:
            html : [ '<%= appConfig.app.dist %>/**/*.html' ]

        # Prepare usemin to compile assets in the specified order.
        useminPrepare:
            html    : '<%= appConfig.app.dev %>/**/*.html'
            options :
                dest : '<%= appConfig.app.dist %>'

    # Custom tasks.
    # -------------

    # Compile assets.
    grunt.registerTask 'compile', (task) ->

        if task is undefined
            console.log 'Running all compilers.'
            return grunt.task.run [
                'compile:coffee'
                'compile:compass'
                'compile:jade'
            ]

        switch task
            when 'coffee'  then cleaner = 'clean:scripts'
            when 'compass' then cleaner = 'clean:styles'
            when 'jade'    then cleaner = 'clean:html'

        grunt.task.run [
            cleaner
            task
        ]

    # Compress, concatenate, generate documentation and run unit tests.
    grunt.registerTask 'build', [
        'clean:dist'
        'compile'
        'copy:dist'
        'copy:dev'
        'ngtemplates'
        'useminPrepare'
        'concat'
        'cssmin'
        'ngmin'
        'uglify'
        'usemin'
        'htmlmin'
        'clean:dev'
    ]

    # Start local server and watch for changes in files.
    grunt.registerTask 'dev', [
        'compile'
        'express:dev'
        'open'
        'watch'
    ]

    # Create build and then open it for preview.
    grunt.registerTask 'dist', [
        'express:dist'
        'express-keepalive'
    ]

    # Compile assets for production on Heroku side.
    grunt.registerTask 'heroku', [
        'bower'
        'clean:bower'
        'build'
    ]

    # Alias build task as Grunt default task.
    grunt.registerTask 'default', [
        'build'
    ]
