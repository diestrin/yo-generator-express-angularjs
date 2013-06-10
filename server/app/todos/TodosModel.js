// Module dependencies.
// --------------------

var mongoose = require('mongoose');

// Todos Model.
var TodosSchema = new mongoose.Schema({
    name        : { type : String, required : true },
    description : { type : String },
    created_at  : Date,
    updated_at  : Date
});

// Save current date on model creation or update.
TodosSchema.pre('save', function (next, done) {
    this.created_at = new Date().toISOString();
    next();
});

// Register Mongoose model.
mongoose.model('Todos', TodosSchema);