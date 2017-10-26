//
//  WZHChatService.h
//  
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZHChatService : NSObject{
    NSString * _compareTimeStr;
}
@property(nonatomic,strong)NSString * compareTimeStr;

+(WZHChatService *)sharedInstance;

- (void)WZHChatServiceUrl:(NSString *)url dictionary:(NSDictionary *) dic success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
