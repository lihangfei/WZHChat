//
//  NSAttributedString+WZHEmojiExtension.m
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+WZHEmojiExtension.h"
#import "WZHTextAttachment.h"

@implementation NSAttributedString (EmojiExtension)

//用来获取textview中的字符串（本质就是遍历富文本，把其中的附件替换成文本，比如：你好呀[开心]）
- (NSString *)getPlainString {
    
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(WZHTextAttachment *value, NSRange range, BOOL *stop) {
                      if (value) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:value.emojiTag];
                          base += value.emojiTag.length - 1;
                      }
                  }];
    return plainString;
}

@end

