var fs = require('fs');
var spawn = require('child_process').spawn;
var m = 3;

fs.readdirSync('data').forEach(function (file, index) {
	var newfile = file.split('_')[0] + '_';
	for (var i = 0; i < m - ('' + index).length; i ++) {
		newfile += '0';
	}
	newfile += index + '.png';
	console.log(newfile)
	spawn('cp', ['data/' + file, 'data2/' + newfile]);
})