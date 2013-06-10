// Private methods.
// ----------------

// Guides object.
var guides = [
    {
        "title"   : "Getting started",
        "content" : "Hi there! Thanks for using the __Advanced AngularJS project generator__. This little documentation will guide you to learn how to use it!"
    },
    {
        "title"   : "Creating a project",
        "content" : "To start an awesome project, you just need to run `yo generate angularjs` and a complete scaffolding for your project will be created (including this tutorial with its scaffolding)."
    },
    {
        "title"   : "Generating a scaffold",
        "content" : [
            {
                "title"   : "TODO",
                "content" : "This write this documentation."
            }
        ]
    }
];

// Public methods.
// -----------------

// Return guides object.
exports.all = function(req, res) {
    res.json(guides);
}