//
//  HelloWorldLayer.h
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-11.
//  Copyright 朱 俊健 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "TestLayer.h"
#import "TouchTest.h"
#define TAG_TOUCH 100
#define TAG_GRAVITY 200

#define STRING_CHOOSE_TOUCH @"触摸模式!"
#define STRING_CHOOSE_GRAVITY @"重力模式!"

#define CHOOSE_TOUCH 1
#define CHOOSE_GRAVITY 2
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    int choose;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


-(CGPoint)locationFromTouches:(NSSet *)touches;
@end
