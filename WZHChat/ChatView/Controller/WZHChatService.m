//
//  WZHChatService.m
//  
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHChatService.h"

#define COMPARETIMESTR     @"compareTimeStr"
@implementation WZHChatService
@synthesize compareTimeStr = _compareTimeStr;

+(WZHChatService *)sharedInstance{
    static WZHChatService *service = nil;
    if(service){
        return service;
    }
    
    service = [[WZHChatService alloc] init];
    return service;
}

- (void)WZHChatServiceUrl:(NSString *)url dictionary:(NSDictionary *) dic success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",InterHeard,url];
    
    [PPNetworkHelper GET:urlStr parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    }];
    
}
-(BOOL)accessUserDefaultWithKey:(NSString *)key{
    id isValue =GetUserValue(key);
    return (isValue) ? YES : NO;
}

-(NSString *)compareTimeStr{
    if (!_compareTimeStr) {
        BOOL isCompareTimeStr = [self accessUserDefaultWithKey:COMPARETIMESTR];
        _compareTimeStr =(isCompareTimeStr) ? GetUserValue(COMPARETIMESTR) : nil;
    }
    return _compareTimeStr;
}
@end
