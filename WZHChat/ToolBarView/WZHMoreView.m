//
//  WZHMoreView.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHMoreView.h"

@implementation WZHMoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSMutableArray * moreImageArray = [NSMutableArray arrayWithObjects:@"icon_Album",@"icon_Photograph", nil];
        NSMutableArray * moreTitleArray = [NSMutableArray arrayWithObjects:@"相册",@"拍摄", nil];
        for (int i = 0; i < moreImageArray.count; i ++) {
            UIButton * btn_moreWay = [UIButton buttonWithType:UIButtonTypeCustom];
            self.moreWayButton = btn_moreWay;
            btn_moreWay.frame = CGRectMake((IPHONE_WIDTH - 4 * 40 * ScaleX_Num) / 5 + ((IPHONE_WIDTH - 4 * 40 * ScaleX_Num) / 5 + 40 * ScaleX_Num) * i , 30 * ScaleY_Num, 40 * ScaleX_Num, 40 * ScaleY_Num);
            [btn_moreWay setImage:[UIImage imageNamed:moreImageArray[i]] forState:UIControlStateNormal];
            [btn_moreWay addTarget:self action:@selector(clickMoreWayBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn_moreWay.tag = 901 + i;
            [self addSubview:btn_moreWay];
            
            UILabel * lab_titile = [[UILabel alloc] initWithFrame:CGRectMake((IPHONE_WIDTH - 4 * 40 * ScaleX_Num) / 5 + ((IPHONE_WIDTH - 4 * 40 * ScaleX_Num) / 5 + 40 * ScaleX_Num) * i , CGRectGetMaxY(btn_moreWay.frame) + 5 * ScaleY_Num, 40 * ScaleX_Num, 14 * ScaleY_Num)];
            lab_titile.text = moreTitleArray[i];
            lab_titile.textColor = CCCCCC;
            lab_titile.font = UIFONT_SYS(14);
            lab_titile.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lab_titile];
        }
    }
    return self;
}
-(void)clickMoreWayBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(MoreWayBtnDidClicked:)]) {
        [self.delegate MoreWayBtnDidClicked:sender];
    }
}

@end
