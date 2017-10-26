//
//  UIImage+WZHExtension.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WZHExtension)

+ (UIImage *)createImageWithColor:(UIColor*)color;
/**
 *  返回一张可以随意拉伸不变形的图片
 *  @param name 图片名字
 */
+(UIImage *)stretchableImageWithImgae:(NSString *)name;
@end

