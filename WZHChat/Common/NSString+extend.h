//
//  NSString+extend.h
//  ZPDSProject
//
//  Created by izhongpei on 16/5/12.
//  Copyright © 2016年 广东中配互联网科技公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extend)
+ (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font size:(CGSize)maxsize;

+ (CGFloat)heightForContentText:(NSString *)string AndFontSize:(CGFloat)font size:(CGSize)maxsize;

+ (NSString *)filterHTML:(NSString *)html;
@end
