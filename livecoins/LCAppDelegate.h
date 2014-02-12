//
//  LCAppDelegate.h
//  livecoins
//
//  Created by Seth Porter on 2/11/14.
//  Copyright (c) 2014 falcora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  LCHUDViewController;

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>
{
    LCHUDViewController* _hudViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
