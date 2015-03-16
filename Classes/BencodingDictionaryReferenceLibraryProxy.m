/**
 * benCoding.Dictionary Project
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingDictionaryReferenceLibraryProxy.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "TiUIiPhoneProxy.h"
#import "referenceLibraryWrapperViewController.h"
BOOL _allowRotate = NO;


@implementation referenceLibraryWrapperViewController (AutoRotation)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(_allowRotate==NO)
    {
        return NO;
    }
    else
    {
        //Check if the orientation is supported in the Tiapp.xml settings
        BOOL allowRotate = [[[TiApp app] controller] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
        //If it is supported, we need to move the entire app. 
        //Without doing this, our keyboard wont reposition itself
        if(allowRotate==YES)
        {
            [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:NO];
        }
        //We tell the app if we can rotate, ie is this a support orientation
        return allowRotate;        
    }
}

@end

@implementation BencodingDictionaryReferenceLibraryProxy
-(id)init
{
    if (self = [super init])
    {
	
        // This is the designated initializer method and will always be called
        // when the proxy is created.
        hasMinOSVersion=NO;

        //Check that the controller exists, this is available starting in iOS5
        if(NSClassFromString(@"UIReferenceLibraryViewController"))
        {
            hasMinOSVersion=YES;
        }
        //NSLog(@"[ReferenceLibrary] isSupported %d", hasMinOSVersion);
    }
    
    return self;
}

-(NSNumber*)isSupported:(id)args
{
    //This can call this to let them know if this feature is supported
    return NUMBOOL(hasMinOSVersion);
}


-(NSNumber*)wordHasDefinition:(id)args
{
    if(hasMinOSVersion==NO)
    {
        //If you don't have the min version we just send back false
        return NUMBOOL(NO);
    }
    else
    {
        enum Args {
            kTerm = 0,
            kArgCount
        };
        ENSURE_ARG_COUNT(args, kArgCount);
        //Pull the term out of the arguments passed in
        NSString *term = [TiUtils stringValue:[args objectAtIndex:kTerm]];
        //Uncomment to made debugging easier
        //NSLog(@"[ReferenceLibrary] term provided  %d", term);
        //Return the status
        return NUMBOOL([UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:term]);
    }
}

-(void) showDialog:(id)args
{    
        
    // Make sure this is done before the ensure macro to avoid issues
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    //Make sure we're on the UI thread, this stops bad things
    ENSURE_UI_THREAD(showDialog, args);
    
    //Check that we can run this feature
    if(hasMinOSVersion==NO)
    {
        //Create the error callback
        if ([self _hasListeners:@"errored"]) {
            NSDictionary *errorEvent = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"iOS 5 or greater is required for this feature",@"error",
                                   nil
                                   ];
            
            [self fireEvent:@"errored" withObject:errorEvent];
        }
        
    }
    else
    {                
        
        //Get the term the user entered
        NSString *term = [TiUtils stringValue:[args objectForKey:@"term"]];
        
        //Get the user's animated option
        BOOL showAnimated = [TiUtils boolValue:@"animated" properties:args def:NO];
        
        _allowRotate = [TiUtils boolValue:[self valueForUndefinedKey:@"allowRotate"]def:NO];
        
        //Create the UIReferenceController
        //We had to put a wrapper around this so, that is all this controller really is
        referenceLibraryWrapperViewController *reference = 
        [[referenceLibraryWrapperViewController alloc] initWithTerm:term];
       
        //Add transition style if defined
        int style = [TiUtils intValue:@"modalTransitionStyle" properties:args def:-1];
        
        //If no style provided, we skip this
        if (style!=-1)
        {
            //We apply the style
            [reference setModalTransitionStyle:style];
        }            

        //If we have a closed listener set a delegate so we know when to fire
        if ([self _hasListeners:@"closed"]) 
        {
            //Set the delegate on the controller wrapper to the local delegate method
            [reference setDelegate:self];
        }    
        
        //We call into core TiApp module this handles the controller magic for us
        [[TiApp app] showModalController:reference animated:showAnimated];
        
    }
    
}


- (void)referenceViewClosed;
{
    //If we have a callback to listen when the UIReferenceLibraryViewController dialog closes
    if ([self _hasListeners:@"closed"]) {
        NSDictionary *errorEvent = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"closed",@"status",
                                    nil
                                    ];
        
        [self fireEvent:@"closed" withObject:errorEvent];
    }    
}

@end
