//
//  ViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/06/27.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "ViewController.h"
#import "DMCrookedSwipeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    plusScore = 1;
    score = 0;
    scoreLabel.text = @"0";
    
    /*==丸つくる==*/
    [self makeLeftUpwordMaru];
    [self makeLeftDownwordMaru];
    [self makeRightUpwordMaru];
    [self makeRightDownwordMaru];
    
    /*--音--*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"powan" ofType:@"mp3"] ;
    NSURL *url = [NSURL fileURLWithPath:path] ;
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;
    
    /*--octagon--*/
//    randomOctagon = arc4random_uniform(2);
//    NSLog(@"randomOctagon is...%d",randomOctagon);
//    if (randomOctagon == 0 ) {
//        octagon.image = [UIImage imageNamed:@"Noctagon().png"];
//    }else if (randomOctagon == 1){
//        octagon.image = [UIImage imageNamed:@"Noctagon()2.png"];
//    }
    octagon.image = [UIImage imageNamed:@"Noctagon().png"];
    
    
    /*--最初の画面--*/
    firstView =[[UIImageView alloc] initWithFrame:CGRectMake (0,0,320,568)];
    firstView.image = [UIImage imageNamed:@"Noctagon_first.png"];
    [self.view addSubview:firstView];
    
    [self addTapToReturn];  //タップで消す
    
    
    // 通知の受け取り登録("TestPost"という通知名の通知を受け取る)
    // 通知を受け取ったら自身のreceive:メソッドを呼び出す
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(receive:) name:@"hoge" object:nil];

}

-(void)receive:(NSNotification *)center
{
    // 通知を受け取ったときの処理...
    position = [center.userInfo objectForKey:@"key"];
    NSLog(@"position::%@", position);
    
    [self add:self.view.frame];
}


//タップで消す
- (void)addTapToReturn {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doReturn:)];
    [self.view addGestureRecognizer:tap];
}

- (void)doReturn:(UITapGestureRecognizer *)tap {
    
    [firstView removeFromSuperview];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


//丸に色をつける
- (UIImage *)setColor
{
    int randomNumber = arc4random_uniform(4);
    NSLog(@"randmNumber is %d", randomNumber);
    
    switch (randomNumber) {
        case 0:
            return [UIImage imageNamed:@"NmarumaruBlue.png"];
            colorNum = 0;
            break;
        case 1:
            return [UIImage imageNamed:@"NmarumaruGreen.png"];
            colorNum = 1;
            break;
        case 2:
            return [UIImage imageNamed:@"NmarumaruPink.png"];
            colorNum = 2;
            break;
        case 3:
            return [UIImage imageNamed:@"NmarumaruYellow.png"];
            colorNum = 3;
            break;
        default:
            break;
    }
    return nil;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)add:(CGRect)rect{
    
    /*==丸つくる==*/
    if (position == 0) {
        NSLog(@"左上");
        [self makeLeftUpwordMaru];
        
    }else if(position == 1){
        NSLog(@"右上");
        [self makeRightUpwordMaru];
        
    }else if(position == 2){
        NSLog(@"左下");
        [self makeRightDownwordMaru];
        
    }else if(position == 3) {
        NSLog(@"左下");
        [self makeLeftDownwordMaru];
    }
}

/*----マーブル作る----*/
- (void)makeLeftUpwordMaru
{
    DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(110,190, MARBLE_WIDTH, MARBLE_HEIGHT)];
    marble.image= [self setColor];
    marble.userInteractionEnabled = YES; //タッチイベントを許可する
    [self.view addSubview:marble];
}

- (void)makeRightUpwordMaru
{
    DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(160,190, MARBLE_WIDTH, MARBLE_HEIGHT)];
    marble.image= [self setColor];
    marble.userInteractionEnabled = YES; //タッチイベントを許可する
    [self.view addSubview:marble];
}

- (void)makeLeftDownwordMaru
{
    DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(110,240, MARBLE_WIDTH, MARBLE_HEIGHT)];
    marble.image= [self setColor];
    marble.userInteractionEnabled = YES; //タッチイベントを許可する
    [self.view addSubview:marble];
}

- (void)makeRightDownwordMaru
{
    DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(160,240, MARBLE_WIDTH, MARBLE_HEIGHT)];
    marble.image= [self setColor];
    marble.userInteractionEnabled = YES; //タッチイベントを許可する
    [self.view addSubview:marble];}

@end
