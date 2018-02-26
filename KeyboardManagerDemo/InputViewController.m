//
//  InputViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/1/30.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "InputViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface InputViewController ()

@property (nonatomic, strong) UITextField *xTextField;
@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
#define kTextFieldHeight 40
    self.xTextField.frame = CGRectMake(15, SCREEN_HEIGHT - kTextFieldHeight, SCREEN_WIDTH - 30, kTextFieldHeight);
    self.xTextField.layer.borderColor = UIColor.grayColor.CGColor;
    self.xTextField.layer.borderWidth = 1.f;
    self.xTextField.layer.cornerRadius = 12.f;
    //Set cursor location
    self.xTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.xTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.xTextField.placeholder = @"Please Input Here";
    [self.view addSubview:self.xTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)handleKeyboardNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
//    CGRect keyboardScreenBeginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue] ;
    CGRect keyboardScreenEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame = self.xTextField.frame;
        frame.origin.y = keyboardScreenEndFrame.origin.y - kTextFieldHeight;
        self.xTextField.frame = frame;
    } completion:^(BOOL finished) {
        ;
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.xTextField resignFirstResponder];
}

-(UITextField *)xTextField{
    if (!_xTextField) {
        _xTextField = [[UITextField alloc] init];
    }
    return _xTextField;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
