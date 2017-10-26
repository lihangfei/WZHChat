//
//  WZHChatViewCell.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHChatViewCell.h"
#import "WZHChatService.h"
#define margin IPHONE_WIDTH * 5 / 320
#define headH IPHONE_WIDTH * 35 / 320

@implementation WZHChatViewCell



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

        self.conversationView = [[UIImageView alloc] init];
        [self addSubview:_conversationView];
        self.messageWidth = @"200";
        self.messageHight = @"40";
        NSInteger newMessageWidth;
        NSInteger newMessageHight;
        newMessageWidth = IPHONE_WIDTH - 125 * ScaleX_Num;
        newMessageHight = [_messageHight intValue] + 14 * ScaleY_Num;
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 20 * ScaleY_Num / 2, 30 * ScaleX_Num, 30 * ScaleX_Num);
        self.lab_name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerView.frame) + 5 * ScaleX_Num, CGRectGetMaxY(self.lab_time.frame) + 6 * ScaleY_Num, IPHONE_WIDTH / 2, 12 * ScaleY_Num)];
        _lab_name.text = @"吴梓杭111111";
        _lab_name.textColor = C999999;
        _lab_name.font = UIFONT_SYS(10);
        [self addSubview:_lab_name];
        _conversationView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundGuest"];

        self.emotionLabel = [[WZHEmotionLabel alloc]init];
        self.emotionLabel.numberOfLines = 0;
        [_conversationView addSubview:_emotionLabel];
        
        self.btn_chatMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_chatMessage.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_name.frame) + 1* ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
        [self addSubview:_btn_chatMessage];
    }
    return self;
}

-(void)setCellFrame:(WZHCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    self.emotionLabel.attributedText = cellFrame.message.attributedText;
    self.emotionLabel.frame = cellFrame.emotionLabelFrame;
}
-(void)initWithTime:(NSString *)timeStr HeaderStr:(NSString *)headerStr Name:(NSString *)nameStr Guest:(NSString *)guestStr MessageWidth:(NSString *)messageWidth MessageHight:(NSString *)messageHight ChatMessageTag:(NSInteger)chatMessageTag{
    
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
    
    self.messageWidth = messageWidth;
    self.messageHight = messageHight;
    NSInteger newMessageWidth;
    NSInteger newMessageHight;
    if ([messageWidth intValue] > (IPHONE_WIDTH - 100 * ScaleX_Num)) {
        newMessageWidth = IPHONE_WIDTH - 125 * ScaleX_Num;
    }else{
        newMessageWidth = [messageWidth intValue];
    }
    if ([messageHight intValue] < 30 * ScaleX_Num){
        newMessageHight = 30 * ScaleX_Num;
    }else{
        newMessageHight = [messageHight intValue] + 14 * ScaleY_Num;
    }
    if ([guestStr intValue] == 1) {
        _lab_name.text = nameStr;
        _headerView.frame = CGRectMake(10 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);
        _conversationView.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_time.frame) + 17* ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundGuest"];
        _btn_chatMessage.frame = CGRectMake(CGRectGetMaxX(self.headerView.frame) + 3 * ScaleX_Num, CGRectGetMaxY(_lab_time.frame) + 17* ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
        
    }else{
        _lab_name.text = @"";
        _lab_name.frame = CGRectMake(0, 0, 0, 0);
        _conversationView.image = [UIImage stretchableImageWithImgae:@"chatBackgroundMain"];
        _conversationView.frame = CGRectMake(IPHONE_WIDTH - 66 * ScaleX_Num - newMessageWidth, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
        _headerView.frame = CGRectMake(IPHONE_WIDTH - 40 * ScaleX_Num,CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, 30 * ScaleX_Num, 30 * ScaleX_Num);
        _btn_chatMessage.frame = CGRectMake(IPHONE_WIDTH - 66 * ScaleX_Num - newMessageWidth, CGRectGetMaxY(self.lab_time.frame) + 10 * ScaleY_Num, newMessageWidth + 24 * ScaleX_Num, newMessageHight);
    }
    _btn_chatMessage.tag = 501 + chatMessageTag;
    self.tag = 601 + chatMessageTag;
}
-(void)clickChatMessageLongBtn:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"%ld",self.tag);
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(ChatMessageClicked:)]) {
            [self.delegate ChatMessageClicked:gestureRecognizer];
        }
    }
}
@end
