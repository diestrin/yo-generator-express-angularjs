# Module dependencies.
# --------------------
mongoose = require 'mongoose'
Notes    = mongoose.model 'Notes'

# Private methods.
# ----------------

# Return a single instance of the model.
findById = (id, callback) ->
    Notes.findById id, (err, note) ->

        if err or not note
            res.status 404
            res.json
                message : 'Requested Note didn\'t exist.'
        else
            callback note

# Public methods.
# -----------------

# Return Notes list.
exports.index = (req, res) ->
    Notes.find (err, notes) ->

        if  err
            res.status 500
            res.json err
        else
            res.json notes

# Insert new Note.
exports.create = (req, res) ->
    Note = new Notes req.body
    Note.save (err, note) ->

        if err
            res.status 400
            res.json err
        else
            res.json
                message : 'Note created successfully.', data : note

# Get a Note.
exports.show = (req, res) ->
    findById req.params.note, (note) ->
        res.json note

# Edit Note.
exports.update = (req, res) ->
    findById req.params.note, (note) ->

        # Remove id from payload to avoid Mongoose problems.
        delete req.body._id

        # Set updated_at date when the model is updated.
        req.body.updated_at = new Date().toISOString()
        note.update req.body, (err, note) ->

            if err
                res.status 400
                res.json
                    message : err
            else
                res.json
                    message : 'Note updated successfully.'

# Remove Note.
exports.destroy = (req, res) ->
    findById req.params.note, (note) ->
        note.remove (err, note) ->

            if err
                res.status 404
                res.json err
            else
                res.json
                    message : 'Note destroyed successfully.'
