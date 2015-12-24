//
//  TGDay.h
//  日期
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 lanling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGDay : NSObject
@property(nonatomic,strong)NSMutableArray *months;
@property(nonatomic,strong) NSMutableArray *days;
@property(nonatomic,strong)NSArray *allDay;
@property(nonatomic,copy) NSString *typeName;
@property(nonatomic,strong)NSMutableArray *weeks;
@property(nonatomic,strong)NSMutableArray *weekDays;
@property(nonatomic,strong)NSMutableArray *monthDays;
@property(nonatomic,strong)NSMutableArray *years;


+ (NSArray *)allDays:(NSString *)year;

@end
