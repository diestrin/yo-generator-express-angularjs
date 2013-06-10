// Private methods.
// ----------------

// Guides object.
var guides = [
    {
        "id"      : 1,
        "title"   : "Getting started",
        "content" : "Hi there! Thanks for using the __Advanced AngularJS project generator__. This little documentation will guide you to learn how to use it!"
    },
    {
        "id"      : 2,
        "title"   : "Creating a project",
        "content" : "To start an awesome project, you just need to run `yo generate angularjs` and a complete scaffolding for your project will be created (including this tutorial with its scaffolding)."
    },
    {
        "id"      : 3,
        "title"   : "Generating a scaffold",
        "content" : [
            {
                "title"   : "TODO",
                "content" : "Write this documentation."
            }
        ]
    }
];

// Public methods.
// -----------------

// Return guides list.
exports.index = function (req, res) {
    res.json(guides);
};

// Insert new guide.
exports.create = function (req, res) {
    res.send('Adding a new guide.');
};

// Return guide.
exports.show = function (req, res) {

    for (var i in guides) {

        if (guides[i].id == req.params.guide) {
            res.statusCode = 200;
            res.json(guides[i]);

            break;
        }

        else {
            res.statusCode = 404;
            res.json({
                status : 404,
                msg    : 'The requested doc wasn\'t found.'
            });
        }
    }
};

// Edit guide.
exports.update = function (req, res) {
    res.send('Updating some guide.');
}

// Remove guide.
exports.destroy = function (req, res) {
    res.send('Removing some guide.');
}
