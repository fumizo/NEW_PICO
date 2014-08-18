//
//  GameOverViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/08/13.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController
@synthesize score;

/*--------ふみこ4日目のやること--------*/
/*
 ==OK!== スコアが受け渡せないよ！
 ==OK!== スコアのとこで、もう１回遊ぶをしたい。
 ==OK!== →　viewの中を全部初期化したい
 ==OK!==Twitterでシェアしたいよ！
 ==OK!== オプションをして、もどると、gameoverになってるよ。タイマーを一時停止した
 ==OK!== → 戻ったときにまたタイマーを再生したいよ
 ==OK!== gameoverのピンクの上に丸がaddsubviewされちゃう
 ==OK!== オプションからのバックボタン
 ==OK!== →投稿が完了してからアラートをだす
 ==OK!== オプションから戻るとスコアが０になる
 ==OK!== やっぱり初期化できてなかった
 ゲームセンターつけたいよ！
 ==OK!== 効果音を沢山つけたいよ！
 それを調節するよ（optionのビュー
 （広告つけたい）
 
 間違ってるときと合ってるときで音を変えたいのに変わらない
 
 バグ
 ＝＝＝＝＝オプションから戻ると丸が上にある＝＝＝＝＝＝


 ====デザイン面====
 部品{　ゲームオーバーででてくる８角形
 　　　　スコア画面{Twitterでシェアボタン、はじめからボタン、スコアのラベル}
 }
 
 合ってるときと間違ってるときで音
 遊び方、音量、フィードバック

*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"受け渡されたscoreは%d",score);
    gameScoreLabel.text = [NSString stringWithFormat:@"%d しゅ",score];
    
    //ぽん！
    NSString *ponPath = [[NSBundle mainBundle] pathForResource:@"pon01" ofType:@"mp3"] ;
    NSURL *ponUrl = [NSURL fileURLWithPath:ponPath] ;
    pon = [[AVAudioPlayer alloc] initWithContentsOfURL:ponUrl error:nil] ;
    //ふりーーー
    NSString *fleePath = [[NSBundle mainBundle] pathForResource:@"flee1" ofType:@"mp3"] ;
    NSURL *fleeUrl = [NSURL fileURLWithPath:fleePath] ;
    flee = [[AVAudioPlayer alloc] initWithContentsOfURL:fleeUrl error:nil] ;
    //ごおおおん
    NSString *gooonPath = [[NSBundle mainBundle] pathForResource:@"gooon" ofType:@"mp3"] ;
    NSURL *gooonUrl = [NSURL fileURLWithPath:gooonPath] ;
    gooon = [[AVAudioPlayer alloc] initWithContentsOfURL:gooonUrl error:nil] ;

    [gooon play];

}

-(IBAction)backToStart{
    //gameoverになったことを通知
    NSNotification *s = [NSNotification notificationWithName:@"gameOver" object:self userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:s];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [pon play];
}

- (IBAction)twitter{
    [flee play];
    SLComposeViewController *twitterPostVC = [ SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //投稿する文章
    [twitterPostVC setInitialText:[NSString stringWithFormat:@"I WAS %dしゅ! #OCTAGON",score]];
    
//    //alertだす
//    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"TWEETすたよ" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];
//    [alert show ];
    [twitterPostVC setCompletionHandler:^ (SLComposeViewControllerResult result) {
        if(result == SLComposeViewControllerResultDone ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"投稿を完了しました！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"投稿に失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];

        }
        }];
    
    //tweetする
    [self presentViewController:twitterPostVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
