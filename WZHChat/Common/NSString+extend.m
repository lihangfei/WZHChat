//
//  NSString+extend.m
//  ZPDSProject
//
//  Created by izhongpei on 16/5/12.
//  Copyright © 2016年 广东中配互联网科技公司. All rights reserved.
//

#import "NSString+extend.h"

@implementation NSString (extend)
//计算文字所占大小
+ (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font size:(CGSize)maxsize
{
    CGSize size = [string boundingRectWithSize:maxsize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}
+ (CGFloat)heightForContentText:(NSString *)string AndFontSize:(CGFloat)font size:(CGSize)maxsize{
    CGFloat size = [string boundingRectWithSize:maxsize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    
    return size;
}
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
