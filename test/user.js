'use strict';

var assert = require('assert');
var async = require('async');
var nconf = require('nconf');
var request = require('request');

var db = require('./mocks/databasemock');
var User = require('../src/user');
var Topics = require('../src/topics');
var Categories = require('../src/categories');
var Meta = require('../src/meta');
var Password = require('../src/password');
var groups = require('../src/groups');
var helpers = require('./helpers');
var meta = require('../src/meta');
var plugins = require('../src/plugins');

describe('User', function () {
	var userData;
	var testUid;
	var testCid;

	before(function (done) {

		groups.resetCache();

		Categories.create({
			name: 'Test Category',
			description: 'A test',
			order: 1
		}, function (err, categoryObj) {
			if (err) {
				return done(err);
			}

			testCid = categoryObj.cid;
			done();
		});
	});

	beforeEach(function () {
		userData = {
			username: 'John Smith',
			fullname: 'John Smith McNamara',
			password: 'swordfish',
			email: 'john@example.com',
			callback: undefined
		};
	});


	describe('.create(), when created', function () {
		it('should be created properly', function (done) {
			User.create({username: userData.username, password: userData.password, email: userData.email}, function (error,userId) {
				assert.equal(error, null, 'was created with error');
				assert.ok(userId);

				testUid = userId;
				done();
			});
		});

		it('should have a valid email, if using an email', function (done) {
			User.create({username: userData.username, password: userData.password, email: 'fakeMail'},function (err) {
				assert(err);
				assert.equal(err.message, '[[error:invalid-email]]');
				done();
			});
		});
	});

	describe('.isModerator()', function () {
		it('should return false', function (done) {
			User.isModerator(testUid, testCid, function (err, isModerator) {
				assert.equal(err, null);
				assert.equal(isModerator, false);
				done();
			});
		});

		it('should return two false results', function (done) {
			User.isModerator([testUid, testUid], testCid, function (err, isModerator) {
				assert.equal(err, null);
				assert.equal(isModerator[0], false);
				assert.equal(isModerator[1], false);
				done();
			});
		});

		it('should return two false results', function (done) {
			User.isModerator(testUid, [testCid, testCid], function (err, isModerator) {
				assert.equal(err, null);
				assert.equal(isModerator[0], false);
				assert.equal(isModerator[1], false);
				done();
			});
		});
	});

	describe('.isReadyToPost()', function () {
		it('should error when a user makes two posts in quick succession', function (done) {
			Meta.config = Meta.config || {};
			Meta.config.postDelay = '10';

			async.series([
				async.apply(Topics.post, {
					uid: testUid,
					title: 'Topic 1',
					content: 'lorem ipsum',
					cid: testCid
				}),
				async.apply(Topics.post, {
					uid: testUid,
					title: 'Topic 2',
					content: 'lorem ipsum',
					cid: testCid
				})
			], function (err) {
				assert(err);
				done();
			});
		});

		it('should allow a post if the last post time is > 10 seconds', function (done) {
			User.setUserField(testUid, 'lastposttime', +new Date() - (11 * 1000), function () {
				Topics.post({
					uid: testUid,
					title: 'Topic 3',
					content: 'lorem ipsum',
					cid: testCid
				}, function (err) {
					assert.ifError(err);
					done();
				});
			});
		});

		it('should error when a new user posts if the last post time is 10 < 30 seconds', function (done) {
			Meta.config.newbiePostDelay = 30;
			Meta.config.newbiePostDelayThreshold = 3;

			User.setUserField(testUid, 'lastposttime', +new Date() - (20 * 1000), function () {
				Topics.post({
					uid: testUid,
					title: 'Topic 4',
					content: 'lorem ipsum',
					cid: testCid
				}, function (err) {
					assert(err);
					done();
				});
			});
		});

		it('should not error if a non-newbie user posts if the last post time is 10 < 30 seconds', function (done) {
			User.setUserFields(testUid, {
				lastposttime:  +new Date() - (20 * 1000),
				reputation: 10
			}, function () {
				Topics.post({
					uid: testUid,
					title: 'Topic 5',
					content: 'lorem ipsum',
					cid: testCid
				}, function (err) {
					assert.ifError(err);
					done();
				});
			});
		});
	});

	describe('.search()', function () {
		var socketUser = require('../src/socket.io/user');
		it('should return an object containing an array of matching users', function (done) {
			User.search({query: 'john'}, function (err, searchData) {
				assert.ifError(err);
				assert.equal(Array.isArray(searchData.users) && searchData.users.length > 0, true);
				assert.equal(searchData.users[0].username, 'John Smith');
				done();
			});
		});

		it('should search user', function (done) {
			socketUser.search({uid: testUid}, {query: 'john'}, function (err, searchData) {
				assert.ifError(err);
				assert.equal(searchData.users[0].username, 'John Smith');
				done();
			});
		});

		it('should error for guest', function (done) {
			Meta.config.allowGuestUserSearching = 0;
			socketUser.search({uid: 0}, {query: 'john'}, function (err) {
				assert.equal(err.message, '[[error:not-logged-in]]');
				Meta.config.allowGuestUserSearching = 1;
				done();
			});
		});

		it('should error with invalid data', function (done) {
			socketUser.search({uid: testUid}, null, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});
	});

	describe('.delete()', function () {
		var uid;
		before(function (done) {
			User.create({username: 'usertodelete', password: '123456', email: 'delete@me.com'}, function (err, newUid) {
				assert.ifError(err);
				uid = newUid;
				done();
			});
		});

		it('should delete a user account', function (done) {
			User.delete(1, uid, function (err) {
				assert.ifError(err);
				User.existsBySlug('usertodelete', function (err, exists) {
					assert.ifError(err);
					assert.equal(exists, false);
					done();
				});
			});
		});
	});

	describe('passwordReset', function () {
		var uid,
			code;
		before(function (done) {
			User.create({username: 'resetuser', password: '123456', email: 'reset@me.com'}, function (err, newUid) {
				assert.ifError(err);
				uid = newUid;
				done();
			});
		});

		it('.generate() should generate a new reset code', function (done) {
			User.reset.generate(uid, function (err, _code) {
				assert.ifError(err);
				assert(_code);

				code = _code;
				done();
			});
		});

		it('.validate() should ensure that this new code is valid', function (done) {
			User.reset.validate(code, function (err, valid) {
				assert.ifError(err);
				assert.strictEqual(valid, true);
				done();
			});
		});

		it('.validate() should correctly identify an invalid code', function (done) {
			User.reset.validate(code + 'abcdef', function (err, valid) {
				assert.ifError(err);
				assert.strictEqual(valid, false);
				done();
			});
		});

		it('.send() should create a new reset code and reset password', function (done) {
			User.reset.send('reset@me.com', function (err, code) {
				if (err) {
					console.log(err);
				}
				done();
			});
		});

		it('.commit() should update the user\'s password', function (done) {
			User.reset.commit(code, 'newpassword', function (err) {
				assert.ifError(err);

				db.getObjectField('user:' + uid, 'password', function (err, newPassword) {
					assert.ifError(err);
					Password.compare('newpassword', newPassword, function (err, match) {
						assert.ifError(err);
						assert(match);
						done();
					});
				});
			});
		});
	});

	describe('hash methods', function () {

		it('should return uid from email', function (done) {
			User.getUidByEmail('john@example.com', function (err, uid) {
				assert.ifError(err);
				assert.equal(parseInt(uid, 10), parseInt(testUid, 10));
				done();
			});
		});

		it('should return uid from username', function (done) {
			User.getUidByUsername('John Smith', function (err, uid) {
				assert.ifError(err);
				assert.equal(parseInt(uid, 10), parseInt(testUid, 10));
				done();
			});
		});

		it('should return uid from userslug', function (done) {
			User.getUidByUserslug('john-smith', function (err, uid) {
				assert.ifError(err);
				assert.equal(parseInt(uid, 10), parseInt(testUid, 10));
				done();
			});
		});
	});

	describe('not logged in', function () {
		var jar;
		var io;
		before(function (done) {
			helpers.initSocketIO(function (err, _jar, _io) {
				assert.ifError(err);
				jar = _jar;
				io = _io;
				done();
			});
		});

		it('should return error if not logged in', function (done) {
			io.emit('user.updateProfile', {}, function (err) {
				assert.equal(err.message, '[[error:invalid-uid]]');
				done();
			});
		});
	});

	describe('profile methods', function () {
		var uid;
		var jar;
		var io;

		before(function (done) {
			User.create({username: 'updateprofile', email: 'update@me.com', password: '123456'}, function (err, newUid) {
				assert.ifError(err);
				uid = newUid;
				helpers.loginUser('updateprofile', '123456', function (err, _jar, _io) {
					assert.ifError(err);
					jar = _jar;
					io = _io;
					done();
				});
			});
		});

		it('should return error if data is invalid', function (done) {
			io.emit('user.updateProfile', null, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});

		it('should return error if data is missing uid', function (done) {
			io.emit('user.updateProfile', {username: 'bip', email: 'bop'}, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});

		it('should update a user\'s profile', function (done) {
			var data = {
				uid: uid,
				username: 'updatedUserName',
				email: 'updatedEmail@me.com',
				fullname: 'updatedFullname',
				website: 'http://nodebb.org',
				location: 'izmir',
				groupTitle: 'testGroup',
				birthday: '01/01/1980',
				signature: 'nodebb is good'
			};
			io.emit('user.updateProfile', data, function (err, result) {
				assert.ifError(err);

  				assert.equal(result.username, 'updatedUserName');
  				assert.equal(result.userslug, 'updatedusername');
  				assert.equal(result.email, 'updatedEmail@me.com');

				db.getObject('user:' + uid, function (err, userData) {
					assert.ifError(err);
					Object.keys(data).forEach(function (key) {
						assert.equal(data[key], userData[key]);
					});
					done();
				});
			});
		});

		it('should change a user\'s password', function (done) {
			this.timeout(20000);
			io.emit('user.changePassword', {uid: uid, newPassword: '654321', currentPassword: '123456'}, function (err) {
				assert.ifError(err);
				User.isPasswordCorrect(uid, '654321', function (err, correct) {
					assert.ifError(err);
					assert(correct);
					done();
				});
			});
		});

		it('should change username', function (done) {
			io.emit('user.changeUsernameEmail', {uid: uid, username: 'updatedAgain', password: '654321'}, function (err) {
				assert.ifError(err);
				db.getObjectField('user:' + uid, 'username', function (err, username) {
					assert.ifError(err);
					assert.equal(username, 'updatedAgain');
					done();
				});
			});
		});

		it('should change email', function (done) {
			io.emit('user.changeUsernameEmail', {uid: uid, email: 'updatedAgain@me.com', password: '654321'}, function (err) {
				assert.ifError(err);
				db.getObjectField('user:' + uid, 'email', function (err, email) {
					assert.ifError(err);
					assert.equal(email, 'updatedAgain@me.com');
					done();
				});
			});
		});

		it('should update cover image', function (done) {
			var imageData = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAgCAYAAAABtRhCAAAACXBIWXMAAC4jAAAuIwF4pT92AAAKT2lDQ1BQaG90b3Nob3AgSUNDIHByb2ZpbGUAAHjanVNnVFPpFj333vRCS4iAlEtvUhUIIFJCi4AUkSYqIQkQSoghodkVUcERRUUEG8igiAOOjoCMFVEsDIoK2AfkIaKOg6OIisr74Xuja9a89+bN/rXXPues852zzwfACAyWSDNRNYAMqUIeEeCDx8TG4eQuQIEKJHAAEAizZCFz/SMBAPh+PDwrIsAHvgABeNMLCADATZvAMByH/w/qQplcAYCEAcB0kThLCIAUAEB6jkKmAEBGAYCdmCZTAKAEAGDLY2LjAFAtAGAnf+bTAICd+Jl7AQBblCEVAaCRACATZYhEAGg7AKzPVopFAFgwABRmS8Q5ANgtADBJV2ZIALC3AMDOEAuyAAgMADBRiIUpAAR7AGDIIyN4AISZABRG8lc88SuuEOcqAAB4mbI8uSQ5RYFbCC1xB1dXLh4ozkkXKxQ2YQJhmkAuwnmZGTKBNA/g88wAAKCRFRHgg/P9eM4Ors7ONo62Dl8t6r8G/yJiYuP+5c+rcEAAAOF0ftH+LC+zGoA7BoBt/qIl7gRoXgugdfeLZrIPQLUAoOnaV/Nw+H48PEWhkLnZ2eXk5NhKxEJbYcpXff5nwl/AV/1s+X48/Pf14L7iJIEyXYFHBPjgwsz0TKUcz5IJhGLc5o9H/LcL//wd0yLESWK5WCoU41EScY5EmozzMqUiiUKSKcUl0v9k4t8s+wM+3zUAsGo+AXuRLahdYwP2SycQWHTA4vcAAPK7b8HUKAgDgGiD4c93/+8//UegJQCAZkmScQAAXkQkLlTKsz/HCAAARKCBKrBBG/TBGCzABhzBBdzBC/xgNoRCJMTCQhBCCmSAHHJgKayCQiiGzbAdKmAv1EAdNMBRaIaTcA4uwlW4Dj1wD/phCJ7BKLyBCQRByAgTYSHaiAFiilgjjggXmYX4IcFIBBKLJCDJiBRRIkuRNUgxUopUIFVIHfI9cgI5h1xGupE7yAAygvyGvEcxlIGyUT3UDLVDuag3GoRGogvQZHQxmo8WoJvQcrQaPYw2oefQq2gP2o8+Q8cwwOgYBzPEbDAuxsNCsTgsCZNjy7EirAyrxhqwVqwDu4n1Y8+xdwQSgUXACTYEd0IgYR5BSFhMWE7YSKggHCQ0EdoJNwkDhFHCJyKTqEu0JroR+cQYYjIxh1hILCPWEo8TLxB7iEPENyQSiUMyJ7mQAkmxpFTSEtJG0m5SI+ksqZs0SBojk8naZGuyBzmULCAryIXkneTD5DPkG+Qh8lsKnWJAcaT4U+IoUspqShnlEOU05QZlmDJBVaOaUt2ooVQRNY9aQq2htlKvUYeoEzR1mjnNgxZJS6WtopXTGmgXaPdpr+h0uhHdlR5Ol9BX0svpR+iX6AP0dwwNhhWDx4hnKBmbGAcYZxl3GK+YTKYZ04sZx1QwNzHrmOeZD5lvVVgqtip8FZHKCpVKlSaVGyovVKmqpqreqgtV81XLVI+pXlN9rkZVM1PjqQnUlqtVqp1Q61MbU2epO6iHqmeob1Q/pH5Z/YkGWcNMw09DpFGgsV/jvMYgC2MZs3gsIWsNq4Z1gTXEJrHN2Xx2KruY/R27iz2qqaE5QzNKM1ezUvOUZj8H45hx+Jx0TgnnKKeX836K3hTvKeIpG6Y0TLkxZVxrqpaXllirSKtRq0frvTau7aedpr1Fu1n7gQ5Bx0onXCdHZ4/OBZ3nU9lT3acKpxZNPTr1ri6qa6UbobtEd79up+6Ynr5egJ5Mb6feeb3n+hx9L/1U/W36p/VHDFgGswwkBtsMzhg8xTVxbzwdL8fb8VFDXcNAQ6VhlWGX4YSRudE8o9VGjUYPjGnGXOMk423GbcajJgYmISZLTepN7ppSTbmmKaY7TDtMx83MzaLN1pk1mz0x1zLnm+eb15vft2BaeFostqi2uGVJsuRaplnutrxuhVo5WaVYVVpds0atna0l1rutu6cRp7lOk06rntZnw7Dxtsm2qbcZsOXYBtuutm22fWFnYhdnt8Wuw+6TvZN9un2N/T0HDYfZDqsdWh1+c7RyFDpWOt6azpzuP33F9JbpL2dYzxDP2DPjthPLKcRpnVOb00dnF2e5c4PziIuJS4LLLpc+Lpsbxt3IveRKdPVxXeF60vWdm7Obwu2o26/uNu5p7ofcn8w0nymeWTNz0MPIQ+BR5dE/C5+VMGvfrH5PQ0+BZ7XnIy9jL5FXrdewt6V3qvdh7xc+9j5yn+M+4zw33jLeWV/MN8C3yLfLT8Nvnl+F30N/I/9k/3r/0QCngCUBZwOJgUGBWwL7+Hp8Ib+OPzrbZfay2e1BjKC5QRVBj4KtguXBrSFoyOyQrSH355jOkc5pDoVQfujW0Adh5mGLw34MJ4WHhVeGP45wiFga0TGXNXfR3ENz30T6RJZE3ptnMU85ry1KNSo+qi5qPNo3ujS6P8YuZlnM1VidWElsSxw5LiquNm5svt/87fOH4p3iC+N7F5gvyF1weaHOwvSFpxapLhIsOpZATIhOOJTwQRAqqBaMJfITdyWOCnnCHcJnIi/RNtGI2ENcKh5O8kgqTXqS7JG8NXkkxTOlLOW5hCepkLxMDUzdmzqeFpp2IG0yPTq9MYOSkZBxQqohTZO2Z+pn5mZ2y6xlhbL+xW6Lty8elQfJa7OQrAVZLQq2QqboVFoo1yoHsmdlV2a/zYnKOZarnivN7cyzytuQN5zvn//tEsIS4ZK2pYZLVy0dWOa9rGo5sjxxedsK4xUFK4ZWBqw8uIq2Km3VT6vtV5eufr0mek1rgV7ByoLBtQFr6wtVCuWFfevc1+1dT1gvWd+1YfqGnRs+FYmKrhTbF5cVf9go3HjlG4dvyr+Z3JS0qavEuWTPZtJm6ebeLZ5bDpaql+aXDm4N2dq0Dd9WtO319kXbL5fNKNu7g7ZDuaO/PLi8ZafJzs07P1SkVPRU+lQ27tLdtWHX+G7R7ht7vPY07NXbW7z3/T7JvttVAVVN1WbVZftJ+7P3P66Jqun4lvttXa1ObXHtxwPSA/0HIw6217nU1R3SPVRSj9Yr60cOxx++/p3vdy0NNg1VjZzG4iNwRHnk6fcJ3/ceDTradox7rOEH0x92HWcdL2pCmvKaRptTmvtbYlu6T8w+0dbq3nr8R9sfD5w0PFl5SvNUyWna6YLTk2fyz4ydlZ19fi753GDborZ752PO32oPb++6EHTh0kX/i+c7vDvOXPK4dPKy2+UTV7hXmq86X23qdOo8/pPTT8e7nLuarrlca7nuer21e2b36RueN87d9L158Rb/1tWeOT3dvfN6b/fF9/XfFt1+cif9zsu72Xcn7q28T7xf9EDtQdlD3YfVP1v+3Njv3H9qwHeg89HcR/cGhYPP/pH1jw9DBY+Zj8uGDYbrnjg+OTniP3L96fynQ89kzyaeF/6i/suuFxYvfvjV69fO0ZjRoZfyl5O/bXyl/erA6xmv28bCxh6+yXgzMV70VvvtwXfcdx3vo98PT+R8IH8o/2j5sfVT0Kf7kxmTk/8EA5jz/GMzLdsAAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAACcJJREFUeNqMl9tvnNV6xn/f+s5z8DCeg88Zj+NYdhJH4KShFoJAIkzVphLVJnsDaiV6gUKaC2qQUFVATbnoValAakuQYKMqBKUUJCgI9XBBSmOROMqGoCStHbA9sWM7nrFn/I3n9B17kcwoabfarj9gvet53+d9nmdJAwMDAAgh8DyPtbU1XNfFMAwkScK2bTzPw/M8dF1/SAhxKAiCxxVF2aeqqqTr+q+Af+7o6Ch0d3f/69TU1KwkSRiGwbFjx3jmmWd47rnn+OGHH1BVFYX/5QRBkPQ87xeSJP22YRi/oapqStM0PM/D931kWSYIgnHf98cXFxepVqtomjZt2/Zf2bb990EQ4Pv+PXfeU1CSpGYhfN9/TgjxQTQaJQgCwuEwQRBQKpUwDAPTNPF9n0ajAYDv+8zPzzM+Pr6/Wq2eqdVqfxOJRA6Zpnn57hrivyEC0IQQZ4Mg+MAwDCKRCJIkUa/XEUIQi8XQNI1QKIQkSQghUBQFIQSmaTI7OwtAuVxOTE9Pfzc9Pf27lUqlBUgulUoUi0VKpRKqqg4EQfAfiqLsDIfDAC0E4XCYaDSKEALXdalUKvfM1/d9hBBYlkUul2N4eJi3335bcl33mW+++aaUz+cvSJKE8uKLL6JpGo7j8Omnn/7d+vp6sr+/HyEEjuMgyzKu6yJJEsViEVVV8TyPjY2NVisV5fZkTNMkkUhw8+ZN6vU6Kysr7Nmzh9OnT7/12GOPDS8sLByT7rQR4A9XV1d/+cILLzA9PU0kEmF4eBhFUTh//jyWZaHrOkII0uk0jUaDWq1GJpOhWCyysrLC1tYWnuehqir79+9H13W6urp48803+f7773n++ef/4G7S/H4ikUCSJNbX11trcuvWLcrlMrIs4zgODzzwABMTE/i+T7lcpq2tjUqlwubmJrZts7y8jBCCkZERGo0G2WyWkydPkkql6Onp+eMmwihwc3JyMvrWW2+RTCYBcF0XWZbRdZ3l5WX27NnD008/TSwWQ1VVyuVy63GhUIhEIkEqlcJxHCzLIhaLMTQ0xJkzZ7Btm3379lmS53kIIczZ2dnFsbGxRK1Wo729HQDP8zAMg5WVFXp7e5mcnKSzs5N8Po/rutTrdVzXbQmHrutEo1FM00RVVXp7e0kkEgRBwMWLF9F1vaxUq1UikUjtlVdeuV6pVBJ9fX3Ytn2bwrLMysoKXV1dTE5OkslksCwLTdMwDANVVdnY2CAIApLJJJFIBMdxiMfj7Nq1C1VViUajLQCvvvrqkhKJRJiZmfmdb7/99jeTySSyLLfWodFoEAqFOH78OLt37yaXy2GaJoqisLy8zNTUFFevXiUIAtrb29m5cyePPPJIa+cymQz1eh2A0dFRCoXCsgIwNTW1J5/P093dTbFYRJZlJEmiWq1y4MABxsbGqNVqhEIh6vU6QRBQLpcxDIPh4WE8z2NxcZFTp05x7tw5Xn755ZY6dXZ2tliZzWa/EwD1ev3RsbExxsfHSafTVCoVGo0Gqqqya9cuIpEIQgh832dtbY3FxUUA+vr62LZtG2NjYxw5coTDhw+ztLTEyZMnuXr1KoVC4R4d3bt375R84sQJEY/H/2Jubq7N9326urqwbZt6vY5pmhw5coS+vr4W9YvFIrdu3WJqagohBFeuXOHcuXOtue7evRtN01rtfO+991haWmJkZGQrkUi8JIC9iqL0BkFAIpFACMETTzxBV1cXiUSC7u5uHMfB8zyCIMA0TeLxONlsFlmW8X2fwcFBHMdhfn6eer1Oe3s7Dz30EBMTE1y6dImjR49y6tSppR07dqwrjuM8+OWXXzI0NMTly5e5du0aQ0NDTExMkMvlCIKAIAhaIh2LxQiHw0QiEfL5POl0mlqtRq1Wo6OjA8uykGWZdDrN0tISvb29vPPOOzz++OPk83lELpf7rXfffRfDMOjo6MBxHEqlEocOHWLHjh00Gg0kSULTNIS4bS6qqhKPxxkaGmJ4eJjR0VH279/PwMAA27dvJ5vN4vs+X331FR9//DGzs7OEQiE++eQTlPb29keuX7/OtWvXOH78ONVqlZs3b9LW1kYmk8F13dZeCiGQJAnXdRFCYBgGsiwjhMC2bQqFAkEQoOs6P/74Iw8++CCDg4Pous6xY8f47LPPkIIguDo2Nrbzxo0bfPjhh9i2zczMTHNvcF2XpsZalkWj0cB1Xe4o1O3YoCisra3x008/EY/H6erqAuDAgQNEIhGCIODQoUP/ubCwMCKAjx599FHW19f56KOP6OjooFgsks/niUajKIqCbds4joMQAiFESxxs226xd2Zmhng8Tl9fH67r0mg0sG2bbDZLpVIhl8vd5gHwtysrKy8Dcdd1mZubo6enh1gsRrVabZlrk6VND/R9n3q9TqVSQdd1QqEQi4uLnD9/nlKpxODgIHv37gXAcRyCICiFQiHEzp07i1988cUfKYpCIpHANE22b9/eUhNFUVotDIKghc7zPCzLolKpsLW1RVtbG0EQ4DgOmqbR09NDM1qUSiWAPwdQ7ujjmf7+/kQymfxrSZJQVZWtra2WG+i63iKH53m4rku1WqVcLmNZFu3t7S2x7+/vJ51O89prr7VYfenSpcPAP1UqFeSHH36YeDxOKpW6eP/9988Bv9d09nw+T7VapVKptJjZnE2tVmNtbY1cLke5XGZra4vNzU16enp49tlnGRgYaD7iTxqNxgexWIzDhw+jNEPQHV87NT8/f+PChQtnR0ZGqFarrUVuOsDds2u2b2FhgVQqRSQSYWFhgStXrtDf308ymcwBf3nw4EEOHjx4O5c2lURVVRzHYXp6+t8uX7785IULFz7LZDLous59991HOBy+h31N9xgdHSWTyVCtVhkaGmLfvn1MT08zPz/PzMzM6c8//9xr+uE9QViWZer1OhsbGxiG8fns7OzPc7ncx729vXR3d1OpVNi2bRuhUAhZljEMA9/3sW0bVVVZWlri4sWLjI+P8/rrr/P111/z5JNPXrIs69cn76ZeGoaBpmm0tbX9Q6FQeHhubu7fC4UCkUiE1dVVstks8Xgc0zSRZZlGo9ESAdM02djYoNFo8MYbb2BZ1mYoFOKuZPjr/xZBEHCHred83x/b3Nz8l/X19aRlWWxsbNDZ2cnw8DDhcBjf96lWq/T09HD06FGeeuopXnrpJc6ePUs6nb4hhPi/C959ZFn+TtO0lG3bJ0ql0p85jsPW1haFQoG2tjYkSWpF/Uwmw9raGu+//z7A977vX2+GrP93wSZiTdNOGIbxy3K5/DPHcfYXCoVe27Yzpmm2m6bppVKp/Orqqnv69OmoZVn/mEwm/9TzvP9x138NAMpJ4VFTBr6SAAAAAElFTkSuQmCC';
			var position = '50.0301% 19.2464%';
			io.emit('user.updateCover', {uid: uid, imageData: imageData, position: position}, function (err, result) {
				assert.ifError(err);
				assert(result.url);
				db.getObjectFields('user:' + uid, ['cover:url', 'cover:position'], function (err, data) {
					assert.ifError(err);
					assert.equal(data['cover:url'], result.url);
					assert.equal(data['cover:position'], position);
					done();
				});
			});
		});

		it('should remove cover image', function (done) {
			io.emit('user.removeCover', {uid: uid}, function (err) {
				assert.ifError(err);
				db.getObjectField('user:' + uid, 'cover:url', function (err, url) {
					assert.ifError(err);
					assert.equal(url, null);
					done();
				});
			});
		});

		it('should set user status', function (done) {
			io.emit('user.setStatus', 'away', function (err, data) {
				assert.ifError(err);
				assert.equal(data.uid, uid);
				assert.equal(data.status, 'away');
				done();
			});
		});

		it('should fail for invalid status', function (done) {
			io.emit('user.setStatus', '12345', function (err) {
				assert.equal(err.message, '[[error:invalid-user-status]]');
				done();
			});
		});

		it('should get user status', function (done) {
			io.emit('user.checkStatus', uid, function (err, status) {
				assert.ifError(err);
				assert.equal(status, 'away');
				done();
			});
		});

		it('should change user picture', function (done) {
			io.emit('user.changePicture', {type: 'default', uid: uid}, function (err) {
				assert.ifError(err);
				User.getUserField(uid, 'picture', function (err, picture) {
					assert.ifError(err);
					assert.equal(picture, '');
					done();
				});
			});
		});

		it('should upload profile picture', function (done) {
			var path = require('path');
			var picture = {
				path: path.join(nconf.get('base_dir'), 'public', 'logo.png'),
				size: 7189,
				name: 'logo.png'
			};
			User.uploadPicture(uid, picture, function (err, uploadedPicture) {
				assert.ifError(err);
				assert.equal(uploadedPicture.url, '/uploads/profile/' + uid + '-profileimg.png');
				assert.equal(uploadedPicture.path, path.join(nconf.get('base_dir'), 'public', 'uploads', 'profile', uid + '-profileimg.png'));
				done();
			});
		});
		
		it('should return error if profile image uploads disabled', function (done) {
			meta.config.allowProfileImageUploads = 0;
			var path = require('path');
			var picture = {
				path: path.join(nconf.get('base_dir'), 'public', 'logo.png'),
				size: 7189,
				name: 'logo.png'
			};
			User.uploadPicture(uid, picture, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:profile-image-uploads-disabled]]');
				done();
			});
		});
		
		it('should return error if profile image is too big', function (done) {
			meta.config.allowProfileImageUploads = 1;
			var path = require('path');
			var picture = {
				path: path.join(nconf.get('base_dir'), 'public', 'logo.png'),
				size: 265000,
				name: 'logo.png'
			};
			User.uploadPicture(uid, picture, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:file-too-big, 256]]');
				done();
			});
		});
		
		it('should return error if profile image file has no extension', function (done) {
			var path = require('path');
			var picture = {
				path: path.join(nconf.get('base_dir'), 'public', 'logo.png'),
				size: 7189,
				name: 'logo'
			};
			User.uploadPicture(uid, picture, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:invalid-image-extension]]');
				done();
			});
		});
		
		it('should return error if no plugins listening for filter:uploadImage when uploading from url', function (done) {
			var url = nconf.get('url') + '/logo.png';
			User.uploadFromUrl(uid, url, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:no-plugin]]');
				done();
			});
		});
		
		it('should return error if the extension is invalid when uploading from url', function (done) {
			var url = nconf.get('url') + '/favicon.ico';
			
			function filterMethod(data, callback) {
				data.foo += 5;
				callback(null, data);
			}

			plugins.registerHook('test-plugin', {hook: 'filter:uploadImage', method: filterMethod});
		
			User.uploadFromUrl(uid, url, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:invalid-image-extension]]');
				done();
			});
		});
		
		it('should return error if the file is too big when uploading from url', function (done) {
			var url = nconf.get('url') + '/logo.png';
			meta.config.maximumProfileImageSize = 1;
			
			function filterMethod(data, callback) {
				data.foo += 5;
				callback(null, data);
			}

			plugins.registerHook('test-plugin', {hook: 'filter:uploadImage', method: filterMethod});
		
			User.uploadFromUrl(uid, url, function (err, uploadedPicture) {
				assert.equal(err.message, '[[error:file-too-big, ' + meta.config.maximumProfileImageSize + ']]');
				done();
			});
		});
		
		it('should upload picture when uploading from url', function (done) {
			var url = nconf.get('url') + '/logo.png';
			meta.config.maximumProfileImageSize = '';
			
			function filterMethod(data, callback) {
				data.foo += 5;
				callback(null, {url: url});
			}

			plugins.registerHook('test-plugin', {hook: 'filter:uploadImage', method: filterMethod});
		
			User.uploadFromUrl(uid, url, function (err, uploadedPicture) {
				assert.ifError(err);
				assert.equal(uploadedPicture.url, url);
				done();
			});
		});

		it('should get profile pictures', function (done) {
			io.emit('user.getProfilePictures', {uid: uid}, function (err, data) {
				assert.ifError(err);
				assert(data);
				assert(Array.isArray(data));
				assert.equal(data[0].type, 'uploaded');
				assert.equal(data[0].text, '[[user:uploaded_picture]]');
				done();
			});
		});

		it('should remove uploaded picture', function (done) {
			io.emit('user.removeUploadedPicture', {uid: uid}, function (err) {
				assert.ifError(err);
				User.getUserField(uid, 'uploadedpicture', function (err, uploadedpicture) {
					assert.ifError(err);
					assert.equal(uploadedpicture, '');
					done();
				});
			});
		});

		it('should load profile page', function (done) {
			request(nconf.get('url') + '/api/user/updatedagain', {jar: jar, json: true}, function (err, res, body) {
				assert.ifError(err);
				assert.equal(res.statusCode, 200);
				assert(body);
				done();
			});
		});

		it('should load settings page', function (done) {
			request(nconf.get('url') + '/api/user/updatedagain/settings', {jar: jar, json: true}, function (err, res, body) {
				assert.ifError(err);
				assert.equal(res.statusCode, 200);
				assert(body.settings);
				assert(body.languages);
				assert(body.homePageRoutes);
				done();
			});
		});

		it('should load edit page', function (done) {
			request(nconf.get('url') + '/api/user/updatedagain/edit', {jar: jar, json: true}, function (err, res, body) {
				assert.ifError(err);
				assert.equal(res.statusCode, 200);
				assert(body);
				done();
			});
		});

		it('should load edit/email page', function (done) {
			request(nconf.get('url') + '/api/user/updatedagain/edit/email', {jar: jar, json: true}, function (err, res, body) {
				assert.ifError(err);
				assert.equal(res.statusCode, 200);
				assert(body);
				done();
			});
		});

		it('should load user\'s groups page', function (done) {
			groups.create({
				name: 'Test',
				description: 'Foobar!'
			}, function (err) {
				assert.ifError(err);
				groups.join('Test', uid, function (err) {
					assert.ifError(err);
					request(nconf.get('url') + '/api/user/updatedagain/groups', {jar: jar, json: true}, function (err, res, body) {
						assert.ifError(err);
						assert.equal(res.statusCode, 200);
						assert(Array.isArray(body.groups));
						assert.equal(body.groups[0].name, 'Test');
						done();
					});
				});
			});

		});
	});

	describe('.getModerationHistory', function () {
		it('should return the correct ban reason', function (done) {
			async.series([
				function (next) {
					User.ban(testUid, 0, '', function (err) {
						assert.ifError(err);
						next(err);
					});
				},
				function (next) {
					User.getModerationHistory(testUid, function (err, data) {
						assert.ifError(err);
						assert.equal(data.bans.length, 1, 'one ban');
						assert.equal(data.bans[0].reason, '[[user:info.banned-no-reason]]', 'no ban reason');

						next(err);
					});
				}
			], function (err) {
				assert.ifError(err);
				User.unban(testUid, function (err) {
					assert.ifError(err);
					done();
				});
			});
		});
	});

	describe('digests', function () {
		var uid;
		before(function (done) {
			User.create({username: 'digestuser', email: 'test@example.com'}, function (err, _uid) {
				assert.ifError(err);
				uid = _uid;
				done();
			});
		});

		it('should send digests', function (done) {
			User.updateDigestSetting(uid, 'day', function (err) {
				assert.ifError(err);
					User.digest.execute('day', function (err) {
					assert.ifError(err);
					done();
				});
			});
		});
	});

	describe('socket methods', function () {
		var socketUser = require('../src/socket.io/user');

		it('should fail with invalid data', function (done) {
			socketUser.exists({uid: testUid}, null, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});

		it('should return true if user/group exists', function (done) {
			socketUser.exists({uid: testUid}, {username: 'registered-users'}, function (err, exists) {
				assert.ifError(err);
				assert(exists);
				done();
			});
		});

		it('should return true if user/group exists', function (done) {
			socketUser.exists({uid: testUid}, {username: 'John Smith'}, function (err, exists) {
				assert.ifError(err);
				assert(exists);
				done();
			});
		});

		it('should return false if user/group does not exist', function (done) {
			socketUser.exists({uid: testUid}, {username: 'doesnot exist'}, function (err, exists) {
				assert.ifError(err);
				assert(!exists);
				done();
			});
		});

		it('should delete user', function (done) {
			User.create({username: 'tobedeleted'}, function (err, _uid) {
				assert.ifError(err);
				socketUser.deleteAccount({uid: _uid}, {}, function (err) {
					assert.ifError(err);
					socketUser.exists({uid: testUid}, {username: 'doesnot exist'}, function (err, exists) {
						assert.ifError(err);
						assert(!exists);
						done();
					});
				});
			});
		});

		it('should fail if data is invalid', function (done) {
			socketUser.emailExists({uid: testUid}, null, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});

		it('should return true if email exists', function (done) {
			socketUser.emailExists({uid: testUid}, {email: 'john@example.com'}, function (err, exists) {
				assert.ifError(err);
				assert(exists);
				done();
			});
		});

		it('should return false if email does not exist', function (done) {
			socketUser.emailExists({uid: testUid}, {email: 'does@not.exist'}, function (err, exists) {
				assert.ifError(err);
				assert(!exists);
				done();
			});
		});

		it('should error if requireEmailConfirmation is disabled', function (done) {
			socketUser.emailConfirm({uid: testUid}, {}, function (err) {
				assert.equal(err.message, '[[error:email-confirmations-are-disabled]]');
				done();
			});
		});

		it('should send email confirm', function (done) {
			Meta.config.requireEmailConfirmation = 1;
			socketUser.emailConfirm({uid: testUid}, {}, function (err) {
				assert.ifError(err);
				Meta.config.requireEmailConfirmation = 0;
				done();
			});
		});

		it('should send reset email', function (done) {
			socketUser.reset.send({uid: 0}, 'john@example.com', function (err) {
				assert.ifError(err);
				done();
			});
		});

		it('should return invalid-data error', function (done) {
			socketUser.reset.send({uid: 0}, null, function (err) {
				assert.equal(err.message, '[[error:invalid-data]]');
				done();
			});
		});

		it('should not error', function (done) {
			socketUser.reset.send({uid: 0}, 'doestnot@exist.com', function (err) {
				assert.ifError(err);
				done();
			});
		});

		it('should commit reset', function (done) {
			db.getObject('reset:uid', function (err, data) {
				assert.ifError(err);
				var code = Object.keys(data)[0];
				socketUser.reset.commit({uid: 0}, {code: code, password: 'swordfish'}, function (err) {
					assert.ifError(err);
					done();
				});
			});
		});

		it('should save user settings', function (done) {
			var data = {
				uid: 1,
				settings: {
					bootswatchSkin: 'default',
					homePageRoute: 'none',
					homePageCustom: '',
					openOutgoingLinksInNewTab: 0,
					scrollToMyPost: 1,
					delayImageLoading: 1,
					userLang: 'en-GB',
					usePagination: 1,
					topicsPerPage: '10',
					postsPerPage: '5',
					showemail: 1,
					showfullname: 1,
					restrictChat: 0,
					followTopicsOnCreate: 1,
					followTopicsOnReply: 1,
					notificationSound: '',
					incomingChatSound: '',
					outgoingChatSound: ''
				}
			};
			socketUser.saveSettings({uid: testUid}, data, function (err) {
				assert.ifError(err);
				done();
			});
		});

		it('should set moderation note', function (done) {
			User.create({username: 'noteadmin'}, function (err, adminUid) {
				assert.ifError(err);
				groups.join('administrators', adminUid, function (err) {
					assert.ifError(err);
					socketUser.setModerationNote({uid: adminUid}, {uid: testUid, note: 'this is a test user'}, function (err) {
						assert.ifError(err);
						User.getUserField(testUid, 'moderationNote', function (err, note) {
							assert.ifError(err);
							assert.equal(note, 'this is a test user');
							done();
						});
					});
				});
			});

		});
	});

	describe('approval queue', function () {
		var socketAdmin = require('../src/socket.io/admin');

		var oldRegistrationType;
		var adminUid;
		before(function (done) {
			oldRegistrationType = Meta.config.registrationType;
			Meta.config.registrationType = 'admin-approval';
			User.create({username: 'admin', password: '123456'}, function (err, uid) {
				assert.ifError(err);
				adminUid = uid;
				groups.join('administrators', uid, done);
			});
		});

		after(function (done) {
			Meta.config.registrationType = oldRegistrationType;
			done();
		});

		it('should add user to approval queue', function (done) {
			helpers.registerUser({
				username: 'rejectme',
				password: '123456',
				email: 'reject@me.com'
			}, function (err) {
				assert.ifError(err);
				helpers.loginUser('admin', '123456', function (err, jar) {
					assert.ifError(err);
					request(nconf.get('url') + '/api/admin/manage/registration', {jar: jar, json: true}, function (err, res, body) {
						assert.ifError(err);
						assert.equal(body.users[0].username, 'rejectme');
						assert.equal(body.users[0].email, 'reject@me.com');
						done();
					});
				});
			});
		});

		it('should reject user registration', function (done) {
			socketAdmin.user.rejectRegistration({uid: adminUid}, {username: 'rejectme'}, function (err) {
				assert.ifError(err);
				User.getRegistrationQueue(0, -1, function (err, users) {
					assert.ifError(err);
					assert.equal(users.length, 0);
					done();
				});
			});
		});

		it('should accept user registration', function (done) {
			helpers.registerUser({
				username: 'acceptme',
				password: '123456',
				email: 'accept@me.com'
			}, function (err) {
				assert.ifError(err);
				socketAdmin.user.acceptRegistration({uid: adminUid}, {username: 'acceptme'}, function (err, uid) {
					assert.ifError(err);
					User.exists(uid, function (err, exists) {
						assert.ifError(err);
						assert(exists);
						User.getRegistrationQueue(0, -1, function (err, users) {
							assert.ifError(err);
							assert.equal(users.length, 0);
							done();
						});
					});
				});
			});
		});

	});


	after(function (done) {
		db.emptydb(done);
	});
});
