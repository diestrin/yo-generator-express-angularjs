// Application routes module.
module.exports = function (app) {

    // API routes.
    app.namespace('/api', function () {

        // Guides resource.
        app.resource('todos', require('../app/todos/TodosController'))
    });
};