//
//  AppDelegate.h
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-11.
//  Copyright 朱 俊健 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@end
