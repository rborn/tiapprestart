var tiapprestart = require('info.rborn.tiapprestart');

var win = Ti.UI.createWindow({
	backgroundColor:'#fff'
});

var restartButton = Ti.UI.createButton({
	title:'Restart application'
});

win.add(restartButton);

restartButton.addEventListener('click', function(){
	tiapprestart.restartApp();
});


win.open();