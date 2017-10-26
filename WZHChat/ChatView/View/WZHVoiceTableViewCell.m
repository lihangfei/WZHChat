//
//  WZHVoiceTableViewCell.m
//  WebPageMaster
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 Guangzhou Ankai Information Technology Co., Ltd. All rights reserved.
//

#import "WZHVoiceTableViewCell.h"

@implementation WZHVoiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lab_time = [[UILabel alloc] init];
        _lab_time.text = @"2017-08-20 11:30:21";
        _lab_time.frame = CGRectMake((IPHONE_WIDTH - [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width) / 2, 5 * ScaleY_Num, [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width + 10 * ScaleX_Num, 12 * ScaleY_Num);
        _lab_time.textColor = FFFFFF;
        _lab_time.backgroundColor = C999999;
        _lab_time.font = UIFONT_SYS(12);
        _lab_time.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lab_time];
        
        self.headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = C666666;
        _headerView.image = [UIImage imageNamed:@""];
        [self addSubview:_headerView];
        
        
        int value = (arc4random() % 80) + 1;
        self.currentRecordTime = @"1";
        self.conversationView = [[UIImageView alloc] init];
        [self addSubview:_conversationView];
        CGFloat width = value + 12;
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 20 * ScaleY_Num / 2, 30 * ScaleX_Num, 30 * ScaleX_Num);
        self.lab_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerView.frame) + 5 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 6 * ScaleY_Num, IPHONE_WIDTH / 2, 12 * ScaleY_Num)];
        _lab_name.text = @"吴梓杭1111";
        _lab_name.textColor = C999999;
        _lab_name.font = UIFONT_SYS(10);
        [self addSubview:_lab_name];
        _conversationView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, width + 50 * ScaleX_Num, 30 * ScaleY_Num);
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundGuest"];
        
        self.btn_voice = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_voice setImage:[UIImage imageNamed:@"left-3"] forState:(UIControlStateNormal)];
        //播放完成时,按钮会一直持续高亮状态,按钮图片的颜色会被系统默认渲染,写了这句按钮的显示就会正常
        [_btn_voice setImage:[UIImage imageNamed:@"left-3"] forState:UIControlStateHighlighted];
        [_btn_voice setImageEdgeInsets:UIEdgeInsetsMake(0, -12 - (value/2), 0, 12 + (value/2))];
        [_btn_voice setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _btn_voice.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, width + 50 * ScaleX_Num, 30 * ScaleY_Num);
        _btn_voice.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_btn_voice];
        
        self.lab_currentRecordTime = [[UILabel alloc] init];
        _lab_currentRecordTime.frame = CGRectMake(CGRectGetMaxX(_btn_voice.frame) + 10 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 50 * ScaleX_Num, 30 * ScaleY_Num);
        _lab_currentRecordTime.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        unichar ch =34;
        _lab_currentRecordTime.text = [NSString stringWithFormat:@"%@%@",_currentRecordTime,[NSString stringWithUTF8String:(char *)&ch]];
        _lab_currentRecordTime.textColor = C999999;
        [self addSubview:_lab_currentRecordTime];
        
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(clickChatMessageLongBtn:)];
        longPress.minimumPressDuration = 1.0; //定义按的时间
        [_btn_voice addGestureRecognizer:longPress];
        [self addSubview:_btn_voice];
        
    }
    return self;
}
-(void)initWithTimeStr:(NSString *)timeStr HeaderStr:(NSString *)headerStr NameStr:(NSString *)nameStr CurrentRecordTime:(NSString *)currentRecordTime Guest:(NSString *)guestStr RecordTag:(NSInteger)recordTag{
    if ([timeStr isEqualToString:@" "]) {
        _lab_time.frame = CGRectMake(0, 5 * ScaleY_Num, 0, 0);
    }else{
        self.timeDate = [NSDate timeStringToDate:timeStr];
        NSString *requiredString = [_timeDate dateToRequiredString1];
        _lab_time.text = requiredString;
        _lab_time.frame = CGRectMake((IPHONE_WIDTH - [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width) / 2, 5 * ScaleY_Num, [NSString getSizeByString:_lab_time.text AndFontSize:12 size:CGSizeMake(IPHONE_WIDTH / 3, 12 * ScaleY_Num)].width + 10 * ScaleX_Num, 12 * ScaleY_Num);
    }
    
    NSString * imageStr = headerStr;
    if ([imageStr isKindOfClass:[NSNull class]] || imageStr.length == 0) {
        self.headerView.image = [UIImage imageNamed:@"default_head"];
    }else{
        NSURL * headerUrl = [NSURL URLWithString:imageStr];
        UIImage * headerImage = [UIImage imageNamed:@"default_head"];
        [_headerView sd_setImageWithURL:headerUrl placeholderImage:headerImage options:SDWebImageRefreshCached];
    }
    int value = (arc4random() % 80) + 1;
    //    self.currentRecordTime = currentRecordTime;
    CGFloat width = value + 12;
    if ([guestStr intValue] == 1) {
        _lab_name.text = nameStr;
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);
        _conversationView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, width + 50 * ScaleX_Num, 30 * ScaleY_Num);
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundGuest"];
        
        [_btn_voice setImage:[UIImage imageNamed:@"left-3"] forState:(UIControlStateNormal)];
        //播放完成时,按钮会一直持续高亮状态,按钮图片的颜色会被系统默认渲染,写了这句按钮的显示就会正常
        [_btn_voice setImage:[UIImage imageNamed:@"left-3"] forState:UIControlStateHighlighted];
        [_btn_voice setImageEdgeInsets:UIEdgeInsetsMake(0, -12 - (value/2), 0, 12 + (value/2))];
        _btn_voice.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, width + 50 * ScaleX_Num, 30 * ScaleY_Num);
        NSString * recordStr = [NSString stringWithFormat:@"01%ld",recordTag];
        _btn_voice.tag = [recordStr intValue] + 1;
        _lab_currentRecordTime.frame = CGRectMake(CGRectGetMaxX(_btn_voice.frame) + 10 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, 50 * ScaleX_Num, 30 * ScaleY_Num);
        unichar ch =34;
        _lab_currentRecordTime.text = [NSString stringWithFormat:@"%@%@",_currentRecordTime,[NSString stringWithUTF8String:(char *)&ch]];
    }else{
        _lab_name.text = @"";
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundMain"];
        _conversationView.frame = CGRectMake(IPHONE_WIDTH - 66 * ScaleX_Num - width, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, width + 24 * ScaleX_Num, 30 * ScaleY_Num);
        [_btn_voice setImage:[UIImage imageNamed:@"right-3"] forState:(UIControlStateNormal)];
        //播放完成时,按钮会一直持续高亮状态,按钮图片的颜色会被系统默认渲染,写了这句按钮的显示就会正常
        [_btn_voice setImage:[UIImage imageNamed:@"right-3"] forState:UIControlStateHighlighted];
        [_btn_voice setImageEdgeInsets:UIEdgeInsetsMake(0, 3 + (value/2), 0, - 3 - (value/2))];
        _btn_voice.frame = CGRectMake(IPHONE_WIDTH - 66 * ScaleX_Num - width, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, width + 24 * ScaleX_Num, 30 * ScaleY_Num);
        NSString * recordStr = [NSString stringWithFormat:@"00%ld",recordTag];
        _btn_voice.tag = [recordStr intValue] + 501;
        _headerView.frame = CGRectMake(IPHONE_WIDTH - 40 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);
        
        _lab_currentRecordTime.frame = CGRectMake(IPHONE_WIDTH - _btn_voice.frame.size.width - 95 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 50 * ScaleX_Num, 30 * ScaleY_Num);
        unichar ch =34;
        _lab_currentRecordTime.text = [NSString stringWithFormat:@"%@%@",_currentRecordTime,[NSString stringWithUTF8String:(char *)&ch]];
        _lab_currentRecordTime.textAlignment = NSTextAlignmentRight;
    }
    [_btn_voice addTarget:self action:@selector(voiceButtonPlay:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tag = 601 + recordTag;
}


-(void)voiceButtonPlay:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(VoiceClicked:)]) {
        [self.delegate VoiceClicked:sender];
    }
}
-(void)clickChatMessageLongBtn:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(ChatMessageClicked:)]) {
            [self.delegate ChatMessageClicked:gestureRecognizer];
        }
    }
}

@end
