//
//  ViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/06/27.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "ViewController.h"
//#import "DMCrookedSwipeView.h"
#import "GameOverViewController.h"
#import "OptionViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController
@synthesize volume;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    plusScore = 1;
    score = 0;
    scoreLabel.text = @"0";
//    gameStatusFlag = 0;
    
    /*--音--*/
    //ちりーん
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bell01" ofType:@"mp3"] ;
    NSURL *url = [NSURL fileURLWithPath:path] ;
    tirin = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] ;

    //っどん
    NSString *donPath = [[NSBundle mainBundle] pathForResource:@"don01" ofType:@"mp3"] ;
    NSURL *donUrl = [NSURL fileURLWithPath:donPath] ;
    don = [[AVAudioPlayer alloc] initWithContentsOfURL:donUrl error:nil] ;

    //どどん
    NSString *dodonPath = [[NSBundle mainBundle] pathForResource:@"dodon02" ofType:@"mp3"] ;
    NSURL *dodonUrl = [NSURL fileURLWithPath:dodonPath] ;
    dodon = [[AVAudioPlayer alloc] initWithContentsOfURL:dodonUrl error:nil] ;

    //ぽん！
    NSString *ponPath = [[NSBundle mainBundle] pathForResource:@"pon01" ofType:@"mp3"] ;
    NSURL *ponUrl = [NSURL fileURLWithPath:ponPath] ;
    pon = [[AVAudioPlayer alloc] initWithContentsOfURL:ponUrl error:nil] ;

    //かん
    NSString *kanPath = [[NSBundle mainBundle] pathForResource:@"kannn" ofType:@"mp3"] ;
    NSURL *kanUrl = [NSURL fileURLWithPath:kanPath] ;
    kan = [[AVAudioPlayer alloc] initWithContentsOfURL:kanUrl error:nil] ;

    
    /*--octagon--*/
    //    randomOctagon = arc4random_uniform(2);
    //    NSLog(@"randomOctagon is...%d",randomOctagon);
    //    if (randomOctagon == 0 ) {
    //        octagon.image = [UIImage imageNamed:@"Noctagon().png"];
    //    }else if (randomOctagon == 1){
    //        octagon.image = [UIImage imageNamed:@"Noctagon()2.png"];
    //    }
    octagon.image = [UIImage imageNamed:@"Noctagon().png"];
    
    // 通知の受け取り登録("TestPost"という通知名の通知を受け取る)
    // 通知を受け取ったら自身のreceive:メソッドを呼び出す
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(receive:) name:@"hoge" object:nil];
    
    /*---timer---*/
    // timer = [NSTimer scheduledTimerW:；bcithTimeInterval:0.01 target:self selector:@selector(up) userInfo:nil repeats:YES];
    time = 0;
    firstTapFlag = YES;
    
    [tirin play];
    
    isStart = NO;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [gameoverView removeFromSuperview];
    
    level = 1;
    time = 0;
    firstTapFlag = YES;
    score = 0;
    scoreLabel.text = [NSString stringWithFormat:@"%dしゅ",score];
    

    
    //画面を初期化する
    if(isGameOver == YES){
        for (UIView *view in [self.view subviews]) {
            if(view.tag == 1){
                [view removeFromSuperview];
            }
            if ([view isKindOfClass:[DMCrookedSwipeView class]]) {
                [view removeFromSuperview];
            }
        }
    }
    
    isGameOver = NO;

    /*==丸つくる==*/
    //if(gameStatusFlag == 1){
        [self makeLeftUpwordMaru];
        [self makeLeftDownwordMaru];
        [self makeRightUpwordMaru];
        [self makeRightDownwordMaru];
    //}
    
    /*--gameover--*/
    gameoverView =[[UIImageView alloc] initWithFrame:CGRectMake (110,267,100,100)];
    gameoverView.image = [UIImage imageNamed:@"gameover.png"];
    gameoverView.tag = 1;
    

    if (isStart == NO) {
        /*--最初の画面--*/
        firstView =[[UIImageView alloc] initWithFrame:CGRectMake (0,0,320,568)];
        firstView.image = [UIImage imageNamed:@"Noctagon_first.png"];
        [self.view addSubview:firstView];
        
        [self addTapToReturn];  //タップで消す
        
        /*--歯車のボタン--*/
        //生成
        optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *img = [UIImage imageNamed:@"pico_settei.png"];  // ボタンにする画像を生成する
        optionButton.frame = CGRectMake(15, 20, 60, 60);
        [optionButton setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
        // ボタンが押された時にhogeメソッドを呼び出す
        [optionButton addTarget:self
                         action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:optionButton];
        
//        isStart = YES;
        }
}


