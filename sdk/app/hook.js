var hooks = require('hooks');

hooks.beforeAll(function (transactions) {
	hooks.log('before all');
});

hooks.beforeEach(function (transaction) {
	hooks.log('before each');
});

hooks.before("Machines > Machines collection > Get Machines", function (transaction) {
	hooks.log("before");
});

hooks.beforeEachValidation(function (transaction) {
	hooks.log('before each validation');
});

hooks.beforeValidation("Machines > Machines collection > Get Machines", function (transaction) {
	hooks.log("before validation");
});

hooks.after("Machines > Machines collection > Get Machines", function (transaction) {
	hooks.log("after");
});

hooks.afterEach(function (transaction) {
	hooks.log('after each');
});

hooks.afterAll(function (transactions) {
	hooks.log('after all');
})