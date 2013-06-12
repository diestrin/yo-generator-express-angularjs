# Module dependencies.
# --------------------
mongoose = require 'mongoose'
Todos    = mongoose.model 'Todos'

# Private methods.
# ----------------

# Return a single instance of the model.
findById = (id, callback) ->
    Todos.findById id, (err, todo) ->

        if err or not todo
            res.status 404
            res.json
                message : 'Requested Todo didn\'t exist.'
        else
            callback todo

# Public methods.
# -----------------

# Return Todos list.
exports.index = (req, res) ->
    Todos.find (err, todos) ->

        if  err
            res.status 500
            res.json err
        else
            res.json todos

# Insert new Todo.
exports.create = (req, res) ->
    Todo = new Todos req.body
    Todo.save (err, todo) ->

        if err
            res.status 400
            res.json err
        else
            res.json
                message : 'Todo created successfully.', data : todo

# Get a Todo.
exports.show = (req, res) ->
    findById req.params.todo, (todo) ->
        res.json todo

# Edit Todo.
exports.update = (req, res) ->
    findById req.params.todo, (todo) ->

        # Remove id from payload to avoid Mongoose problems.
        delete req.body._id

        # Set updated_at date when the model is updated.
        req.body.updated_at = new Date().toISOString()
        todo.update req.body, (err, todo) ->

            if err
                res.status 400
                res.json
                    message : err
            else
                res.json
                    message : 'Todo updated successfully.'

# Remove Todo.
exports.destroy = (req, res) ->
    findById req.params.todo, (todo) ->
        todo.remove (err, todo) ->

            if err
                res.status 404
                res.json err
            else
                res.json
                    message : 'Todo destroyed successfully.'
