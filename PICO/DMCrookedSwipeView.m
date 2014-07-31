//
//  DMCrookedSwipeView.m
//  DMCrookedSwiper
//
//  Created by Master on 2014/06/15.
//  Copyright (c) 2014年 jp.co.mappy. All rights reserved.
//

#import "DMCrookedSwipeView.h"

@implementation DMCrookedSwipeView

@synthesize torf;

@synthesize colorNum;
@synthesize randomOctagon;

@synthesize score;
@synthesize pScore;
@synthesize plusScore;
@synthesize perfectScore;

 
#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /* -- ビューの作成 -- */
        [self makeView];
    }
    return self;
}

#pragma mark - GestureView

- (void)makeView
{
    //動く速度
    moveX = 5;
    moveY = 5;
    
    /* 時計回りに45度回転 */
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/4);
    [self setTransform:transform];
    
    /* 左上スワイプ */
    UISwipeGestureRecognizer *swipeLeftGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeftGesture];
    
    /* 右上スワイプ */
    UISwipeGestureRecognizer *swipeUpwardGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpward:)];
    swipeUpwardGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUpwardGesture];
    
    /* 左下スワイプ */
    UISwipeGestureRecognizer *swipeDownwardGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownward:)];
    swipeDownwardGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDownwardGesture];
    
    
    /* 右下スワイプ */
    UISwipeGestureRecognizer *swipeRightGesture =
    [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRightGesture];
}

#pragma mark - Gesture

- (void)swipeUpward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"右上");
    if (randomOctagon == 0) {
        sumiColor = 3;
    }else if (randomOctagon == 1){
        sumiColor = 0;
    }

    if(sumiColor == colorNum){
        torf = 1;
    }else{
        torf = 0;
    }
    

    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 1;
 
    
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 通知の実行(通知名は"TestPost")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    [nc postNotificationName:@"TestPost"
                      object:self
                    userInfo:nil];
}

- (void)swipeRight:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"右下");
    if (randomOctagon == 0) {
        sumiColor = 2;
    }else if (randomOctagon == 1){
        sumiColor = 1;
    }
    
    if(sumiColor == colorNum){
        torf = 1;
    }else{
        torf = 0;
    }

    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 2;
    
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // 通知の実行(通知名は"TestPost")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    [nc postNotificationName:@"TestPost"
                      object:self
                    userInfo:nil];
    
}

- (void)swipeDownward:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左下");
    if (randomOctagon == 0) {
        sumiColor = 0;
    }else if (randomOctagon == 1){
        sumiColor = 3;
    }
    
    if(sumiColor == colorNum){
        torf = 1;
    }else{
        torf = 0;
    }

    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:)
                                                    userInfo:dic repeats:YES];
    //0.01秒間隔で  //呼び出すよself  //「:」自分自身渡す  //moveMarblesっていうメソッドを呼び出してる
    [timer fire];
    
    sender.view.tag = 3;

    
    
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // 通知の実行(通知名は"TestPost")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    [nc postNotificationName:@"TestPost"
                      object:self
                    userInfo:nil];
    
}


- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"左上");
    if (randomOctagon == 0) {
        sumiColor = 1;
    }else if (randomOctagon == 1){
        sumiColor = 2;
    }
    
    if(sumiColor == colorNum){
        torf = 1;
    }else{
        torf = 0;
    }
    

    NSDictionary *dic = [NSDictionary dictionaryWithObject:sender.view forKey:@"view"];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveMarbles:) userInfo:dic repeats:YES];
    [timer fire];
    
    sender.view.tag = 4;
    
    
    
    // デフォルトの通知センターを取得する
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // 通知の実行(通知名は"TestPost")
    // 通知先にデータを渡す場合はuserInfoにデータを指定
    [nc postNotificationName:@"TestPost"
                      object:self
                    userInfo:nil];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    /* ジェスチャーの同時認識を可能に */
    return YES;
}



- (void)moveMarbles:(NSTimer *)timer
{
    NSDictionary *dic = [timer userInfo];
    
    UIImageView *swipedView = [dic objectForKey:@"view"];
    
    switch ( torf ) {
        case 0:
            
            pScore = 1;
            
            if (swipedView.tag == 1) {
                swipedView.center = CGPointMake(swipedView.center.x + moveX, swipedView.center.y - moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 134) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 434) moveY = - moveY;
                
            }else if (swipedView.tag == 2){
                swipedView.center = CGPointMake(swipedView.center.x + moveX, swipedView.center.y + moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 134) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 310) moveY = - moveY;
                
            }else if (swipedView.tag == 3){
                swipedView.center = CGPointMake(swipedView.center.x - moveX, swipedView.center.y + moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 134) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 434) moveY = - moveY;
                
            }else if (swipedView.tag == 4){
                swipedView.center = CGPointMake(swipedView.center.x - moveX, swipedView.center.y - moveY);
                // ballと横壁の当たり判定
                if(swipedView.center.x - swipedView.bounds.size.width / 2 < 10) moveX = - moveX;
                if(swipedView.center.x + swipedView.bounds.size.width / 2 > 310) moveX = - moveX;
                
                //上下の壁との当たり判定
                if(swipedView.center.y - swipedView.bounds.size.height / 2 < 134) moveY = - moveY;
                if(swipedView.center.y + swipedView.bounds.size.height / 2 > 434) moveY = - moveY;
            }
            break;
        case 1:
            score = score+25;
            plusScore =  plusScore * 3;
            if (plusScore % 27 == 0){
                pScore = 25 * plusScore/27/10;
            }
            perfectScore = score + pScore;
            //scoreLabel.text = [NSString stringWithFormat:@"%d",perfectScore];

            if (swipedView.tag == 1) {
                [UIView animateWithDuration:0.8f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.center = CGPointMake(310, 134);
                                 }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 2){
                [UIView animateWithDuration:0.8f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.center = CGPointMake(310, 434);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 3){
                [UIView animateWithDuration:0.8f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.center = CGPointMake(10, 434);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //[swipedView removeFromSuperview];
                                 }];
                
            }else if (swipedView.tag == 4){
                [UIView animateWithDuration:0.8f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    swipedView.center = CGPointMake(10, 134);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //[swipedView removeFromSuperview];
                                 }];
            
            }
        default:
            break;
    }
    
    }

@end