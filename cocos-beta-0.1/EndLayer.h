//
//  EndLayer.h
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-20.
//  Copyright 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MyDefine.h"
#import "HelloWorldLayer.h"

@interface EndLayer : CCLayer {
    int score;
}
+(CCScene *) scene;

-(void)setScore:(int)theScore;

//-(id)initWithScore:(int)theScore;

@end
