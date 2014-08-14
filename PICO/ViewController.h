//
//  ViewController.h
//  PICO
//
//  Created by 山本文子 on 2014/06/27.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DMCrookedSwipeView.h"
#define MARBLE_WIDTH 50
#define MARBLE_HEIGHT 50

@interface ViewController : UIViewController <DMCrookedSwipeViewDelegate> {
    //代わりにできるマンだよ
    UIImage *maruView; //丸につける画像
    
    IBOutlet UIImageView *octagon;
    
    
    int colorNum;  //色に番号つけといて、すみからーと合わせる

    
    int torf; //すみと丸が合ってたら１、間違ってたら０
    
    AVAudioPlayer *tirin;
    AVAudioPlayer *don;
    AVAudioPlayer *dodon;
    AVAudioPlayer *pon;
    AVAudioPlayer *kan;
    
    /*---SCORE---*/
    IBOutlet UILabel *scoreLabel;
    int score;        //スコア
    int plusScore;    //連続で成功したときプラスするスコア
    
    
    UIImageView *firstView;  //最初の画面
    
    
    NSNumber *position;  //position
    int *intposition;
    
    float time;
    NSTimer *gameoverTimer;
    float countDown;
    
    BOOL firstTapFlag;
    
    UIImageView *gameoverView;
    
    BOOL isGameOver;  //gameoverしたら丸をたさないようにする
    BOOL isOk;  //あってたらYES
    UIButton *optionButton;
    
    IBOutlet UILabel *gameTimerLabel;
}
//- (IBAction)option;

-(void)add:(CGRect)rect;

- (void) hanteiWithMarble:(DMCrookedSwipeView *)marbleForhantei; //わしこれできるよ


@end
