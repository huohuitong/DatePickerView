//
//  TGDay.m
//  日期
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 lanling. All rights reserved.
//

#import "TGDay.h"
@interface TGDay()
@property(nonatomic,copy) NSString *day;
@end
@implementation TGDay
//懒加载天的数组
- (NSMutableArray *)days
{
    if (!_days) {
        _days = [NSMutableArray array];
    }
    return _days;
}
- (NSMutableArray *)weekDays
{
    if (!_weekDays) {
        _weekDays = [NSMutableArray array];
    }
    return _weekDays;
}
//懒加载月的数组
- (NSMutableArray *)months
{
    if (!_months) {
        _months = [NSMutableArray array];
    }return _months;
}
- (NSMutableArray *)monthDays
{
    if (!_monthDays) {
        _monthDays = [NSMutableArray array];
    }return _monthDays;
}
//懒加载周的数组
- (NSMutableArray *)weeks
{
    if (!_weeks) {
        _weeks = [NSMutableArray array];
    }
    return _weeks;
}

+ (NSArray *)allDays:(NSString *)year
{
    TGDay *day = [[TGDay alloc] initDayWithYear:year];
    day.allDay = [day.days copy];
    day.typeName = @"日";
    TGDay *month = [[TGDay alloc] initDayWithYear:year];
    month.allDay = [day.monthDays copy];
    month.typeName = @"月";
    TGDay *week = [[TGDay alloc] initDayWithYear:year];
    week.typeName = @"周";
    week.allDay = [day.weekDays copy];
    return @[day,week,month];

}


