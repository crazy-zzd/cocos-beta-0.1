//
//  TestLayer.m
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-11.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "TestLayer.h"


@implementation TestLayer

+(CCScene *)scene{
    CCScene * scene=[CCScene node];
    TestLayer * layer=[TestLayer node];
    [scene addChild:layer];
    
    return scene;
    
}


-(id)init{
    if ((self=[super init])) {
        winSize = [[CCDirector sharedDirector] winSize];
        
        //player sprite's init
        CCSprite * player = [CCSprite spriteWithFile:PNG_PLAYER];
        player.position = ccp(winSize.width/2, winSize.height/3);
        [self addChild:player z:Z_PLAYER tag:TAG_PLAYER];

        spiderSize = player.texture.contentSize;

        //background's init
        CCLabelTTF * background = [CCLabelTTF labelWithString:BG_STRING fontName:BG_FONT fontSize:BG_FONTSIZE];
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:background];

        //score's init
        scoreOfGame = 0;
        NSString * strScore = [NSString stringWithFormat:@"%d",scoreOfGame];
        CCLabelTTF * score = [CCLabelTTF labelWithString:strScore fontName:SCORE_FONT fontSize:SCORE_FONTSIZE];
        score.position = ccp(winSize.width/4, winSize.height * 3.0f / 4.0f);
        [self addChild:score z:Z_SCORE tag:TAG_SCORE];
        
        restTime = TIME_COUNTDOWN;
        NSString * strTime = [NSString stringWithFormat:@"%d",restTime];
        CCLabelTTF * time = [CCLabelTTF labelWithString:strTime fontName:SCORE_FONT fontSize:SCORE_FONTSIZE];
        time.position = ccp(winSize.width*3/4, winSize.height*3/4);
        [self addChild:time z:Z_TIME tag:TAG_TIME];
        //animation's init
//        CCSprite * animation = [CCSprite spriteWithFile:PNG_SPIDER];
//        animation.visible = NO;
//        [self addChild:animation z:Z_ANIMATION tag:TAG_ANIMATION];
        
        //enable accelerometer
        [self setAccelerometerEnabled:YES];
        
        //init spiders
        [self initSpiders];

        //init animations
        [self initAnimations];
        
        //let the player move
        [self scheduleUpdate];

        [self schedule:@selector(spiderUpdate:) interval:TIME_INTERVAL];
        
        [self schedule:@selector(timeUpdate:) interval:1];
    }
    return self;
}

//其中，acceleration是加速值
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    float deceleration=PLAYER_SPEED_DECELERATION;
    float sensitivity=PLAYER_SPEED_SENSITIVITY;
    float maxVelocity=PLAYER_SPEED_MAXVELOCITY;

    playerVelocity.x = playerVelocity.x * deceleration + acceleration.x * sensitivity;
    
    if (playerVelocity.x > maxVelocity) {
        playerVelocity.x = maxVelocity;
    }
    else if (playerVelocity.x < - maxVelocity){
        playerVelocity.x = -maxVelocity;
    }
    
    
    playerVelocity.y = playerVelocity.y * deceleration + acceleration.y * sensitivity;
    
    if (playerVelocity.y > maxVelocity) {
        playerVelocity.y = maxVelocity;
    }
    else if (playerVelocity.y < - maxVelocity){
        playerVelocity.y = -maxVelocity;
    }
//    CCSprite * spr = (CCSprite *)[self getChildByTag:1];
//    CGPoint pos = spr.position;
//    pos.x = pos.x + acceleration.x * 10;
//    pos.y = pos.y + acceleration.y * 10;
//    spr.position = pos;
}

-(void)update:(ccTime)delta{
    CCSprite * player = (CCSprite *)[self getChildByTag:TAG_PLAYER];
    CGPoint pos = player.position;
    pos.x = pos.x + playerVelocity.x;
    pos.y = pos.y + playerVelocity.y;
    
//    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float imageWidthHalved = player.texture.contentSize.width *0.5;
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = winSize.width - imageWidthHalved;
    float topLimit = winSize.height - imageWidthHalved;
    float bottomLimit = imageWidthHalved;
    
    if (pos.x < leftBorderLimit) {
        pos.x = leftBorderLimit;
//        playerVelocity = CGPointZero;
    }
    else if(pos.x > rightBorderLimit){
        pos.x = rightBorderLimit;
//        playerVelocity = CGPointZero;
    }

    
    if (pos.y < bottomLimit) {
        pos.y = bottomLimit;
//        playerVelocity = CGPointZero;
    }
    else if(pos.y > topLimit){
        pos.y = topLimit;
//        playerVelocity = CGPointZero;
    }
    
    player.position = pos;

    
    //碰撞检测
    if ([self theCrashedSpider] > 0) {
        [self overSpiderWithTag:[self theCrashedSpider]];
        scoreOfGame ++;
        CCLabelTTF * score = (CCLabelTTF *)[self getChildByTag:TAG_SCORE];
        score.string = [NSString stringWithFormat:@"%d",scoreOfGame];
    }
    
    [self testAnimation];
//    [self schedule:@selector(spiderUpdate:) interval:TIME_INTERVAL];

    if (restTime == 0) {
//        exit(0);
        CCScene * scene = [CCScene node];
        EndLayer * layer = [EndLayer node];
        [layer setScore:scoreOfGame];
        [scene addChild:layer];
        [[CCDirector sharedDirector] replaceScene:scene];
    }
}

-(void)initSpiders{
    for (int i = 0; i < NUM_SPIDER_NOW; i++) {
        CCSprite * spider = [CCSprite spriteWithFile:PNG_SPIDER];
        [self addChild:spider z:Z_SPIDER tag:TAG_SPIDER + i];
    }
//        [self resetSpiders];
    for (int i = 0; i < NUM_SPIDER_NOW; i++) {
        [self resetSpidersWithIndexof:i];
    }
}

