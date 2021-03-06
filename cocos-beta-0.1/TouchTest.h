//
//  TouchTest.h
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-20.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyDefine.h"
#import "EndLayer.h"

@interface TouchTest : CCLayer {
    CGSize winSize;
    CGSize spiderSize;
    CGPoint playerVelocity;
    
    int scoreOfGame;
    int restTime;
}

+(CCScene *) scene;

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
-(void)update:(ccTime)delta;

-(void)initSpiders;
-(void)resetSpidersWithIndexof:(int)index;

-(void)spiderUpdate:(ccTime)delta;
-(void)timeUpdate:(ccTime)delta;


-(int)theCrashedSpider;
-(void)overSpiderWithTag:(int)spiderTag;

-(void)initAnimations;
-(void)callAnimationWithIndexOf:(int)index;
-(void)testAnimation;
-(void)scaleSpiderUpdate:(ccTime)delta WithTag:(int)tag;

-(CGPoint)locationFromTouches:(NSSet *)touches;
@end