- (void)setupDaysWithYear:(int)y
{
    int year = (y%400 == 0)||(y%4==0&&y%100!=0);
    int firstDay = 0;
    int currentDay = 0;
    int lastDay = 0;
    NSString *month = nil;
    for (int i = 1; i <= 365 + year; i++) {
        if (i <= 31 ) {
            firstDay = 1;
            currentDay = i;
            lastDay = 31;
            month = @"01";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }else if(i <= 59 + year)
        {
            firstDay = 32;
            currentDay = i - 31;
            lastDay = 28 + year;
            month = @"02";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
           
        }else if(i <= 90 + year)
        {
            firstDay = 60 + year;
            currentDay = i - 59 - year;
            lastDay = 31;
            month = @"03";
           [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];

        }else if (i <= 120 + year)
        {
            firstDay = 91 + year;
            currentDay = i - 90 - year;
            lastDay = 30;
            month = @"04";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else if (i <= 151 + year)
        {
            firstDay = 121 + year;
            currentDay = i - 120 - year;
            lastDay = 31;
            month = @"05";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
            
        }
        else if (i <= 181 + year)
        {
            firstDay = 152 + year;
            currentDay = i - 151 - year;
            lastDay = 30;
            month = @"06";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else if (i <= 212 + year)
        {
            firstDay = 182 + year;
            currentDay = i - 181 - year;
            lastDay = 31;
            month = @"07";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else if (i <= 243 + year)
        {
            firstDay = 213 + year;
            currentDay = i - 212 - year;
            lastDay = 31;
            month = @"08";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
            
        }
        else if (i <= 273 + year)
        {
            firstDay = 244 + year;
            currentDay = i - 243 - year;
            lastDay = 30;
            month = @"09";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else if (i <= 304 + year)
        {
            firstDay = 274 + year;
            currentDay = i - 273 - year;
            lastDay = 31;
            month = @"10";
            [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else if (i <= 334 + year)
        {
            firstDay = 305 + year;
            currentDay = i - 304 - year;
            lastDay = 30;
            month = @"11";
           [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
        else
        {
            firstDay = 335 + year;
            currentDay = i - 334 - year;
            lastDay = 31;
            month = @"12";
           [self setupAllDaysWithMonth:month firstDay:firstDay currentDay:currentDay lastDay:lastDay totalDay:i year:(int)y];
        }
    }
    
}
//设置周
- (void)setupWeek
{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy年-MM-dd";
    NSString *dateStr = [df stringFromDate:date];
    NSString *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    int yearInt = [year intValue];
    
//    NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
//    NSString *day = [dateStr substringWithRange:NSMakeRange(8, 2)];
    for (int i = 2015; i <= yearInt + 5  ;i++) {
        [self setupDaysWithYear:i];
       
    }
    
}
//获得当前日期的字符串
- (void)getCurrentDateStr
{
    //得到当前时间
    NSDate *date = [[NSDate alloc]init];
    //创建一个时间模板对象
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //时间格式
    df.dateFormat = @"yyyy年-MM月dd日";
    NSString *strDate = [df stringFromDate:date];
    NSString *day = [strDate substringWithRange:NSMakeRange(0, 12)];
    ///    if ([day isEqualToString:@"1790年-01月03日"]){}
    //根据当前日期获取周数组
    for (int i = 0; i < self.weeks.count; i++)
    {
        
        NSString *weekDay = [self.weeks[i] substringWithRange:NSMakeRange(0, 12)];
        
        if ([weekDay isEqualToString:@"2015年-01月05日"])
        {
            int j;
            
            for (j = i; j < self.weeks.count; j+=7)
            {
                
                [self.weekDays addObject:self.weeks[j]];
            }
            
        }
    }
    
    for (int i = 0 ;i < self.months.count ; i++)
    {
        NSString *monthDay = [self.months[i] substringWithRange:NSMakeRange(9, 2)];
        day = [strDate substringWithRange:NSMakeRange(9, 2)];
        if ([monthDay isEqualToString: @"05"])
        {
            [self.monthDays addObject:self.months[i]];
        }
        
    }
}
- (void)setupAllDaysWithMonth:(NSString *)month firstDay:(int)firstDay currentDay:(int)currentDay  lastDay:(int)lastDay totalDay:(int)totalDay year:(int)y
{
    
    int year = (y%400 == 0)||(y%4==0&&y%100!=0);
    
    //设置日
    NSString *day = currentDay > 9?[NSString stringWithFormat:@"%d年-%@月%d日",y,month,currentDay] :[NSString stringWithFormat:@"%d年-%@月0%d日",y,month,currentDay];
    
    if (totalDay == firstDay ) {
        self.day = day;
    }
    [self.days addObject:[day copy]];
    //设置周
    NSString *week = nil;
    int weekLastDay = currentDay + 6;
    
    if (weekLastDay > lastDay)
    {
        weekLastDay = weekLastDay - lastDay;
        int monthInt = [month intValue];
        monthInt = monthInt + 1;
        NSString *weekDay = weekLastDay > 9? [NSString stringWithFormat:@"%d月%d日",monthInt,weekLastDay]:[NSString stringWithFormat:@"%d月0%d日",monthInt,weekLastDay];
        week = [NSString stringWithFormat:@"%@-%@",day,weekDay];
        
        if (monthInt > 12)
        {
            y = y + 1;
            monthInt = 1;
            
            weekDay = [NSString stringWithFormat:@"%d年-%d月%d日",y,monthInt,weekLastDay];
            week = [NSString stringWithFormat:@"%@-%@",day,weekDay];
        }
    }
    else
    {
        week = [NSString stringWithFormat:@"%@-%d日",day,currentDay+6];
        
    }
    //    if ([day isEqualToString:@"1790年-01月03日"])
    //    {
    [self.weeks addObject:week];
    //    }
    //设置月
    int nextMonth = [month intValue] + 1;
    NSString *nextMonthDay = [NSString stringWithFormat:@"%@-%d月%d日",day,nextMonth,currentDay];
    if ([month isEqualToString:@"01"]&&(currentDay > (28 + year)) ) {
        nextMonthDay = [NSString stringWithFormat:@"%@-%d月%d日",day,nextMonth,28 + year];
        
    }else if(([month isEqualToString:@"03"]||[month isEqualToString:@"05"]||[month isEqualToString:@"08"]||[month isEqualToString:@"10"])&&(currentDay > 30))
    {
        nextMonthDay = [NSString stringWithFormat:@"%@-%d月%d日",day,nextMonth,30];
        
    }else
    {}
    
    if (nextMonth > 12) {
        nextMonth = 1;
        y = y+1;
        nextMonthDay = [NSString stringWithFormat:@"%@-%d年-%d月%d日",day,y,nextMonth,currentDay];
    }
    [self.months addObject:[nextMonthDay copy]];
    //判断月份补全日期
    if ([month isEqualToString:@"02"]&&(currentDay == 28 + year))
    {
        int j = 31 - 28 - year;
        for (int i = 1; i <= j; i++)
        {
            nextMonthDay = [NSString stringWithFormat:@"%@-%d月%d日",day,nextMonth,currentDay + i];
            [self.months addObject:[nextMonthDay copy]];
        }
    }else if(([month isEqualToString:@"04"]||[month isEqualToString:@"06"]||[month isEqualToString:@"09"]||[month isEqualToString:@"11"])&&(currentDay == 30))
    {
        nextMonthDay = [NSString stringWithFormat:@"%@-%d月%d日",day,nextMonth,currentDay + 1];
        [self.months addObject:nextMonthDay];
        
    }
    //所有的日期
    
    
}//设置周
//- (void)setupWeek
//{
//    for (int i = 0; i < self.days.count; i++) {
//        NSString *day = self.days[i];
//        if () {
//            
//        }
//    }
//}
- (TGDay *)initDayWithYear:(NSString *)year

{
    
    
    self = [super init];
    if (self) {
        
//        int y = [year intValue];
        //判断闰年 平年
        [self setupWeek];
//        [self setupDaysWithYear:y];
        [self getCurrentDateStr];
    }
    
    return self;
}
@end
