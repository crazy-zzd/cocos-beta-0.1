//
//  HelloWorldLayer.m
//  cocos-beta-0.1
//
//  Created by 朱 俊健 on 13-9-11.
//  Copyright 朱 俊健 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        
        CCLabelTTF * label1 = [CCLabelTTF labelWithString:STRING_CHOOSE_GRAVITY fontName:@"Marker Felt" fontSize:64];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        label1.position = ccp(winSize.width/2, winSize.height*3/4);
        
        CCLabelTTF * label2 = [CCLabelTTF labelWithString:STRING_CHOOSE_TOUCH fontName:@"Marker Felt" fontSize:64];
        label2.position = ccp(winSize.width/2, winSize.height/4);
        
        [self addChild:label1 z:1 tag:TAG_GRAVITY];
        [self addChild:label2 z:1 tag:TAG_TOUCH];

        
//        self.isTouchEnabled = YES;
        [self setTouchEnabled:YES];
        
//		// create and initialize a Label
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
//
//		// ask director for the window size
//		CGSize size = [[CCDirector sharedDirector] winSize];
//	
//		// position the label on the center of the screen
//		label.position =  ccp( size.width /2 , size.height/2 );
//		
//		// add the label as a child to this Layer
//		[self addChild: label];
//		
//		
//		
//		//
//		// Leaderboards and Achievements
//		//
//		
//		// Default font size will be 28 points.
//		[CCMenuItemFont setFontSize:28];
//		
//		// to avoid a retain-cycle with the menuitem and blocks
//		__block id copy_self = self;
//		
//		// Achievement Menu Item using blocks
//		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
//			
//			
//			GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
//			achivementViewController.achievementDelegate = copy_self;
//			
//			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//			
//			[[app navController] presentModalViewController:achivementViewController animated:YES];
//			
//		}];
//		
//		// Leaderboard Menu Item using blocks
//		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
//			
//			
//			GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
//			leaderboardViewController.leaderboardDelegate = copy_self;
//			
//			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
//			
//			[[app navController] presentModalViewController:leaderboardViewController animated:YES];
//			
//		}];
//
//		
//		CCMenu *menu = [CCMenu menuWithItems:itemAchievement, itemLeaderboard, nil];
//		
//		[menu alignItemsHorizontallyWithPadding:20];
//		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
//		
//		// Add the menu to the layer
//		[self addChild:menu];
//
	}
	return self;
}

// on "dealloc" you need to release all your retained objects

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) onEnter
{
	[super onEnter];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLabelTTF * labelTouch = (CCLabelTTF *)[self getChildByTag:TAG_TOUCH];
    CCLabelTTF * labelGravity = (CCLabelTTF *)[self getChildByTag:TAG_GRAVITY];
    CCScaleTo * scale = [CCScaleTo actionWithDuration:0.2 scale:0.8];
    if (CGRectContainsPoint(labelTouch.boundingBox, [self locationFromTouches:touches])) {
        [labelTouch runAction:scale];
        choose = CHOOSE_TOUCH;
    }
    if (CGRectContainsPoint(labelGravity.boundingBox, [self locationFromTouches:touches])) {
        [labelGravity runAction:scale];
        choose = CHOOSE_GRAVITY;
    }
}

-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLabelTTF * labelTouch = (CCLabelTTF *)[self getChildByTag:TAG_TOUCH];
    CCLabelTTF * labelGravity = (CCLabelTTF *)[self getChildByTag:TAG_GRAVITY];
    labelTouch.scale = 1;
    labelGravity.scale = 1;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLabelTTF * labelTouch = (CCLabelTTF *)[self getChildByTag:TAG_TOUCH];
    CCLabelTTF * labelGravity = (CCLabelTTF *)[self getChildByTag:TAG_GRAVITY];
    labelTouch.scale = 1;
    labelGravity.scale = 1;
    
    if (CGRectContainsPoint(labelTouch.boundingBox, [self locationFromTouches:touches])) {
        if (choose == CHOOSE_TOUCH) {
            CCScene * scene = [TouchTest scene];
            CCTransitionScene * tran = [CCTransitionFade transitionWithDuration:1 scene:scene];
            [[CCDirector sharedDirector] pushScene:tran];
        }
    }
    if (CGRectContainsPoint(labelGravity.boundingBox, [self locationFromTouches:touches])) {
        if (choose == CHOOSE_GRAVITY) {
            CCScene * scene = [TestLayer scene];
            CCTransitionScene * tran = [CCTransitionFade transitionWithDuration:1 scene:scene];
            [[CCDirector sharedDirector] pushScene:tran];
        }
    }
    


}


-(CGPoint)locationFromTouches:(NSSet *)touches{
    UITouch * touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:touch.view];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
@end