-(void)up{
    time +=0.01f;
//    NSLog(@"time ======> %f", time);
    
    switch (level) {
        case 1:
            countDown = 1.5f - time;
            if (countDown >= 0 ) {
                gameTimerLabel.text = [NSString stringWithFormat:@"%0.2f",countDown];
            }else{
                gameTimerLabel.text = @"0.00";
            }

            break;
        case 2:
            countDown = 1.0f - time;
            if (countDown >= 0 ) {
                gameTimerLabel.text = [NSString stringWithFormat:@"%0.2f",countDown];
            }else{
                gameTimerLabel.text = @"0.00";
            }
            break;
        case 3:
            countDown = 0.5f - time;
            if (countDown >= 0 ) {
                gameTimerLabel.text = [NSString stringWithFormat:@"%0.2f",countDown];
            }else{
                gameTimerLabel.text = @"0.00";
            }
            break;
            
        default:
            break;
    }
    
    [self makeLebel]; //レベルがあげる
    lebelLabel.text = [NSString stringWithFormat:@"%d幕",level];

    switch (level) {
        case 1:
            if (time >= 1.5) {
                // game over
                isGameOver = YES;
                NSLog(@"gameover");
                [dodon play];
                [gameoverTimer invalidate];  //１回しか呼ばないように
                
                //[self.view addSubview:gameoverView]; //gameoverを表示
                
                [UIView animateWithDuration:2.5f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                   gameoverView =[[UIImageView alloc] initWithFrame:CGRectMake (110,267,100,100)];
                    gameoverView.image = [UIImage imageNamed:@"Gameover.png"];
                    [self.view addSubview:gameoverView];
                    gameoverView.transform = CGAffineTransformMakeScale(8.5,8.5);
                }completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //画面遷移する
                                     [self performSegueWithIdentifier:@"gameOver" sender:nil];
                                     
                                 }];
                }
            
            
            break;
        case 2:
            if (time >= 1.0) {
                // game over
                isGameOver = YES;
                NSLog(@"gameover");
                [dodon play];
                [gameoverTimer invalidate];  //１回しか呼ばないように
                
                gameoverView =[[UIImageView alloc] initWithFrame:CGRectMake (110,267,100,100)];
                gameoverView.image = [UIImage imageNamed:@"Gameover.png"];
                [self.view addSubview:gameoverView]; //gameoverを表示
                [UIView animateWithDuration:2.5f animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    gameoverView.transform = CGAffineTransformMakeScale(8.5,8.5);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     //画面遷移する
                                     [self performSegueWithIdentifier:@"gameOver" sender:nil];
                                     
                                 }];
            }
            break;
        case 3:
            if (time >= 0.5) {
                // game over
                isGameOver = YES;
                NSLog(@"gameover");
                [dodon play];
                [gameoverTimer invalidate];  //１回しか呼ばないように
                
                gameoverView =[[UIImageView alloc] initWithFrame:CGRectMake (110,267,100,100)];
                gameoverView.image = [UIImage imageNamed:@"Gameover.png"];
                [self.view addSubview:gameoverView]; //gameoverを表示
                [UIView animateWithDuration:2.5 animations:^{
                    //animateWithDurationがアニメーションの速度
                    // アニメーションをする処理
                    gameoverView.transform = CGAffineTransformMakeScale(8.5,8.5);
                }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する
                                     //画面遷移する
                                     [self performSegueWithIdentifier:@"gameOver" sender:nil];
                                     
                                 }];
            }
            break;
            
        default:
            break;
    }
