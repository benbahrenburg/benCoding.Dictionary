/**
 * benCoding.Dictionary Project
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "BencodingDictionaryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation BencodingDictionaryModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
    bool marketPlace=NO;
    
    if(marketPlace)
    {
        return @"12604cea-a670-41eb-af77-cd5f0c103a0c";
    }
    else
    {
        return @"26ce098e-3857-4233-b38a-b667644db570";
    }
    
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"bencoding.dictionary";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

@end
