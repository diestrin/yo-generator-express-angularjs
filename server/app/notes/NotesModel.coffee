# Module dependencies.
# --------------------
mongoose = require 'mongoose'

# Notes Model.
NotesSchema = new mongoose.Schema
    name :
        type     : String
        required : true

    description :
        type : String

    created_at : Date
    updated_at : Date

# Save current date on model creation.
NotesSchema.pre 'save', (next, done) ->
    this.created_at = new Date().toISOString()
    next()

# Register Mongoose model.
mongoose.model 'Notes', NotesSchema