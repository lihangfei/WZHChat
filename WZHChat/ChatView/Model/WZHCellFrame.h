//
//  WZHCellFrame.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZHChatMessage.h"

@interface WZHCellFrame : NSObject

@property(nonatomic, strong)WZHChatMessage *message;

@property(nonatomic, assign)CGFloat  cellHeight;

@property(nonatomic, assign)CGRect   emotionLabelFrame;

@property(nonatomic, assign)CGRect   headIconFrame;

@property(nonatomic, copy)  NSString *htmlURlStr;

@end
