// Module dependencies.
// --------------------
var express          = require('express'),
    expressNamespace = require('express-namespace'),
    expressResource  = require('express-resource'),
    fs               = require('fs'),
    mongoose         = require('mongoose');

// Create express function and server variable.
var app    = express(),
    server = require('http').createServer(app);

// ExpressJS configuration and environment settings.
var env    = process.env.NODE_ENV || 'development',
    config = require('./config/environment')[env];

require('./config/express')(app, env, config);

// Connect to MongoDB server and load models.
mongoose.connect(config.db);

// Load all Model files from application modules.
var appPath = __dirname + '/app/';

fs.readdirSync(appPath).forEach(function (file) {
    var filePath = appPath + file + '/',
        stat     = fs.statSync(filePath);

    if (stat.isDirectory()) {

        fs.readdirSync(filePath).forEach(function (file) {

            if (file.indexOf('Model.js') >= 0) {
                require(filePath + file);
            }
        });
    }
});

// Load application routes module.
require('./config/routes')(app);

// Export modules for Grunt task.
// ------------------------------
module.exports = server;

module.exports.use = function() {
    app.use.apply(app, arguments);
}