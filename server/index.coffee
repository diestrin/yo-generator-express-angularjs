# Module dependencies.
# --------------------
express          = require 'express'
expressNamespace = require 'express-namespace'
expressResource  = require 'express-resource'
fs               = require 'fs'
mongoose         = require 'mongoose'

# Create express function and server variable.
app    = express()
server = require('http').createServer app

# ExpressJS configuration and environment settings.
env    = process.env.NODE_ENV or 'development'
config = require('./config/environment')[env]

require('./config/express') app, env, config

# Connect to MongoDB server and load models.
mongoose.connect config.db

# Load all Model files from application modules.
appPath = __dirname + '/app/'

fs.readdirSync(appPath).forEach (file) ->
    filePath = appPath + file + '/'
    stat     = fs.statSync filePath

    if stat.isDirectory()
        fs.readdirSync(filePath).forEach (file) ->

            if file.indexOf('Model.coffee') >= 0
                require filePath + file

# Load application routes module.
require('./config/routes')(app)

# Export modules for Grunt task.
module.exports = server

module.exports.use = ->
    app.use.apply app, arguments