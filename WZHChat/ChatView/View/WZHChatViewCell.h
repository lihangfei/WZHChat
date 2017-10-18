//
//  WZHChatViewCell.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZHCellFrame.h"
#import "WZHChatMessage.h"
#import "WZHEmotionLabel.h"

@interface WZHChatViewCell : UITableViewCell


@property(nonatomic, strong)UIImageView *gifView;

@property(nonatomic, strong)UIImageView *lineView;

@property(nonatomic, strong)WZHCellFrame *cellFrame;

@property(nonatomic, strong)WZHEmotionLabel *emotionLabel;

@property(nonatomic, assign)BOOL isAsync;

@property(nonatomic, strong)WZHChatMessage *message;

@property(nonatomic, strong)UIButton *headIcon;

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UIWebView *textView;


@end