-(void)initAnimations{
    for (int i = 0; i < NUM_SPIDER_NOW; i++) {
        CCSprite * animation = [CCSprite spriteWithFile:PNG_SPIDER];
        animation.visible = NO;
        [self addChild:animation z:Z_ANIMATION tag:TAG_ANIMATION + i];
    }
}

-(void)resetSpidersWithIndexof:(int)index{
//    CCSprite * tempSpider = (CCSprite *)[self getChildByTag:TAG_SPIDER];
//    CGSize size = tempSpider.texture.contentSize;
    
//    for(int i = 0; i < NUM_SPIDER_NOW; i++){
//        CCSprite * spider = (CCSprite *)[self getChildByTag:TAG_SPIDER + i];
//        spider.position = ccp(CCRANDOM_0_1() * (winSize.width - size.width) + size.width * FLOAT_HALF, winSize.height + size.height * FLOAT_HALF);
//
//        [spider stopAllActions];
//    }
    CCSprite * spider = (CCSprite *)[self getChildByTag:TAG_SPIDER + index];
    spider.position = ccp(CCRANDOM_0_1() * (winSize.width - spiderSize.width) + spiderSize.width * FLOAT_HALF, winSize.height + spiderSize.height * FLOAT_HALF);
    [spider cleanup];
    


}

-(void)spiderUpdate:(ccTime)delta{
//    CCSprite * tempSpider = (CCSprite *)[self getChildByTag:TAG_SPIDER];
//    CGSize size = tempSpider.texture.contentSize;
    CCSprite * spider;
    int i = 0;
    
    for (i = 0; i < NUM_SPIDER_NOW; i++) {
        spider = (CCSprite *)[self getChildByTag:TAG_SPIDER + i];
        if (spider.numberOfRunningActions == 0) {
            [self resetSpidersWithIndexof:i];
            CCMoveBy * moveBy = [CCMoveBy actionWithDuration:TIME_MOVEDOWN position:ccp(0, -winSize.height - spiderSize.height )];
            [spider runAction:moveBy];
            break;
        }
//        if (spider.position.y >= winSize.height - spiderSize.height * FLOAT_HALF) {
//            CCMoveBy * moveBy = [CCMoveBy actionWithDuration:TIME_MOVEDOWN position:ccp(0, -winSize.height - spiderSize.height )];
//            [spider runAction:moveBy];
//            break;
//        }
    }
    
//    for (i = 0; i < NUM_SPIDER_NOW; i++) {
//        spider = (CCSprite *)[self getChildByTag:TAG_SPIDER+i];
//        if (spider.position.y <= 0 - spiderSize.height/2) {
//            [self resetSpidersWithIndexof:i];
////            break;
//        }
//    }
    
    
//    
//    if (i == NUM_SPIDER_NOW) {
//        [self unschedule:_cmd];
//    }
}

-(int)theCrashedSpider{
    for (int i = 0; i < NUM_SPIDER_NOW; i ++) {
        CCSprite * spider = (CCSprite *)[self getChildByTag:TAG_SPIDER + i];
        CCSprite * player = (CCSprite *)[self getChildByTag:TAG_PLAYER];
        float distance = 0;
        if (spider.numberOfRunningActions != 0) {
            distance = ccpDistance(spider.position, player.position);
            if (distance < spiderSize.height) {
                return (TAG_SPIDER + i);
            }
        }
    }
    return -1;
}

-(void)overSpiderWithTag:(int)spiderTag{
    CCSprite * spider = (CCSprite *)[self getChildByTag:spiderTag];
//    [spider setVisible:NO];
//    spider.position = ccp(spider.position.x, 0 - spiderSize.height);
    [spider cleanup];
    
    
//    CCScaleTo * scale = [CCScaleTo actionWithDuration:0.5 scale:0.1];
//    [self schedule:@selector(scaleSpiderUpdate:WithTag:) interval:0.1];
//    [spider runAction:scale];
    
    [self callAnimationWithIndexOf:spiderTag - TAG_SPIDER];
    
    [self resetSpidersWithIndexof:spiderTag - TAG_SPIDER];
//    [self delete:spider];
//    NSLog(@"%d",[spider numberOfRunningActions]);
//    spider.position.y = 0 - spiderSize.height;
    
}


-(void)callAnimationWithIndexOf:(int)index{
    CCSprite * animation = (CCSprite *)[self getChildByTag:TAG_ANIMATION + index];
    CCSprite * spider = (CCSprite *)[self getChildByTag:TAG_SPIDER + index];
    animation.position = spider.position;
    animation.scale = 1.0f;
    CCScaleTo * scaleTo = [CCScaleTo actionWithDuration:0.2 scale:0.1];
    [animation runAction:scaleTo];
    animation.visible = YES;
}


-(void)scaleSpiderUpdate:(ccTime)delta WithTag:(int)tag{
    CCSprite * spider = (CCSprite *)[self getChildByTag:tag];
    spider.scale -= 0.1;
    if (spider.scale <= 0.1) {
        [self resetSpidersWithIndexof:tag - TAG_SPIDER];
        [self unschedule:_cmd];
    }
}

-(void)testAnimation{
    for (int i = 0; i < NUM_SPIDER_NOW; i++) {
        CCSprite * animation = (CCSprite *)[self getChildByTag:TAG_ANIMATION + i];
        if ([animation numberOfRunningActions] == 0) {
            animation.visible = NO;
        }
    }
}

-(void)timeUpdate:(ccTime)delta{
    CCLabelTTF * time = (CCLabelTTF *)[self getChildByTag:TAG_TIME];
    restTime --;
    time.string = [NSString stringWithFormat:@"%d",restTime];
}
@end
