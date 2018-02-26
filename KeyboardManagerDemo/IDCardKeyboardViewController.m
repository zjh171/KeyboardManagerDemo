//
//  IDCardKeyboardViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/2/24.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "IDCardKeyboardViewController.h"
#import "UITextField+Util.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface IDCardKeyboardViewController ()

@property (nonatomic, strong) UITextField *xTextField;
@property (nonatomic, strong) UIButton *extrakeyButton;

@end

#define kXButtonHeight 40

@implementation IDCardKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
#define kTextFieldHeight 40
    self.xTextField.frame = CGRectMake(15, 85, SCREEN_WIDTH - 30, kTextFieldHeight);
    self.xTextField.layer.borderColor = UIColor.grayColor.CGColor;
    self.xTextField.layer.borderWidth = 1.f;
    self.xTextField.layer.cornerRadius = 12.f;
    self.xTextField.keyboardType = UIKeyboardTypeNumberPad;

    //Set cursor location
    self.xTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.xTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.xTextField.placeholder = @"Please Input Here";
    [self.view addSubview:self.xTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow:(NSNotification *)notification{
    [self.extrakeyButton removeFromSuperview];
    self.extrakeyButton     = nil;
    NSDictionary *userInfo  = [notification userInfo];
    CGFloat animationDuration   = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect kbEndFrame           = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbHeight            = kbEndFrame.size.height;
    CGFloat extrakeyButtonX = 0;
    CGFloat extrakeyButtonW = 0;
    CGFloat extrakeyButtonH = 0;
    extrakeyButtonW = (SCREEN_WIDTH - 7) / 3;
    extrakeyButtonH = kbHeight / 4;

    CGFloat extrakeyButtonY = 0;
    extrakeyButtonY = SCREEN_HEIGHT + kbHeight - extrakeyButtonH;
    //init here
    self.extrakeyButton = [[UIButton alloc] initWithFrame:CGRectMake(extrakeyButtonX, extrakeyButtonY, extrakeyButtonW, extrakeyButtonH)];
    [self.extrakeyButton addTarget:self action:@selector(buttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.extrakeyButton.titleLabel.font = [UIFont systemFontOfSize:27];
    [self.extrakeyButton setTitle:@"X" forState:(UIControlStateNormal)];
    [self.extrakeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //add to window
    UIWindow *tempWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [tempWindow addSubview:self.extrakeyButton];
    //animate
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame    = self.extrakeyButton.frame;
        frame.origin.y  = frame.origin.y - kbHeight;
        self.extrakeyButton.frame = frame;
    } completion:nil];
}


-(void)keyboardWillHide:(NSNotification *)notification{
    self.extrakeyButton.transform = CGAffineTransformIdentity;
    [self.extrakeyButton removeFromSuperview];
}

- (void)buttonDidClicked{
    NSUInteger insertIndex = [self.xTextField selectedRange].location;
    NSMutableString *string = [NSMutableString stringWithString:self.xTextField.text];
    [string replaceCharactersInRange:self.xTextField.selectedRange withString:self.extrakeyButton.currentTitle];
    self.xTextField.text = string;
    [self.xTextField setSelectedRange:NSMakeRange(insertIndex + 1, 0)];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[UIDevice currentDevice] playInputClick];
    });
}



-(UITextField *)xTextField{
    if (!_xTextField) {
        _xTextField = [[UITextField alloc] init];
    }
    return _xTextField;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.xTextField resignFirstResponder];
}

-(void)dealloc{
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
