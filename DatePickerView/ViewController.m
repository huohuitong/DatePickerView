//
//  ViewController.m
//  DatePickerView
//
//  Created by LLMac on 15/12/24.
//  Copyright © 2015年 com.bloveambition. All rights reserved.
//
#import "ViewController.h"
#import "TGDay.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *allDays;
@property(nonatomic,strong)NSArray *secondDay;
@property(nonatomic,copy)NSString *currentDate;
///显示年文本
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
///显示日期文本
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerBottomConstraint;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property(nonatomic,strong)NSString *yearStr;
@property(nonatomic,strong)NSString *dateStr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCurrentDate];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerBottomConstraint.constant = -162;
    self.toolBar.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark -- 点击按钮选择日期
- (IBAction)clickButton:(id)sender {
    self.pickerBottomConstraint.constant = 0;
    self.toolBar.hidden = NO;
}
#pragma mark -- 取消选择
- (IBAction)cancelSelect:(id)sender {
    self.pickerBottomConstraint.constant = -162;
    self.toolBar.hidden = YES;
}
#pragma mark -- 确定选择
- (IBAction)ensureSelect:(id)sender {
    self.pickerBottomConstraint.constant = -162;
    self.toolBar.hidden = YES;
    self.yearLabel.text = self.yearStr;
    self.dateLabel.text = self.dateStr;
}
//设置当前时间
- (void)setupCurrentDate
{
    //得到当前时间
    NSDate *date = [[NSDate alloc]init];
    //创建一个时间模板对象
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //时间格式
    df.dateFormat = @"yyyy年-MM月dd日";
    NSString *strDate = [df stringFromDate:date];
    NSString *year = [strDate substringWithRange:NSMakeRange(0, 4)];
    self.currentDate = [strDate substringWithRange:NSMakeRange(0, 12)];
    //    self.currentDate = @"2015年-11月31日";
    self.allDays = [TGDay allDays:year];
    //设置默认情况下pickerView
    TGDay *day  = self.allDays[0];
    self.secondDay = day.allDay;
    
}
-(instancetype)initWithYear:(NSString*)year;
{
    self = [super init];
    if (self) {
        self.allDays = [TGDay allDays:year];
    }return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.allDays.count;
    }else
    {
        return self.secondDay.count;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        TGDay *day = self.allDays[row];
        
        [self pickerView:pickerView didSelectRow:row inComponent:component];
        return day.typeName;
    }else{
        if ([pickerView selectedRowInComponent:0]==0){
            NSString *day = [self.secondDay[row] substringFromIndex:6];
            self.dateStr=day;
            return day;
        }else if ([pickerView selectedRowInComponent:0] == 1){
            NSInteger index = [self.pickerView selectedRowInComponent:1];
            NSString *daySecond = self.secondDay[index];
            NSString *day = self.secondDay[row];
            if (day.length==23 && daySecond.length == 23) {
                NSString *weekFirst = [self.secondDay[row] substringWithRange:NSMakeRange(6, 7)];
                
                NSString *weeksecond = [self.secondDay[row] substringFromIndex:19];
                NSString *firstWeek = [self.secondDay[index] substringWithRange:NSMakeRange(6, 7)];
                NSString *secondWeek = [self.secondDay[index] substringFromIndex:19];
                self.dateStr=[firstWeek stringByAppendingString:secondWeek];
                return [weekFirst stringByAppendingString:weeksecond];
            }else if(day.length < 23 &&daySecond.length < 23){
                
                NSString *weekFirst = [self.secondDay[row] substringFromIndex:6];
                self.dateStr = [self.secondDay[index] substringFromIndex:6];
                return weekFirst;
                
            }else if (day.length < 23 && daySecond.length == 23){
                
                NSString *weekFirst = [self.secondDay[row] substringFromIndex:6];
                NSString *firstWeek = [self.secondDay[index] substringWithRange:NSMakeRange(6, 7)];
                NSString *secondWeek = [self.secondDay[index] substringFromIndex:19];
                self.dateStr=[firstWeek stringByAppendingString:secondWeek];
                return weekFirst;
            }else{
                NSString *weekFirst = [self.secondDay[row] substringWithRange:NSMakeRange(6, 7)];
                
                NSString *weeksecond = [self.secondDay[row] substringFromIndex:19];
                self.dateStr = [self.secondDay[index] substringFromIndex:6];
                return [weekFirst stringByAppendingString:weeksecond];
            }
        }else{
            NSInteger index = [self.pickerView selectedRowInComponent:1];
            NSString *month = [self.secondDay[row] substringWithRange:NSMakeRange(6, 3)];
            self.dateStr=[self.secondDay[index] substringWithRange:NSMakeRange(6, 3)];
            self.yearStr = [self.secondDay[index] substringToIndex:4];
            return month;
        }
        
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    int secondRow = 0;
    if (component == 0)
    {
        TGDay *selectedDay = self.allDays[row];
        self.secondDay = selectedDay.allDay;
        NSString *str = nil;
        for (int i = 0 ; i < self.secondDay.count; i++)
        {
            str = self.secondDay[i];
            NSString *date = [str substringWithRange:NSMakeRange(0,12)];
            
            if ([date isEqualToString:self.currentDate])
            {
                secondRow = i;
            }
            
            if (row == 1)
            {
                NSString *currentYear = [self.currentDate substringWithRange:NSMakeRange(0, 4)];
                NSString *year = [str substringWithRange:NSMakeRange(0, 4)];
                if (str.length > 26) {
                    year = [str substringWithRange:NSMakeRange(13, 4)];
                }
                int currentYearNum = [currentYear intValue];
                int yearNum = [year intValue];
                
                if ([year isEqualToString:currentYear])
                {
                    //取出当前时间月份
                    NSString *currentMonth = [self.currentDate substringWithRange:NSMakeRange(6, 2)];
                    NSString *currentMonthFirst = [self.currentDate substringWithRange:NSMakeRange(6, 1)];
                    if ([currentMonthFirst isEqualToString:@"0"]) {
                        currentMonth = [self.currentDate substringWithRange:NSMakeRange(7, 1)];
                        
                    }
                    int currentMonthNum = [currentMonth intValue];
                    //待选中的月份
                    NSString *month = [str substringWithRange:NSMakeRange(6, 2)];
                    NSString *monthFirst = [str substringWithRange:NSMakeRange(6, 1)];
                    if ([monthFirst isEqualToString:@"0"]) {
                        month = [str substringWithRange:NSMakeRange(7, 1)];
                    }
                    int monthNum = [month intValue];
                    //当前时间日期
                    NSString *currentDay = [self.currentDate substringWithRange:NSMakeRange(9, 2)];
                    NSString *currentDayFirst = [currentDay substringWithRange:NSMakeRange(0, 1)];
                    if ([currentDayFirst isEqualToString:@"0"])
                    {
                        currentDay = [currentDay substringWithRange:NSMakeRange(1, 1)];
                    }
                    int currentDayNum = [currentDay intValue];
                    //待选周中日期最小日期
                    NSString *dayMin = [str substringWithRange:NSMakeRange(9, 2)];
                    NSString *dayMinFirst = [dayMin substringWithRange:NSMakeRange(0, 1)];
                    if ([dayMinFirst isEqualToString:@"0"])
                    {
                        dayMin = [dayMin substringWithRange:NSMakeRange(1, 1)];
                    }
                    int dayMinNum = [dayMin intValue];
                    //待选周中的最大日期
                    NSString *dayMax = [str substringWithRange:NSMakeRange(13, 2)];
                    if (str.length > 20) {
                        dayMax = [str substringWithRange:NSMakeRange(16, 2)];
                    }
                    //    if (str.length > 26) {
                    //        dayMax = [str substringWithRange:NSMakeRange(22, 2)];
                    //
                    //    }
                    NSString *dayMaxFirst = [dayMax substringWithRange:NSMakeRange(0, 1)];
                    if ([dayMaxFirst isEqualToString:@"0"])
                    {
                        dayMax = [dayMax substringWithRange:NSMakeRange(1, 1)];
                    }
                    
                    int dayMaxNum = [dayMax intValue];
                    //判断月份相等时情况
                    if (monthNum == currentMonthNum)
                    {
                        
                        if (currentDayNum >= dayMinNum &&currentDayNum <= dayMaxNum)
                        {
                            secondRow = i;
                            
                        }
                        else if(currentDayNum >=dayMinNum && currentDayNum >= dayMaxNum&&currentDayNum >= 22)
                        {
                            secondRow = i;
                            
                        }
                    } else if((monthNum + 1 == currentMonthNum)&&((currentDayNum <= dayMinNum && currentDayNum <= dayMaxNum)&&currentDayNum <=6))  //不在同一月时的情况
                    {
                        secondRow = i;
                    }
                    
                    
                    //年份相等时
                    
                }
                else if (yearNum + 1 == currentYearNum)
                {
                    
                    //取出当前时间月份
                    NSString *currentMonth = [self.currentDate substringWithRange:NSMakeRange(6, 2)];
                    NSString *currentMonthFirst = [self.currentDate substringWithRange:NSMakeRange(6, 1)];
                    if ([currentMonthFirst isEqualToString:@"0"]) {
                        currentMonth = [self.currentDate substringWithRange:NSMakeRange(7, 1)];
                        
                    }
                    int currentMonthNum = [currentMonth intValue];
                    //当前时间日期
                    NSString *currentDay = [self.currentDate substringWithRange:NSMakeRange(9, 2)];
                    NSString *currentDayFirst = [currentDay substringWithRange:NSMakeRange(0, 1)];
                    if ([currentDayFirst isEqualToString:@"0"])
                    {
                        currentDay = [currentDay substringWithRange:NSMakeRange(1, 1)];
                    }
                    int currentDayNum = [currentDay intValue];
                    //待选周中日期最小日期
                    NSString *dayMin = [str substringWithRange:NSMakeRange(9, 2)];
                    NSString *dayMinFirst = [dayMin substringWithRange:NSMakeRange(0, 1)];
                    if ([dayMinFirst isEqualToString:@"0"])
                    {
                        dayMin = [dayMin substringWithRange:NSMakeRange(1, 1)];
                    }
                    int dayMinNum = [dayMin intValue];
                    //待选周中的最大日期
                    NSString *dayMax = [str substringWithRange:NSMakeRange(13, 2)];
                    if (str.length > 20) {
                        dayMax = [str substringWithRange:NSMakeRange(16, 2)];
                    }
                    if (str.length > 26) {
                        dayMax = [str substringWithRange:NSMakeRange(22, 2)];
                        
                    }
                    NSString *dayMaxFirst = [dayMax substringWithRange:NSMakeRange(0, 1)];
                    if ([dayMaxFirst isEqualToString:@"0"])
                    {
                        dayMax = [dayMax substringWithRange:NSMakeRange(1, 1)];
                    }
                    
                    int dayMaxNum = [dayMax intValue];
                    
                    
                    if (currentMonthNum == 1&&(currentDayNum <= dayMinNum &&currentDayNum <=dayMaxNum)) {
                        secondRow = i;
                    }
                }
                
            }
            else if (row == 2){
                NSString *currentYear = [self.currentDate substringWithRange:NSMakeRange(0, 4)];
                NSString *year = [str substringWithRange:NSMakeRange(0, 4)];
                if ([year isEqualToString:currentYear]){
                    //取出当前时间月份
                    NSString *currentMonth = [self.currentDate substringWithRange:NSMakeRange(6, 2)];
                    //待选中的月份
                    NSString *month = [str substringWithRange:NSMakeRange(6, 2)];
                    //判断月份相等时情况
                    if ([month isEqualToString:currentMonth]){
                        secondRow = i;
                        //                        self.dateStr = [NSString stringWithFormat:@"%@月",month];
                    }
                    
                }
            }
        }
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:secondRow inComponent:1 animated:YES];
        
        
    }else
    {   if ([pickerView selectedRowInComponent:0] == 0){
        NSString *day = [self.secondDay[row] substringFromIndex:6];
        self.dateStr = day;
    }else if ([pickerView selectedRowInComponent:0] == 1){
        NSString *day = self.secondDay[row];
        if (day.length==23) {
            NSString *weekFirst = [self.secondDay[row] substringWithRange:NSMakeRange(6, 7)];
            NSString *weeksecond = [self.secondDay[row] substringFromIndex:19];
            self.dateStr=[weekFirst stringByAppendingString:weeksecond];
        }else {
            
            NSString *weekFirst = [self.secondDay[row] substringFromIndex:6];
            self.dateStr = weekFirst;
        }
    }else if ([pickerView selectedRowInComponent:0] == 2){
        NSString *month = [self.secondDay[row] substringWithRange:NSMakeRange(6, 3)];
        
        self.dateStr = month;
        
    }
        
    }
    self.yearStr= [self.secondDay[[pickerView selectedRowInComponent:1]] substringToIndex:4];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentFirst = 100;
    if (component == 0) {
        return componentFirst;
    }else
    {
        return self.view.bounds.size.width - componentFirst;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
