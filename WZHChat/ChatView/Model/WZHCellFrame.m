//
//  WZHCellFrame.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHCellFrame.h"


@implementation WZHCellFrame

-(void)setMessage:(WZHChatMessage *)message{
    _message = message;
    //匹对字符串，获取富文本
    NSMutableAttributedString *text = [WZHChangeStrTool changeStrWithStr:message.text Font:[UIFont systemFontOfSize:16] TextColor:C333333];
    //文字自适应
    CGSize TextSize = [text boundingRectWithSize:CGSizeMake(IPHONE_WIDTH - 122 * ScaleX_Num, IPHONE_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.message.attributedText = (NSMutableAttributedString*)text;
    NSString *htmlStr = [WZHChangeStrTool changeTextToHtmlStrWithText:message.text];
    self.htmlURlStr = htmlStr;
    NSLog(@"htmlStr ===== %@\nmessage.text ===== %@",htmlStr,message.text);
    
    //匹对字符串，获取富文本
    NSMutableAttributedString *text1 = [WZHChangeStrTool changeStrWithStr:htmlStr Font:[UIFont systemFontOfSize:16] TextColor:C333333];
    //文字自适应
    CGSize TextSize1 = [text1 boundingRectWithSize:CGSizeMake(IPHONE_WIDTH - 122 * ScaleX_Num, IPHONE_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    //计算控件frame
    if ([self.guestStr intValue] == 1) {
        self.emotionLabelFrame = CGRectMake(20 * ScaleX_Num, 8 * ScaleX_Num, TextSize1.width, TextSize1.height);
    }else{
        self.emotionLabelFrame = CGRectMake(9 * ScaleX_Num, 8 * ScaleX_Num, TextSize1.width, TextSize1.height);
    }
    //计算cell高度
    self.cellHeight = TextSize.height + 10;
    NSLog(@"%f\n %f",text.size.width,text.size.height);
    self.messageWidth = TextSize1.width;
    self.messageHight = TextSize1.height;
}


@end