//    NSLog(@"lebel is ...%d",level);

}

//http://kesin.hatenablog.com/entry/20120908/1347079921
//画面遷移の直前に呼ばれる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"gameOver"] ) {
        NSLog(@"変数を渡した！");
        GameOverViewController *nextViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        nextViewController.score = score;
    }
}


-(void)receive:(NSNotification *)center
{
//    [don play];
    time = 0;
    
    if (firstTapFlag) {
        gameoverTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(up) userInfo:nil repeats:YES];
        firstTapFlag = NO;
        //１回だけ呼ばれるように
        }
    
    
    // 通知を受け取ったときの処理...
    
    //場所の通知
    if ([center.userInfo objectForKey:@"key"]) {
        //score
        NSLog(@"key");
        position = [center.userInfo objectForKey:@"key"];
        NSLog(@"position::%@", position);
        [self add:self.view.frame];
        }
    
    //合ってるっていう通知
    if ([center.userInfo objectForKey:@"score"]) {
        NSNumber * y = [center.userInfo objectForKey:@"score"];
        int p = [y intValue];
        score = score + p;
        NSLog(@"score is...%d",score);
        isOk = YES;
    }else if ([center.userInfo objectForKey:@"dame"]){
        isOk = NO;
    }
    
    [self swipeSounds];

}

-(void) swipeSounds{
    if (isOk == YES) {
        //[UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^ {

        //[UIView animateWithDuration:0.3F animations:^{
            [don play];
        //}];
        
    }else if (isOk == NO){
        [kan play];
    }
}



//タップで消す
- (void)addTapToReturn {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doReturn:)];
    [self.view addGestureRecognizer:tap];
}
- (void)doReturn:(UITapGestureRecognizer *)tap {
    
    //if(gameStatusFlag == 0) gameStatusFlag = 1;
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [firstView removeFromSuperview];
    [optionButton removeFromSuperview];
    isStart = YES;
}


//丸に色をつける
- (UIImage *)setColor
{
    colorNum = arc4random_uniform(4);
     NSLog(@"colorNum is %d", colorNum);
    
    switch (colorNum) {
        case 0:
            return [UIImage imageNamed:@"NmarumaruBlue.png"];
            break;
        case 1:
            return [UIImage imageNamed:@"NmarumaruGreen.png"];
            break;
        case 2:
            return [UIImage imageNamed:@"NmarumaruPink.png"];
            break;
        case 3:
            return [UIImage imageNamed:@"NmarumaruYellow.png"];
            break;
        default:
            break;
    }
    return nil;
}
/*----角の色----*/
//右上　yellow (3)
//右下　pink   (2)
//左上　green  (1)
//左下　blue   (0)

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)add:(CGRect)rect{
    
    int i = [position intValue];
    
    /*==丸つくる==*/
    if (i == 0) {
        NSLog(@"make左上");
        [self makeLeftUpwordMaru];
        
    }else if(i == 1){
        NSLog(@"make右上");
        [self makeRightUpwordMaru];
        
    }else if(i == 2){
        NSLog(@"make左下");
        [self makeLeftDownwordMaru];
        
    }else if(i == 3) {
        NSLog(@"make右下");
        [self makeRightDownwordMaru];
    }

}

