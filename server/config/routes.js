// Module dependencies.
// --------------------
var guides = require('../app/guides/GuidesController');

// Application routes module.
module.exports = function(app) {

    // Place here your API routes.
    app.get('/api/guides', guides.all);
}