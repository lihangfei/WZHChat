//
//  WZHInformationModel.h
//  
//
//  Created by 吳梓杭 on 2017/10/23.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHInformationModel : NSObject

@property(nonatomic,assign)NSString * timeStr;      //消息时间
@property(nonatomic,assign)NSString * headerStr;    //头像
@property(nonatomic,assign)NSString * nameStr;      //昵称
@property(nonatomic,assign)NSString * guestStr;      //非本人：1   本人：0
@property(nonatomic,assign)NSString * memberIdStr;

@end
