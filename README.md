<h1>benCoding.Dictionary Module</h1>

Use the native iOS dictionary service within your Titanium application.  This module provides Titanium accessibility to Apple's native [UIReferenceLibraryViewController](http://developer.apple.com/library/ios/#documentation/uikit/reference/UIReferenceLibraryViewControllerClassRef/Reference/Reference.html) introduced in iOS5.


<h2>Before you start</h2>
* You need Titanium 1.8.1 or greater.
* This module will only work with iOS 5 or great.  

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the bencoding.dictionary module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<pre><code>

var referenceLibrary = require('bencoding.dictionary').createReferenceLibrary();

</code></pre>

Now we have the module installed and avoid in our project we can start to use the components, see the feature guide below for details.

<h2>benCoding.Dictionary How To Example</h2>

For detailed documentation please reference this project's documentation folder.
A code "How To" example is provided in the app.js located in the project's example folder.

<h2>Methods</h2>
<hr />

This module provides access to most of the native UIReferenceLibraryViewController's functionality.

Below is a description and example on how to use each supported method.
<h3>isSupported</h3>
This method returns a boolean indicator on whether or Apple's dictionary services are supported. Please note you need to target iOS 5 or greater to use the native UIReferenceLibraryViewController component.

The below sample shows how you can check if this feature is supported.
<pre><code>

Ti.API.info("This feature is only supported in iOS5 and above");
Ti.API.info("Check if we have the min OS version needed");
var featureSupported = referenceLibrary.isSupported();
Ti.API.info("Is Supported? => " + featureSupported);

</code></pre>

<h3>wordHasDefinition</h3>
This method returns a boolean indicator on whether or not the Apple Dictionary service was able to find the provided definition.

It is recommended that you use this method to first check if there is a definition available before opening a dialog for the definition.

The below sample shows how you can check if there is a definition available for your term.
<pre><code>

Ti.API.info("Does Apple know the meeting of life?");
var hasDefinition =  referenceLibrary.wordHasDefinition('life');
Ti.API.info("Definition found? => " + hasDefinition);

</code></pre>

<h3>showDialog</h3>
The showDialog method opens a modal dialog with the definition of the term provided.  If the dictionary service is unable to find the definition the words "No definition found." will be displayed.

* Callback methods are supported for the the "Error" and "On Close of Dialog" events.
* The Dictionary module also supports the animated and modalTransitionStyle properties.

The below same shows how to use the showDialog method. For additional details please see the example and documentation folders within this project.
<pre><code>

	//If you want you can define some callbacks
	function termDialogBoxHasBeenClosed(){
		Ti.API.info("I'm a callback that you can use to tell when the Definition Dialog Box has been closed.");			
	};
	function termDialogHadError(e){
		Ti.API.info("I'm a callback that you can use to tell when the an error happens in the lookup process. This error is due to: "  + e.error);				
	};
			
	Ti.API.info("Add an event to be called if there is an error");
	referenceLibrary.addEventListener('errored', termDialogHadError);

	Ti.API.info("Add an event to be called when the definition dialog is closed");
	referenceLibrary.addEventListener('closed', termDialogBoxHasBeenClosed);
			
	//Open the definition dialog window			
	referenceLibrary.showDialog({
			term:'Life', //This is the term to search for (REQUIRED)
			animated:true, //Indicate if the dialog should be animated on open (OPTIONAL)
			modalTransitionStyle:Ti.UI.iPhone.MODAL_TRANSITION_STYLE_FLIP_HORIZONTAL //This is the transition style (OPTIONAL)
	});	

</code></pre>

<h2>Demo Video</h2>

See the included sample app in action [http://youtu.be/3ruH3eI-AU4](http://youtu.be/3ruH3eI-AU4).

<h2>Licensing & Support</h2>

This project is licensed under the OSI approved Apache Public License (version 2). For details please see the license associated with each project.

Developed by [Ben Bahrenburg](http://bahrenburgs.com) available on twitter [@benCoding](http://twitter.com/benCoding)

<h2>Learn More</h2>
<hr />
<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com). 
