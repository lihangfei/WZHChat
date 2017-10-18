//
//  WZHChatMessage.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHChatMessage : NSObject

@property(copy,nonatomic)NSString *text;

@property(copy,nonatomic)NSString *type;

@property(nonatomic, copy)NSMutableAttributedString *attributedText;


@end
