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
    randomOctagon = arc4random_uniform(2);
    NSLog(@"randomOctagon is...%d",randomOctagon);
    if (randomOctagon == 0 ) {
        octagon.image = [UIImage imageNamed:@"octagon().png"];
    }else if (randomOctagon == 1){
        octagon.image = [UIImage imageNamed:@"octagon()2.png"];
    }
    
    
    /*--最初の画面--*/
    firstView =[[UIImageView alloc] initWithFrame:CGRectMake (0,0,320,568)];
    firstView.image = [UIImage imageNamed:@"octagon_first.png"];
    [self.view addSubview:firstView];
    
    [self addTapToReturn];  //タップで消す
    
    NSNotificationCenter *nc =
    [NSNotificationCenter defaultCenter];
    
    // 通知の受け取り登録("TestPost"という通知名の通知を受け取る)
    // 通知を受け取ったら自身のreceive:メソッドを呼び出す
    [nc addObserver:self
           selector:@selector(receive:)
               name:@"TestPost"
             object:nil];
}

- (void)receive:(NSNotification *)center
{
    // 通知を受け取ったときの処理...
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


- (UIImage *)setColor
{
    int randomNumber = arc4random_uniform(4);
    NSLog(@"randmNumber is %d", randomNumber);
    
    switch (randomNumber) {
        case 0:
            return [UIImage imageNamed:@"marumaruBlue.png"];
            colorNum = 0;
            break;
        case 1:
            return [UIImage imageNamed:@"marumaruGreen.png"];
            colorNum = 1;
            break;
        case 2:
            return [UIImage imageNamed:@"marumaruPink.png"];
            colorNum = 2;
            break;
        case 3:
            return [UIImage imageNamed:@"marumaruYellow.png"];
            colorNum = 3;
            break;
        default:
            break;
    }
    return nil;
    
    
}


#pragma mark - Gesture

- (void)swipeUpward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"右上");
    [audio play] ; //音をならす

}

- (void)swipeDownward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左下");
    [audio play] ; //音をならす

}

- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左上");
    [audio play] ; //音をならす    
    
}


- (void)swipeRight:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"右下");
    [audio play] ; //音をならす
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)add:(CGRect)rect{
    
    NSLog(@"動かされたmarbleの座標は%@です", NSStringFromCGRect(rect));
    
    /*==丸つくる==*/
    if (rect.origin.x < 100 && rect.origin.y <180) {
        //左上
        NSLog(@"左上");
        [self makeLeftUpwordMaru];
    }else if(rect.origin.x > 145 && rect.origin.y <180){
        //右上
        NSLog(@"右上");
        [self makeRightUpwordMaru];
    }else if(rect.origin.x > 145 && rect.origin.y >225){
        //右下
        NSLog(@"左下");
        [self makeRightDownwordMaru];
    }else if(rect.origin.x < 100 && rect.origin.y >225) {
        //左下
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
