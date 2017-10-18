//
//  WZHChatViewCell.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHChatViewCell.h"
#define margin IPHONE_WIDTH * 5 / 320
#define headH IPHONE_WIDTH * 35 / 320

@implementation WZHChatViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textView = [[UIWebView alloc]init];
        self.textView.scrollView.bounces = NO;
        self.textView.userInteractionEnabled = NO;
        self.textView.opaque = NO;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.scrollView.backgroundColor = [UIColor redColor];
        self.textView.scrollView.contentInset = UIEdgeInsetsMake(-7.5 * ScaleX_Num, -7.5 * ScaleX_Num, 0, 0);
        [self addSubview:self.textView];
        
        self.lineView = [[UIImageView alloc]init];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
        
        self.emotionLabel = [[WZHEmotionLabel alloc]init];
        self.emotionLabel.numberOfLines = 0;
        [self addSubview:self.emotionLabel];
        
    }
    return self;
}

-(void)setCellFrame:(WZHCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    self.lineView.frame = CGRectMake(0, self.cellFrame.cellHeight - 1, IPHONE_WIDTH, 1);
    self.emotionLabel.attributedText = cellFrame.message.attributedText;
    self.emotionLabel.frame = cellFrame.emotionLabelFrame;
}







@end
