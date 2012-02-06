// Here is an example on how to use the Dictionary module
var referenceLibrary = require('bencoding.dictionary').createReferenceLibrary();
Ti.API.info("This feature is only supported in iOS5 and above");
Ti.API.info("Check if we have the min OS version needed");
Ti.API.info("Is Supported? => " + referenceLibrary.isSupported());

//If you want you can define some callbacks
function termDialogBoxHasBeenClosed(){
	var onClose = Ti.UI.createAlertDialog({
		title:'Term Dialog Closed',
		message:"I'm a callback that you can use to tell when the Definition Dialog Box has been closed."
	}).show();				
};
function termDialogHadError(e){
	var onError = Ti.UI.createAlertDialog({
		title:'Error',
		message:"I'm a callback that you can use to tell when the an error happens in the lookup process. This error is due to: "  + e.error
	}).show();					
};


Ti.API.info("You can add an event to be called if there is an error");
referenceLibrary.addEventListener('errored', termDialogHadError);

Ti.API.info("You can add an event to be called when the definition dialog is closed");
referenceLibrary.addEventListener('closed', termDialogBoxHasBeenClosed);
			
var win  = Ti.UI.createWindow({backgroundColor:'#fff'});

var container = Ti.UI.createView({
	top:10,
	layout:'vertical'
});
win.add(container);

var supportedLabel = Ti.UI.createLabel({
	color:'#000',
	left:10,
	height:40,
	width:'auto',
	textAlign:'left',
	visible:false,
	font:{
		fontSize:20,
		fontWeight:'bold'
	}
});
container.add(supportedLabel);

var instructionsLabel = Ti.UI.createLabel({
	color:'#000',
	text:'Enter a term below:',
	left:10,
	height:40,
	width:'auto',
	textAlign:'left',
	font:{
		fontSize:16
	}
});
container.add(instructionsLabel);

var termText = Ti.UI.createTextField({
	color:'#336699',
	height:35,
	value:'Life',
	top:10,
	left:10,
	right:10,
	borderStyle:Titanium.UI.INPUT_BORDERSTYLE_ROUNDED,
	returnKeyType:Ti.UI.RETURNKEY_DONE
});

container.add(termText);

var hasDefinitionLabel = Ti.UI.createLabel({
	color:'#000',
	text:'Term has definition: Yes',
	left:10,
	height:40,
	width:'auto',
	textAlign:'left',
	visible:false,
	font:{
		fontSize:14
	}
});

container.add(hasDefinitionLabel);

var searchButton = Titanium.UI.createButton({
	title:'Find Term',
	height:40,
	width:200,
	top:20
});

container.add(searchButton);

searchButton.addEventListener('click', function(){
	//Close the text field so it gets out of our way
	termText.blur();
	//don't search if there isn't a value
	if(termText.value.length===0){
		var missingInfo = Ti.UI.createAlertDialog({
			title:'Missing Information',
			message:'Please enter a term to lookup'
		}).show();
		return;
	}
	
	Ti.API.info("This feature requires iOS5 or greater");
	Ti.API.info("You can call this mention to check");
	var featureSupported = referenceLibrary.isSupported();
	Ti.API.info("Is Supported? => " + featureSupported);
	//We now are going to update the example with the value
	supportedLabel.visible=true;
	supportedLabel.text="Feature available: " + ((featureSupported)? "Yes" : "No");
	
	//If the feature isn't supported update the example and notify the user
	if(!featureSupported){
		termText.enabled=false;
		showDialogButton.visible=false;
		hasDefinitionLabel.visible=false;
		
		var noSupport = Ti.UI.createAlertDialog({
			title:'Not Supported',
			message:'This feature requires iOS5 or greater'
		}).show();
			
		return;
	}
	
	Ti.API.info("Now that we've gotten all of the inputs managed, let's get to work");

	Ti.API.info("First we want to check if there is a definition for the term");
	var hasDefinition =  referenceLibrary.wordHasDefinition(termText.value);
	Ti.API.info("Term has definition =>" + hasDefinition);
	//Set the label to update the example
	hasDefinitionLabel.visible=true;
	hasDefinitionLabel.text="Term has definition: " + ((hasDefinition)? "Yes" : "No");
	
	Ti.API.info("No no definition if found, you might want to not display the dialog box");	
	
	var askMe = Ti.UI.createAlertDialog();
	
	//Ask the right question based on if there was a definition found
	if(hasDefinition){
		askMe.title='See Definition';
		askMe.message='Do you want to open the definition dialog for the term  ' + termText.value + '?';
		askMe.buttonNames=["No","Show Me"];
	}else{
		askMe.title='No Definition Found';
		askMe.message='No definition was found for your term ' + termText.value + '. Do you want to open the dialog anyway? It will say No definition found?';
		askMe.buttonNames=["No","Open Anyway"];
	
	}	
	askMe.show();
	askMe.addEventListener('click', function(e){
		//They want to see the definition dialog
		if(e.index===1){
						
			//Open the definition dialog window			
			referenceLibrary.showDialog({
					term:termText.value, //This is the term to search for (REQUIRED)
					animated:true, //Indicate if the dialog should be animated on open (OPTIONAL)
					modalTransitionStyle:Ti.UI.iPhone.MODAL_TRANSITION_STYLE_FLIP_HORIZONTAL //This is the transition style (OPTIONAL)
			});			
		}
	});
			
});

termText.addEventListener('return',function(e){
	termText.blur();
});

win.open();