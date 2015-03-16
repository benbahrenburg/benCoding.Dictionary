/**
 * benCoding.Dictionary Project
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import <UIKit/UIKit.h>

@protocol referenceLibraryWrapperViewControllerDelegate <NSObject>
@required
- (void) referenceViewClosed;
@end

@interface referenceLibraryWrapperViewController : UIReferenceLibraryViewController
{
    id <referenceLibraryWrapperViewControllerDelegate> delegate;
}

@property (retain) id delegate;

@end
