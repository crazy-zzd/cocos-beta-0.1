//
//  EndLayer.m
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-20.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import "EndLayer.h"


@implementation EndLayer

+(CCScene *)scene{
    CCScene * scene=[CCScene node];
    EndLayer * layer=[EndLayer node];
    [scene addChild:layer];
    
//    score=theScore;
    
    return scene;
}

//-(id)initWithScore:(int)theScore{
//    score = theScore;
//    return [self init];
//}

-(id)init{
    if ((self=[super init])) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
//        NSString * strScore = [NSString stringWithFormat:@"你的得分：%d",score];
//        CCLabelTTF * labelScore = [CCLabelTTF labelWithString:strScore fontName:SCORE_FONT fontSize:SCORE_FONTSIZE];
//        labelScore.position = ccp(winSize.width/2, winSize.height*3/4);
//        [self addChild:labelScore z:Z_TIME tag:TAG_TIME];
//        
//        CCLabelTTF * strEnd = [CCLabelTTF labelWithString:@"重新开始" fontName:BG_FONT fontSize:BG_FONTSIZE];
//        strEnd.position = ccp(winSize.width/2, winSize.height/2);
//        [self addChild:strEnd];
        //
        CCMenuItemFont * menuFont = [CCMenuItemFont itemWithString:@"重新开始" block:^(id sender){
            CCScene * scene = [CCScene node];
            HelloWorldLayer * layer = [HelloWorldLayer node];
            [scene addChild:layer];
            [[CCDirector sharedDirector] replaceScene:scene];
        }];
        menuFont.fontName = BG_FONT;
        menuFont.fontSize = BG_FONTSIZE;
        
        CCMenu * menu = [CCMenu menuWithItems:menuFont, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:menu];
    }
    return self;
}

-(void)setScore:(int)theScore{
    score = theScore;
//    [self init];
    CGSize winSize = [[CCDirector sharedDirector] winSize];    
    NSString * strScore = [NSString stringWithFormat:@"你的得分：%d",score];
    CCLabelTTF * labelScore = [CCLabelTTF labelWithString:strScore fontName:SCORE_FONT fontSize:SCORE_FONTSIZE];
    labelScore.position = ccp(winSize.width/2, winSize.height*3/4);
    [self addChild:labelScore z:Z_TIME tag:TAG_TIME];

    
}

@end