/*sumiviewとmarbleが重なったら消す*/
- (void) hanteiWithMarble:(UIImageView *)swipeView {
    
    float x = swipeView.center.x;
    float y = swipeView.center.y;
    
    NSLog(@"x%f",x);
    NSLog(@"y%f",y);
    //if( x + y <= 351)marbleForhantei.alpha = 0.0;
    
    /*
    if( y <= 254  &&  x >= 223){
        if (x + y >= 477){
            marbleForhantei.alpha = 0.0;
        }
    }

    if( y >= 380  &&  x <= 97){
        
        if ( x + y <= 473){
            marbleForhantei.alpha = 0.0;
        }
    }
    
    if( y <= 380  &&  x >= 223){
        if (x + y >= 603){
            marbleForhantei.alpha = 0.0;
        }
    }
     */
//    if( y <= 254  &&  x <= 97){
//        if (x + y <= 244){
//            swipeView.alpha = 0.0;
//        }
//    }

swipeView.alpha = 0.0;
}

//scoreが増えるとレベルがあがる
-(void)makeLebel{
    if (score >= 10 && score <=20) {
        level = 2;
    }else if (score >= 20 && score <= 30){
        level = 3;
    }
}


/*----マーブル作る----*/
- (void)makeLeftUpwordMaru{
    
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^ {
        //１秒かけてアニメーション。0.5秒後からアニメーション
        //^と^の間はブロック構文！ブロック構文は、１回流れとは別に動かす構文！コールバックとセットのことが多いよ。流れからブロック！
        //アニメーションで変化させたい値を設定する（最終的に変更したい値）
        
        DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(110,267, MARBLE_WIDTH, MARBLE_HEIGHT)];
        marble.delegate = self;  //マーブルのデリゲートできるマンは私だよ。やってあげるよ。
        marble.image= [self setColor];
        
        if(marble.image == [UIImage imageNamed:@"NmarumaruBlue.png"]){
            marble.objestColor = @"blue";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruGreen.png"]){
            marble.objestColor = @"green";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruPink.png"]) {
            marble.objestColor = @"pink";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruYellow.png"]) {
            marble.objestColor = @"yellow";
        }
        
        marble.userInteractionEnabled = YES; //タッチイベントを許可する
        marble.objectPosition = @"LeftUp";
        
        if(isGameOver == NO) [self.view addSubview:marble];  //gameoverしたら丸はもう足さない
    
    } completion:^(BOOL finished){
        //完了時のコールバック
    }];
    
    scoreLabel.text = [NSString stringWithFormat:@"%dしゅ",score];
    NSLog(@"%dしゅ",score);
    
    //NSDictionary *dic = [NSDictionary dictionaryWithObject:marble forKey:@"key"];
}

- (void)makeRightUpwordMaru
{
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^ {
        //１秒かけてアニメーション。0.5秒後からアニメーション
        //^と^の間はブロック構文！ブロック構文は、１回流れとは別に動かす構文！コールバックとセットのことが多いよ。流れからブロック！
        //アニメーションで変化させたい値を設定する（最終的に変更したい値）
        
        DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(160,267, MARBLE_WIDTH, MARBLE_HEIGHT)];
         marble.delegate = self;  //マーブルのデリゲートできるマンは私だよ。やってあげるよ。
        marble.image= [self setColor];
        if(marble.image == [UIImage imageNamed:@"NmarumaruBlue.png"]){
            marble.objestColor = @"blue";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruGreen.png"]){
            marble.objestColor = @"green";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruPink.png"]) {
            marble.objestColor = @"pink";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruYellow.png"]) {
            marble.objestColor = @"yellow";
        }

        marble.userInteractionEnabled = YES; //タッチイベントを許可する
        marble.objectPosition = @"RightUp";

        if(isGameOver == NO) [self.view addSubview:marble];  //gameoverしたら丸はもう足さない
        
    } completion:^(BOOL finished){
        //完了時のコールバック
    }];
    
    scoreLabel.text = [NSString stringWithFormat:@"%dしゅ",score];
    NSLog(@"%dしゅ",score);

}

