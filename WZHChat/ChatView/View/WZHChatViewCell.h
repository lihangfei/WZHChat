//
//  WZHChatViewCell.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZHCellFrame.h"
#import "WZHEmotionLabel.h"

@protocol WZHChatMessageDelegate <NSObject>

-(void)ChatMessageClicked:(UILongPressGestureRecognizer *)longBtn;


@end

@interface WZHChatViewCell : UITableViewCell

@property(nonatomic,assign)NSString * guestStr;

@property(nonatomic,strong)WZHCellFrame *cellFrame;
@property(nonatomic,strong)WZHEmotionLabel *emotionLabel;

@property(nonatomic,strong)UILabel * lab_time;
@property(nonatomic,strong)UILabel * lab_name;
@property(nonatomic,strong)UIImageView * headerView;
@property(nonatomic,strong)NSString * messageWidth;
@property(nonatomic,strong)NSString * messageHight;
@property(nonatomic,strong)UIImageView * conversationView;
@property(nonatomic,strong)NSString * compareTimeStr;
@property(nonatomic,strong)NSDate *timeDate;
@property(nonatomic,strong)UIButton * btn_chatMessage;

@property(assign,nonatomic) id <WZHChatMessageDelegate> delegate;



-(void)initWithTime:(NSString *)timeStr HeaderStr:(NSString *)headerStr Name:(NSString *)nameStr Guest:(NSString *)guestStr MessageWidth:(NSString *)messageWidth MessageHight:(NSString *)messageHight ChatMessageTag:(NSInteger)chatMessageTag;

@end
