//
//  GameOverViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/08/13.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>


/*game center*/
#import <GameKit/GameKit.h>   
@interface HogeViewController : UIViewController<GKGameCenterControllerDelegate>
@end


@interface GameOverViewController : UIViewController{
    IBOutlet UILabel *gameScoreLabel;
    int score;
    int level;
    
    AVAudioPlayer *pon;
    AVAudioPlayer *flee;
    AVAudioPlayer *gooon;

    BOOL isSound;
}


-(IBAction)backToStart ;

- (IBAction)twitter ;

@property(nonatomic) int score;
@property(nonatomic) int level;

@end