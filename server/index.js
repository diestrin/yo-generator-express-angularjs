// Module dependencies.
// --------------------
var express          = require('express'),
    expressNamespace = require('express-namespace'),
    expressResource  = require('express-resource');

// Create express function and server variable.
var app    = express(),
    server = require('http').createServer(app);

// ExpressJS configuration and environment settings.
var env    = process.env.NODE_ENV || 'development',
    config = require('./config/environment')[env];

require('./config/express')(app, env, config);

// Load application routes module.
require('./config/routes')(app);

// Export modules for Grunt task.
// ------------------------------
module.exports = server;

module.exports.use = function() {
    app.use.apply(app, arguments);
}