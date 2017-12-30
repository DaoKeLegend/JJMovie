//
//  ViewController.m
//  JJMovie_demo2
//
//  Created by lucy on 2017/12/30.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //如果没有声音，需要加上这一句话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //创建要播放的元素
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"movie.mp4" withExtension:nil];
    //playerItemWithAsset:通过设备相册里面的内容 创建一个 要播放的对象
    // 我们这里直接选择使用URL读取
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    //    时间控制的类目
    //    current
    //    forwordPlaybackEndTime   跳到结束位置
    //    reversePlaybackEndTime    跳到开始位置
    //    seekToTime   跳到指定位置
    
    //    采取kvo的形式获取视频总时长
    //    通过监视status判断是否准备好
    
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //创建播放器
    self.player = [AVPlayer playerWithPlayerItem:item];
    //也可以直接WithURL来获得一个地址的视频文件
    //    externalPlaybackVideoGravity    视频播放的样式
    //    AVLayerVideoGravityResizeAspect   普通的
    //    AVLayerVideoGravityResizeAspectFill   充满的
    //    currentItem  获得当前播放的视频元素
    
    //创建视频显示的图层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = self.view.frame;
    
    // 显示播放视频的视图层要添加到self.view的视图层上面
    [self.view.layer addSublayer:layer];
   
    //界面
    [self initUI];
    
    //最后一步开始播放
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - Object Private Function

- (void)initUI
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:@"快进" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake((self.view.bounds.size.width - 100.0) * 0.5, 100.0, 100.0, 100.0);
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - KVO

//    duration   当前播放元素的总时长
//    status  加载的状态
//    AVPlayerItemStatusUnknown,  未知状态
//    AVPlayerItemStatusReadyToPlay,  准备播放的状态
//    AVPlayerItemStatusFailed   失败的状态

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    switch ([change[@"new"] integerValue]) {
        case AVPlayerItemStatusUnknown:{
            NSLog(@"未知状态");
            break;
        }
        case AVPlayerItemStatusReadyToPlay:{
            NSLog(@"获得视频总时长  %f",CMTimeGetSeconds(self.player.currentItem.duration));
            break;
        }
        case AVPlayerItemStatusFailed:{
            NSLog(@"加载失败");
            break;
        }
        default:
            break;
    }
}

#pragma mark - Action && Notification

- (void)buttonDidClick:(UIButton *)button
{
    [self.player seekToTime:CMTimeMakeWithSeconds(self.player.currentTime.value/self.player.currentTime.timescale + 1, self.player.currentTime.timescale) toleranceBefore:CMTimeMake(1, self.player.currentTime.timescale) toleranceAfter:CMTimeMake(1, self.player.currentTime.timescale)];
}

- (void)itemDidPlayEnd:(NSNotification *)notify
{
    NSLog(@"播放结束");
    [self.player seekToTime:kCMTimeZero];
    [self.player play];
}

@end













