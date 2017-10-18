//
//  WZHCellFrame.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHCellFrame.h"


@implementation WZHCellFrame

-(void)setMessage:(WZHChatMessage *)message
{
    _message = message;
    
    if ([message.type isEqualToString:@"message"]) {
        
//        匹对字符串，获取富文本
        NSMutableAttributedString *text = [WZHChangeStrTool changeStrWithStr:message.text Font:[UIFont systemFontOfSize:20] TextColor:[UIColor blackColor]];
        CGSize maxsize = CGSizeMake(IPHONE_WIDTH - 20, MAXFLOAT);
//        文字自适应
        CGSize TextSize = [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//        CGSize TextSize = [self getSizeWithFont:[UIFont systemFontOfSize:17] andText:message.text];

        self.message.attributedText = (NSMutableAttributedString*)text;
        
        NSString *htmlStr = [WZHChangeStrTool changeTextToHtmlStrWithText:message.text];
        
        self.htmlURlStr = htmlStr;
        
        //计算控件frame
        self.emotionLabelFrame = CGRectMake(10, 5, TextSize.width  , TextSize.height);
        
        //计算cell高度
        self.cellHeight = TextSize.height + 10;
    
    }
}

//动态计算size方法
- (CGSize )getSizeWithFont:(UIFont *)font andText:(NSString *)text{
    
    //动态计算label的宽度
    NSDictionary *dict = @{NSFontAttributeName:font};
    
    CGSize maxsize = CGSizeMake(IPHONE_WIDTH - 20 , MAXFLOAT);
    
    CGSize size = [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size;
}

@end
