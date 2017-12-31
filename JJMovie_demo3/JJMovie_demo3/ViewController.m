//
//  ViewController.m
//  JJMovie_demo3
//
//  Created by lucy on 2017/12/30.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>

@interface ViewController () <AVPlayerViewControllerDelegate>

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerViewController *playerVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //如果没有声音，需要加上这一句话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    AVPlayer *player = [AVPlayer playerWithURL:[[NSBundle mainBundle] URLForResource:@"movie.mp4" withExtension:nil]];
    self.player = player;
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    self.playerVC = playerVC;
    playerVC.player = player;
    playerVC.view.frame = self.view.frame;
    playerVC.delegate = self;
    // 设置拉伸模式
    playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    // 设置是否显示媒体播放组件
    playerVC.showsPlaybackControls = YES;
    [self.view addSubview:playerVC.view];
    [self addChildViewController:playerVC];
    
    //这个属性和图片填充视图的属性类似，也可以设置为自适应试图大小。
    player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [player play];
}

#pragma mark - AVPlayerViewControllerDelegate

- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"视频已经开始的时候调用");
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error
{
    NSLog(@"播放失败的时候");
}

- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"将要停止的时候");
}

- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController
{
    NSLog(@"已经停止的时候");
}

@end
