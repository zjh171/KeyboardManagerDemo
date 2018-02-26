//
//  CustomKeyboardView.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/2/24.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "CustomKeyboardView.h"

@interface CustomKeyboardView()

@end

@implementation CustomKeyboardView


//shuffle
-(NSArray *)shuffle:(NSArray<NSNumber *> *)array
{
    if(array == nil || array.count < 1)
        return nil;
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:array];
    NSInteger value;
    NSNumber *median;
    
    for(NSInteger index = 0; index < array.count; index ++){
        value = rand() % resultArray.count;
        median = resultArray[index];
        
        resultArray[index] = resultArray[value];
        resultArray[value] = median;
    }
    return resultArray;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        NSMutableArray *integers = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 10; ++i) {
            [integers addObject:@(i)];
        }
        NSArray  *shuffledIntegers = [self shuffle:integers];
        
        self.backgroundColor = UIColor.lightGrayColor;
        
        for (NSInteger index = 0; index < 10; ++index) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = UIColor.grayColor ;
            [btn addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectMake(CGRectGetWidth(self.frame) / 3 * (index % 3 ), 45 *  (index / 3 ) , CGRectGetWidth(self.frame) / 3 - 1, 44);
            NSString *indexString = [NSString stringWithFormat:@"%@",shuffledIntegers[index]];
            [btn setTitle:indexString forState:UIControlStateNormal];
            [self addSubview:btn];
        }
        
    }
    return self;
}


-(void)buttonDidClicked:(UIButton *) sender{
    if (self.delegate) {
        [self.delegate keyboardItemDidClicked:sender.titleLabel.text];
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
}







@end
