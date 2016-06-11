var fs = require('fs');
var spawn = require('child_process').spawn;

try {
	fs.statSync('name-by-index');
} catch (e) {
	fs.mkdirSync('name-by-index');
}

var files = fs.readdirSync('data');
var amount = String(files.length).length;

// imitates pad-left
files.forEach(function (file, index) {
	var filename = '';
	for (var i = 0; i < amount - String(index).length; i ++) {
		filename += '0';
	}
	filename += index + '.png';
	spawn('cp', ['data/' + file, 'name-by-index/' + filename]);
});
