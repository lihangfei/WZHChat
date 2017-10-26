//
//  WZHToolbarView.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHToolbarView.h"

#define Vgap IPHONE_WIDTH * 5 / 320
#define Lgap IPHONE_WIDTH * 10 / 320

@implementation WZHToolbarView

-(instancetype)init
{
    if (self = [super init]) {
        
        self.frame = toolBarFrameDown;
        self.userInteractionEnabled = YES;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        self.backgroundColor = EEEEEE;
        
        UIButton * btn_voice = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toolBarVoiceBtn = btn_voice;
        btn_voice.frame = CGRectMake(5 * ScaleX_Num, (self.frame.size.height - 20 * ScaleX_Num) / 2, 20 * ScaleX_Num, 20 * ScaleX_Num);
        [btn_voice setImage:[UIImage imageNamed:@"voiceBtton"] forState:UIControlStateNormal];
        [btn_voice setImage:[UIImage imageNamed:@"keybordBtton"] forState:UIControlStateSelected];
        [btn_voice addTarget:self action:@selector(clickVoiceBtton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_voice];
        
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn_voice.frame) + 5 * ScaleX_Num, Vgap, IPHONE_WIDTH - btn_voice.size.width - 65 * ScaleX_Num, TextViewH)];
        self.textView = textView;
        textView.backgroundColor = [UIColor whiteColor];
        textView.returnKeyType = UIReturnKeySend;
        textView.layer.cornerRadius = 8;
        textView.layer.borderWidth = 0.5f;
        textView.scrollEnabled = YES;
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
        textView.layer.borderColor = C707070.CGColor;
        [self addSubview:textView];
        
        UIButton *emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toolBarEmotionBtn = emotionBtn;
        emotionBtn.frame = CGRectMake(CGRectGetMaxX(textView.frame) + 5 * ScaleX_Num, (self.frame.size.height - 20 * ScaleX_Num) / 2, 20 * ScaleX_Num, 20 * ScaleX_Num);
        [emotionBtn setImage:[UIImage imageNamed:@"expressionBtton"] forState:UIControlStateNormal];
        [emotionBtn setImage:[UIImage imageNamed:@"keybordBtton"] forState:UIControlStateSelected];
        [emotionBtn addTarget:self action:@selector(emotionBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionBtn];
        
        UIButton * btn_more = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toolBarMoreBtn = btn_more;
        btn_more.frame = CGRectMake(CGRectGetMaxX(emotionBtn.frame) + 5 * ScaleX_Num, (self.frame.size.height - 20 * ScaleX_Num) / 2, 20 * ScaleX_Num, 20 * ScaleX_Num);
        [btn_more setImage:[UIImage imageNamed:@"moreBtton"] forState:UIControlStateNormal];
        [btn_more addTarget:self action:@selector(clickMoreBtton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn_more];
        
    }
    return self;
}

-(void)emotionBtnDidClicked:(UIButton *)emotionBtn
{
    
    if ([self.delegate respondsToSelector:@selector(ToolbarEmotionBtnDidClicked:)]) {
        [self.delegate ToolbarEmotionBtnDidClicked:emotionBtn];
    }
}
-(void)clickVoiceBtton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(ToolbarVoiceBtnDidClicked:)]) {
        [self.delegate ToolbarVoiceBtnDidClicked:sender];
    }
}
-(void)clickMoreBtton:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(ToolbarMoreBtnDidClicked:)]) {
        [self.delegate ToolbarMoreBtnDidClicked:sender];
    }
}

@end

