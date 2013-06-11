// Module dependencies.
// --------------------
var mongoose = require('mongoose'),
    Todos    = mongoose.model('Todos');

// Private methods.
// ----------------


// Public methods.
// -----------------

// Return Todos list.
exports.index = function (req, res) {

    Todos.find(function (err, todos) {

        if (err) {
            res.status(500);
            res.json(err);
        }
        else {
            res.json(todos);
        }
    });
};

// Insert new Todo.
exports.create = function (req, res) {
    var Todo = new Todos(req.body);

    Todo.save(function (err, todo) {

        if (err) {
            res.status(400);
            res.json(err);
        }
        else {
            res.json({ message : 'Todo created successfully.', data : todo });
        }
    });
};

// Get a Todo.
exports.show = function (req, res) {

    Todos.findById(req.params.todo, function (err, todo) {

        if (err || !todo) {
            res.status(404);
            res.json({ message : 'Requested Todo didn\'t exist.' });
        }
        else {
            res.json(todo);
        }
    });
};

// Edit Todo.
exports.update = function (req, res) {

    Todos.findById(req.params.todo, function (err, todo) {

        if (err || !todo) {
            res.status(404);
            res.json({ message : 'Requested Todo didn\'t exist.' });
        }
        else {

            // Remove id from payload to avoid Mongoose problems.
            delete req.body._id;

            // Set updated_at date when the model is updated.
            req.body.updated_at = new Date().toISOString();

            todo.update(req.body, function (err, todo) {

                if (err) {
                    res.status(400);
                    res.json({ message : err });
                }
                else {
                    res.json({ message : 'Todo updated successfully.' });
                }
            });
        }
    });
}

// Remove Todo.
exports.destroy = function (req, res) {
    
    Todos.findById(req.params.todo, function (err, todo) {

        if (err || !todo) {
            res.status(404);
            res.json({ message : 'Requested Todo didn\'t exist.' });
        }
        else {
            todo.remove(function (err, todo) {

                if (err) {
                    res.status(400);
                    res.json(err);
                }
                else {
                    res.json({ message : 'Todo destroyed successfully.' });
                }
            });
        }
    });
}