- (void)makeLeftDownwordMaru{
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^ {
        //１秒かけてアニメーション。0.5秒後からアニメーション
        //^と^の間はブロック構文！ブロック構文は、１回流れとは別に動かす構文！コールバックとセットのことが多いよ。流れからブロック！
        //アニメーションで変化させたい値を設定する（最終的に変更したい値）
        
        DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(110,317, MARBLE_WIDTH, MARBLE_HEIGHT)];
        marble.delegate = self;  //マーブルのデリゲートできるマンは私だよ。やってあげるよ。
        marble.image= [self setColor];
        if(marble.image == [UIImage imageNamed:@"NmarumaruBlue.png"]){
            marble.objestColor = @"blue";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruGreen.png"]){
            marble.objestColor = @"green";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruPink.png"]) {
            marble.objestColor = @"pink";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruYellow.png"]) {
            marble.objestColor = @"yellow";
        }

        
        marble.userInteractionEnabled = YES; //タッチイベントを許可する
        marble.objectPosition = @"LeftDown";
        
        if(isGameOver == NO) [self.view addSubview:marble];  //gameoverしたら丸はもう足さない
        
    } completion:^(BOOL finished){
        //完了時のコールバック
    }];
    
    scoreLabel.text = [NSString stringWithFormat:@"%dしゅ",score];
    NSLog(@"%dしゅ",score);

}

- (void)makeRightDownwordMaru
{
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^ {
        //１秒かけてアニメーション。0.5秒後からアニメーション
        //^と^の間はブロック構文！ブロック構文は、１回流れとは別に動かす構文！コールバックとセットのことが多いよ。流れからブロック！
        //アニメーションで変化させたい値を設定する（最終的に変更したい値）
        
        DMCrookedSwipeView *marble = [[DMCrookedSwipeView alloc] initWithFrame:CGRectMake(160,317, MARBLE_WIDTH, MARBLE_HEIGHT)];
         marble.delegate = self;  //マーブルのデリゲートできるマンは私だよ。やってあげるよ。
        marble.image= [self setColor];
        if(marble.image == [UIImage imageNamed:@"NmarumaruBlue.png"]){
            marble.objestColor = @"blue";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruGreen.png"]){
            marble.objestColor = @"green";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruPink.png"]) {
            marble.objestColor = @"pink";
        }else if (marble.image == [UIImage imageNamed:@"NmarumaruYellow.png"]) {
            marble.objestColor = @"yellow";
        }
        
    
        marble.userInteractionEnabled = YES; //タッチイベントを許可する
        marble.objectPosition = @"RightDown";
        if(isGameOver == NO) [self.view addSubview:marble];  //gameoverしたら丸はもう足さない
        
    } completion:^(BOOL finished){
        //完了時のコールバック
    }];
    
    scoreLabel.text = [NSString stringWithFormat:@"%dしゅ",score];
    NSLog(@"%dしゅ",score);
}

-(void)hoge:(UIButton*)button{
    isStart = NO;
    // ここに何かの処理を記述する
    // （引数の button には呼び出し元のUIButtonオブジェクトが引き渡されてきます）
    [self invalidate];  //timerをとめる
    
    OptionViewController *optionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Option"];
    [self presentViewController:optionViewController animated:YES completion:nil];
    optionViewController.delegate = self;  //オプションさんができないことはわしがやるよ。
    //オプションのビューにIDをつけて、移動する。オプションさんって言う人がいますよ。この人がオプションさんですよ。オプションさんにtびますよ。
}


-(void)volumeDown:(int)volume2{
    NSLog(@"受け取ったvolume is...%d",volume2);
    tirin.volume *= volume2;
    don.volume *= volume2;
    dodon.volume *= volume2;
    pon.volume *= volume2;
    kan.volume *= volume2;
}


//timerをとめる
-(void)invalidate{[gameoverTimer invalidate];}

@end
