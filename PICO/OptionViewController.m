//
//  OptionViewController.m
//  PICO
//
//  Created by 山本文子 on 2014/07/04.
//  Copyright (c) 2014年 山本文子. All rights reserved.
//

#import "OptionViewController.h"
//#import "ViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

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
    // AVAudioPlayerオブジェクトのボリュームは0.0〜1.0の間で指定する
    volume = 1.0;
    isSound = YES;    
}

-(IBAction)soundButton{
    //音がONになってたら押したときボリュームを０に。YESだったら逆。
    if (isSound == YES) {
        volume = 0;
        [self.delegate volumeDown:volume];
        isSound = NO;
    }else if (isSound == NO){
        volume = 1;
        [self.delegate volumeDown:volume];
        isSound = YES;
    }
    NSLog(@"オプションの画面で音量は...%d",volume);
}


- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//http://kesin.hatenablog.com/entry/20120908/1347079921
//画面遷移の直前に呼ばれる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
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
