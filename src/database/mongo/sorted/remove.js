'use strict';
const util = require('util')

module.exports = function (db, module) {

	var helpers = module.helpers.mongo;

	module.sortedSetRemove = function (key, value, callback) {
		function done(err) {
			callback(err);
		}
		callback = callback || helpers.noop;
		if (!key) {
			return callback();
		}

		if (Array.isArray(value)) {
			value = value.map(helpers.valueToString);
			util.callbackify(() => db.collection('objects').deleteMany({_key: key, value: {$in: value}}))(done);
		} else {
			value = helpers.valueToString(value);
			util.callbackify(() => db.collection('objects').deleteMany({_key: key, value: value}))(done);
		}
	};

	module.sortedSetsRemove = function (keys, value, callback) {
		callback = callback || helpers.noop;
		if (!Array.isArray(keys) || !keys.length) {
			return callback();
		}
		value = helpers.valueToString(value);

		util.callbackify(() => db.collection('objects').deleteMany({_key: {$in: keys}, value: value}))(function (err) {
			callback(err);
		});
	};

	module.sortedSetsRemoveRangeByScore = function (keys, min, max, callback) {
		callback = callback || helpers.noop;
		if (!Array.isArray(keys) || !keys.length) {
			return callback();
		}
		var query = {_key: {$in: keys}};

		if (min !== '-inf') {
			query.score = {$gte: min};
		}
		if (max !== '+inf') {
			query.score = query.score || {};
			query.score.$lte = max;
		}

		util.callbackify(() => db.collection('objects').deleteMany(query))(function (err) {
			callback(err);
		});
	};

};