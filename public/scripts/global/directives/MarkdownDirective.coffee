# Markdown directive for AngularJS.
# ---------------------------------
# Convert a given Markdown text to an HTML output.
# Depends on Showdown library (https://github.com/coreyti/showdown).

angular.module('myAwesomeApp').directive 'markdown', ->
    restrict :  'E'

    link     : (scope, element, attrs) ->
        converter = new Showdown.converter()
        element.html converter.makeHtml attrs.text