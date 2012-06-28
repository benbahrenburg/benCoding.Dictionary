/**
 * benCoding.Dictionary Project
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "referenceLibraryWrapperViewController.h"
#import "TiApp.h"

@implementation referenceLibraryWrapperViewController
@synthesize delegate;

- (id)init
{
    return [super initWithNibName:@"referenceLibraryWrapperViewController" bundle:nil];
}


- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    return [self init];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    [delegate release];
    self.delegate=nil;    
}

#pragma mark - View lifecycle

-(void) foo
{
    
}
-(void) viewWillDisappear:(BOOL)animated
{
    [[self delegate] referenceViewClosed];
    [super viewWillDisappear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [delegate release];
    self.delegate=nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//
//        //Check if the orientation is supported in the Tiapp.xml settings
//    BOOL allowRotate = [[[TiApp app] controller] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
//        //If it is supported, we need to move the entire app. 
//        //Without doing this, our keyboard wont reposition itself
//    if(allowRotate==YES)
//    {
//        [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:NO];
//        
//    }
//    
//    //We tell the app if we can rotate, ie is this a support orientation
//    return allowRotate;        
//
//}
@end
