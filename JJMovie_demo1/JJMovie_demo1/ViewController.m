//
//  ViewController.m
//  JJMovie_demo1
//
//  Created by lucy on 2017/12/30.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //路径
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:pathStr];
    
    //如果没有声音，需要加上这一句话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //实例化播放器控制器
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    playerVC.view.frame = self.view.frame;
    [self.view addSubview:playerVC.view];
    [self presentMoviePlayerViewControllerAnimated:playerVC];
    playerVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    //采用循环播放的方式
    playerVC.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    [playerVC.moviePlayer play];
}

@end
