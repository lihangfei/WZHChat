//
//  WZHTextAttachment.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHTextAttachment.h"

#define emotionRate 1.0

@implementation WZHTextAttachment

//在这个方法里返回附件的位置
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    
    //    self.emotionRect = CGRectMake(position.x, position.y + 0.5, _emojiSize.width * emotionRate, _emojiSize.height * emotionRate);
    
    return CGRectMake(0, -4, _emojiSize.width * emotionRate, _emojiSize.height * emotionRate);
}


@end

