//
//  CustomKeyboardViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/2/24.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "CustomKeyboardViewController.h"

#import "CustomKeyboardView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface CustomKeyboardViewController ()<CustomKeyboardDelegate>

@property (nonatomic, strong) UITextField *xTextField;

@end

@implementation CustomKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

#define kTextFieldHeight 40
    self.xTextField.frame = CGRectMake(15, 85, SCREEN_WIDTH - 30, kTextFieldHeight);
    self.xTextField.layer.borderColor = UIColor.grayColor.CGColor;
    self.xTextField.layer.borderWidth = 1.f;
    self.xTextField.layer.cornerRadius = 12.f;
    
    //Set cursor location
    self.xTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.xTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.xTextField.placeholder = @"Please Input Here";
    [self.view addSubview:self.xTextField];
    
    CustomKeyboardView *keyView = [[CustomKeyboardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 176)];
    keyView.delegate = self;
    self.xTextField.inputView = keyView;

}

-(void)keyboardItemDidClicked:(NSString *)item{
    self.xTextField.text = [self.xTextField.text stringByAppendingString:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(UITextField *)xTextField{
    if (!_xTextField) {
        _xTextField = [[UITextField alloc] init];
    }
    return _xTextField;
}


@end
