//
//  GameOverViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/08/13.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface GameOverViewController : UIViewController{
    IBOutlet UILabel *gameScoreLabel;
    int score;
}

-(IBAction)backToStart ;

- (IBAction)twitter ;

@property(nonatomic ) int score;

@end
