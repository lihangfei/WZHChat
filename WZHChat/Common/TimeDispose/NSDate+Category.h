//
//  NSDate+Category.h
//  
//
//  Created by 吳梓杭 on 2017/9/1.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)
/**
 获取指定年月日时分秒的NSDate
 
 @param DateStr 字符串年月日 例如:2017-09-01 14:30:50
 @return NSDate类型时间
 */
+ (NSDate *)getNowTimeStr2:(NSString *)DateStr;

/**
 获取当前日期
 
 @return 当前日期 年-月-日 星期 例如:2017-09-01 星期五
 */
+ (NSString *)getNowDate;

/**
 获取当前日期
 
 @return 当前日期 年-月-日 时分秒 例如:2017-09-01 14:30:50
 */
+ (NSString *)getNowDate:(NSDate *)date;
/**
 获取当前日期
 
 @return 当前日期 年-月-日 时分 例如:2017-09-01 14:30
 */
+ (NSString *)getNowDate3;
+ (NSString *)getNowDate4;
+ (NSString *)getNowDate5;

/**
 获取最近三个月日期
 
 @return 当前数组，包含当前月、上个月、和上上个月，格式：年月
 */
+ (NSArray *)getNowDate2;

/**
 获取当前时间
 
 @return 当前时间 时分秒 例如:14:30:50
 */
+ (NSString *)getNowTime;
/**
 获取当前时间
 
 @return 当前时间 时分 例如:14:30
 */
+ (NSString *)getNowTime2;

/**
 获取距今日某天日期
 
 @param days 据今天之后几天 之后为正数，之前为负数
 @return 未来时间 年月日 例如:今天2017-05-04 传入30 返回2017-06-03  传入-30 返回2017-04-04
 */
+ (NSString *)getFutureTime:(NSInteger)days;

/**
 获取未来某天日期
 
 @param days 根据指定日期获取指定日期之后的某日 之后为正数，之前为负数
 @param date NSDate类型的指定日期
 @return 未来时间 年月日 例如:指定日期为2017-12-31 传入1 返回为2018-01-01
 */
+ (NSString *)getFutureTime2:(NSInteger)days date:(NSDate *)date;
/**
 获取未来某天日期
 
 @param days 据今天之后的几天 之后为正数，之前为负数 例如:-1
 @return 未来时间 年月日 时分 例如:当前日期为2017-12-30 返回为2017-12-29
 */
+ (NSString *)getFutureTime2:(NSInteger)days;

/**
 获取未来某天日期
 
 @param days 根据指定日期获取指定日期之后的某日 之后为正数，之前为负数 例如:1
 @param format 字符串日期 格式年月日 例如:2017-12-02
 @return 未来时间 年月日 时分 例如:2017-12-03 当前时分秒
 */
+ (NSString *)getFutureTime3:(NSInteger)days dateFormat:(NSString *)format;

/**
 比较时间
 
 @param oneDay     时间1 年月日 2017-09-01 14:30
 @param anotherDay 时间2 年月日 2017-09-01 15:30
 
 @return 1:时间1较晚 -1:时间2较晚 0:相同
 */
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;
+(int)dateCompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 年月日后面添加时分秒
 
 @param time 传入年月日 2017-12-02
 @return 年月日 + 当前时分秒 2017-12-02 16:46:03
 */
+ (NSString *)spliceTime:(NSString *)time;

/**
 *  检查2个时间beginDate和endDate是否在seconds秒之内
 *
 *  @param beginDate 开始时间
 *  @param endDate   结束时间
 *  @param seconds   在多少秒之内
 *
 *  @return 是否在seconds秒之内
 */
- (BOOL)checkBetweenBeginTime:(NSDate*)beginDate andEndTime:(NSDate*)endDate inSeconds:(int)seconds;


/** 获取到的时间字符串转成NSDate */
+ (NSDate * )timeStringToDate: (NSString *)timeString;
/** 把NSDate转成自己需要的时间格式 */
- (NSString *)dateToRequiredString;
- (NSString *)dateToRequiredString1;

@end
