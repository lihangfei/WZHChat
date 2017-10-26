//
//  NSDate+Category.m
//  
//
//  Created by 吳梓杭 on 2017/9/1.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "NSDate+Category.h"
#import "HHDateFormatter.h"
#import "HHCalender.h"

@implementation NSDate (Category)

/**
 获取指定年月日时分秒的NSDate
 
 @param DateStr 字符串年月日 例如:2017-09-01 14:30:50
 @return NSDate类型时间
 */
+ (NSDate *)getNowTimeStr2:(NSString *)DateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:DateStr];
    return date;
}

/**
 获取当前日期
 
 @return 当前日期 年-月-日 星期 例如:2017-09-01 星期五
 */
+ (NSString *)getNowDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"YYYY-MM-dd EEE"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return nowDate;
}

/**
 获取当前日期
 
 @return 当前日期 年-月-日 时分秒 例如:2017-09-01 14:30:50
 */
+ (NSString *)getNowDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return nowDate;
}
/**
 获取当前日期
 
 @return 当前日期 年-月-日 时分 例如:2017-09-01 14:30
 */
+ (NSString *)getNowDate3{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return nowDate;
}
+ (NSString *)getNowDate4{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return nowDate;
}
+ (NSString *)getNowDate5{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    return nowDate;
}

/**
 获取最近三个月日期
 
 @return 当前数组，包含当前月、上个月、和上上个月，格式：年月
 */
+ (NSArray *)getNowDate2{
    NSMutableArray * dateArr = [NSMutableArray array];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"YYYY-MM"];
    
    NSString * nowDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    NSArray * arr = [nowDate componentsSeparatedByString:@"-"];
    NSString * year = [arr firstObject];
    NSString * month = [arr lastObject];
    
    if([month integerValue] == 1){
        [dateArr addObject:nowDate];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%@",[year integerValue]-1,@"12"]];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%@",[year integerValue]-1,@"11"]];
    }else if([month integerValue] == 2){
        [dateArr addObject:nowDate];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%@",[year integerValue]-1,@"01"]];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%@",[year integerValue]-1,@"12"]];
    }else{
        [dateArr addObject:nowDate];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%02ld",(long)[year integerValue],[month integerValue]-1]];
        [dateArr addObject:[NSString stringWithFormat:@"%ld-%02ld",(long)[year integerValue],[month integerValue]-2]];
    }
    return dateArr;
}

/**
 获取当前时间
 
 @return 当前时间 时分秒 例如:14:30:50
 */
+ (NSString *)getNowTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"HH:mm:ss"];
    
    return [formatter stringFromDate:date];
}
/**
 获取当前时间
 
 @return 当前时间 时分 例如:14:30
 */
+ (NSString *)getNowTime2{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"HH:mm"];
    
    return [formatter stringFromDate:date];
}

/**
 获取距今日某天日期
 
 @param days 据今天之后几天 之后为正数，之前为负数
 @return 未来时间 年月日 例如:今天2017-05-04 传入30 返回2017-06-03  传入-30 返回2017-04-04
 */
+ (NSString *)getFutureTime:(NSInteger)days{
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:days*24*60*60 sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * nextDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:nextDay]];
    return nextDate;
}

/**
 获取未来某天日期
 
 @param days 根据指定日期获取指定日期之后的某日 之后为正数，之前为负数
 @param date NSDate类型的指定日期
 @return 未来时间 年月日 例如:指定日期为2017-12-31 传入1 返回为2018-01-01
 */
+ (NSString *)getFutureTime2:(NSInteger)days date:(NSDate *)date{
    NSDate *nextDay = [NSDate dateWithTimeInterval:days*24*60*60 sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * nextDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:nextDay]];
    return nextDate;
}
/**
 获取未来某天日期
 
 @param days 据今天之后的几天 之后为正数，之前为负数 例如:-1
 @return 未来时间 年月日 时分 例如:当前日期为2017-12-30 返回为2017-12-29
 */
+ (NSString *)getFutureTime2:(NSInteger)days{
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:days*24*60*60 sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString * nextDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:nextDay]];
    return nextDate;
}

/**
 获取未来某天日期
 
 @param days 根据指定日期获取指定日期之后的某日 之后为正数，之前为负数 例如:1
 @param format 字符串日期 格式年月日 例如:2017-12-02
 @return 未来时间 年月日 时分 例如:2017-12-03 当前时分秒
 */
+ (NSString *)getFutureTime3:(NSInteger)days dateFormat:(NSString *)format{
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:days*24*60*60 sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:format];
    NSString * nextDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:nextDay]];
    return nextDate;
}

/**
 比较时间
 
 @param oneDay     时间1 年月日 2017-09-01 14:30
 @param anotherDay 时间2 年月日 2017-09-01 15:30
 
 @return 1:时间1较晚 -1:时间2较晚 0:相同
 */
