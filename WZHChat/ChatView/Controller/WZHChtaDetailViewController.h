//
//  WZHChtaDetailViewController.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKBaseWithBaseViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface WZHChtaDetailViewController :AKBaseWithBaseViewController

@property (nonatomic,strong)AVAudioSession * session;
@property (nonatomic,strong)AVAudioRecorder * record;
@property (nonatomic,assign)NSTimer * timer;
@property (nonatomic,copy)NSString *filePath;
@property (nonatomic,strong)AVAudioPlayer * player;

@end


