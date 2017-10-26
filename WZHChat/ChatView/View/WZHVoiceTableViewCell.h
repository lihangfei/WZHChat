//
//  WZHVoiceTableViewCell.h
//  WebPageMaster
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 Guangzhou Ankai Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WZHVoiceDelegate <NSObject>

-(void)VoiceClicked:(UIButton *)voiceBtn;
-(void)ChatMessageClicked:(UILongPressGestureRecognizer *)longBtn;


@end
@interface WZHVoiceTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * lab_time;
@property(nonatomic,strong)UILabel * lab_name;
@property(nonatomic,strong)UIImageView * headerView;
@property(nonatomic,strong)UIImageView * conversationView;
@property(nonatomic,strong)UIButton * btn_voice;
@property(nonatomic,strong)NSDate *timeDate;
@property(nonatomic,strong)NSString * currentRecordTime;
@property(nonatomic,strong)UILabel * lab_currentRecordTime;

@property(assign,nonatomic) id <WZHVoiceDelegate> delegate;


-(void)initWithTimeStr:(NSString *)timeStr HeaderStr:(NSString *)headerStr NameStr:(NSString *)nameStr CurrentRecordTime:(NSString *)currentRecordTime Guest:(NSString *)guestStr RecordTag:(NSInteger)recordTag;
@end