+(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        NSLog(@"Date2较早");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"Date1较早");
        return -1;
    }else{
        NSLog(@"Both dates are the same");
        return 0;
    }
}
+(int)dateCompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSComparisonResult result = [oneDay compare:anotherDay];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        NSLog(@"Date2较早");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"Date1较早");
        return -1;
    }else{
        NSLog(@"Both dates are the same");
        return 0;
    }
}
/**
 年月日后面添加时分秒
 
 @param time 传入年月日 2017-12-02
 @return 年月日 + 当前时分秒 2017-12-02 16:46:03
 */
+ (NSString *)spliceTime:(NSString *)time{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateStyle=kCFDateFormatterMediumStyle;
    formatter.timeStyle=kCFDateFormatterShortStyle;
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString * spliceDate = [NSString stringWithFormat:@"%@ %@",time,[formatter stringFromDate:date]];
    
    return spliceDate;
}

#pragma mark- 检查2个时间beginDate和endDate是否在seconds秒之内
- (BOOL)checkBetweenBeginTime:(NSDate*)beginDate andEndTime:(NSDate*)endDate inSeconds:(int)seconds
{
    double withinSeconds = fabs([beginDate timeIntervalSinceDate:endDate]);
    
    if (withinSeconds > seconds) {
        
        return NO;
        
    }else{
        
        return YES;
    }
    
}

#pragma mark- 返回一字符串是多久之前：刚刚，5秒前，1分钟前，1小时前等等
+ (NSDate *)timeStringToDate: (NSString *)timeString {
    /** /// "YYYY-MM-dd HH:mm:ss",根据回调的时间字符串制定不一样的日期格式 */
    NSString * formatterString = @"YYYY-MM-dd HH:mm:ss";
    /** DateFormatter, Calendar初始化比较消耗内存, 定义成单例 */
    [HHDateFormatter sharedFormatter].dateFormat = formatterString;
    /** 指定区域，真机一定要指定 */
    [HHDateFormatter sharedFormatter].locale = [NSLocale localeWithLocaleIdentifier: @"en"];
    
    return [[HHDateFormatter sharedFormatter] dateFromString: timeString];
}

- (NSString *)dateToRequiredString {
    if ([[HHCalender sharedCalender] isDateInToday:self]) {
        //如果是今天
        int seconds = [[NSDate date] timeIntervalSinceDate:self];
        if (seconds < 60) {
            return @"刚刚";
        } else if (seconds < 60 * 60) {
            return [NSString stringWithFormat:@"%d分钟前", seconds / 60];
        } else {
            return [NSString stringWithFormat:@"%d小时前", seconds / 3600];
        }
    } else if ([[HHCalender sharedCalender] isDateInYesterday:self]) {
        //如果是昨天 10: 10
        [HHDateFormatter sharedFormatter].dateFormat = @"昨天 HH:mm:ss";
        [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
        return [[HHDateFormatter sharedFormatter] stringFromDate:self];
    } else {
        //首先要取到今年是哪一年 2017
        //再取到当前的date是哪一年, 再做比较
        NSInteger thisYear = [[HHCalender sharedCalender] component:NSCalendarUnitYear fromDate: [NSDate date]];
        NSInteger dateYear = [[HHCalender sharedCalender] component:NSCalendarUnitYear fromDate: self];
        //是今年
        if (thisYear == dateYear) {
            [HHDateFormatter sharedFormatter].dateFormat = @"MM-dd HH:mm:ss";
            [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
            return [[HHDateFormatter sharedFormatter] stringFromDate:self];
        }
        //往年
        else {
            [HHDateFormatter sharedFormatter].dateFormat = @"yyyy-MM-dd HH:mm:ss";
            [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
            return [[HHDateFormatter sharedFormatter] stringFromDate:self];
        }
    }
}
- (NSString *)dateToRequiredString1 {
    if ([[HHCalender sharedCalender] isDateInToday:self]) {
        //今天
        [HHDateFormatter sharedFormatter].dateFormat = @"HH:mm";
        [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
        return [[HHDateFormatter sharedFormatter] stringFromDate:self];
    } else if ([[HHCalender sharedCalender] isDateInYesterday:self]) {
        //如果是昨天 10: 10
        [HHDateFormatter sharedFormatter].dateFormat = @"昨天 HH:mm";
        [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
        return [[HHDateFormatter sharedFormatter] stringFromDate:self];
    } else {
        //首先要取到今年是哪一年 2017
        //再取到当前的date是哪一年, 再做比较
        NSInteger thisYear = [[HHCalender sharedCalender] component:NSCalendarUnitYear fromDate: [NSDate date]];
        NSInteger dateYear = [[HHCalender sharedCalender] component:NSCalendarUnitYear fromDate: self];
        //是今年
        if (thisYear == dateYear) {
            [HHDateFormatter sharedFormatter].dateFormat = @"MM-dd HH:mm";
            [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
            return [[HHDateFormatter sharedFormatter] stringFromDate:self];
        }
        //往年
        else {
            [HHDateFormatter sharedFormatter].dateFormat = @"yyyy-MM-dd HH:mm";
            [HHDateFormatter sharedFormatter].locale =  [NSLocale localeWithLocaleIdentifier: @"en"];
            return [[HHDateFormatter sharedFormatter] stringFromDate:self];
        }
    }
}


@end
