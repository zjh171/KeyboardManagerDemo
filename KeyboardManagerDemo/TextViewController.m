//
//  TextViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/1/29.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "TextViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TextViewController()<UITextViewDelegate>


@property(nonatomic, strong) UITextView *xTextView;

@end



@implementation TextViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.xTextView.text = @"When users touch a text field, a text view, or a field in a web view, the system displays a keyboard. You can configure the type of keyboard that is displayed along with several attributes of the keyboard. You also have to manage the keyboard when the editing session begins and ends. Because the keyboard could hide the portion of your view that is the focus of editing, this management might include adjusting the user interface to raise the area of focus so that is visible above the keyboard.Whenever the user taps in an object capable of accepting text input, the object asks the system to display an appropriate keyboard. Depending on the needs of your program and the user’s preferred language, the system might display one of several different keyboards. Although your app cannot control the user’s preferred language (and thus the keyboard’s input method), it can control attributes of the keyboard that indicate its intended use, such as the configuration of any special keys and its behaviors.You configure the attributes of the keyboard directly through the text objects of your app. The UITextField and UITextView classes both conform to the UITextInputTraits protocol, which defines the properties for configuring the keyboard. Setting these properties programmatically or in the Interface Builder inspector window causes the system to display the keyboard of the designated type.The default keyboard configuration is designed for general text input. Figure 4-1 displays the default keyboard along with several other keyboard configurations. The default keyboard displays an alphabetical keyboard initially but the user can toggle it and display numbers and punctuation as well. Most of the other keyboards offer similar features as the default keyboard but provide additional buttons that are specially suited to particular tasks. However, the phone and numerical keyboards offer a dramatically different layout that is tailored towards numerical input.You should always use the information in these notifications as opposed to assuming the keyboard is a particular size or in a particular location. The size of the keyboard is not guaranteed to be the same from one input method to another and may also change between different releases of iOS. In addition, even for a single language and system release, the keyboard dimensions can vary depending on the orientation of your app. For example, Figure 4-3 shows the relative sizes of the URL keyboard in both the portrait and landscape modes. Using the information inside the keyboard notifications ensures that you always have the correct size and position information.When users touch a text field, a text view, or a field in a web view, the system displays a keyboard. You can configure the type of keyboard that is displayed along with several attributes of the keyboard. You also have to manage the keyboard when the editing session begins and ends. Because the keyboard could hide the portion of your view that is the focus of editing, this management might include adjusting the user interface to raise the area of focus so that is visible above the keyboard.Whenever the user taps in an object capable of accepting text input, the object asks the system to display an appropriate keyboard. Depending on the needs of your program and the user’s preferred language, the system might display one of several different keyboards. Although your app cannot control the user’s preferred language (and thus the keyboard’s input method), it can control attributes of the keyboard that indicate its intended use, such as the configuration of any special keys and its behaviors.You configure the attributes of the keyboard directly through the text objects of your app. The UITextField and UITextView classes both conform to the UITextInputTraits protocol, which defines the properties for configuring the keyboard. Setting these properties programmatically or in the Interface Builder inspector window causes the system to display the keyboard of the designated type.The default keyboard configuration is designed for general text input. Figure 4-1 displays the default keyboard along with several other keyboard configurations. The default keyboard displays an alphabetical keyboard initially but the user can toggle it and display numbers and punctuation as well. Most of the other keyboards offer similar features as the default keyboard but provide additional buttons that are specially suited to particular tasks. However, the phone and numerical keyboards offer a dramatically different layout that is tailored towards numerical input.You should always use the information in these notifications as opposed to assuming the keyboard is a particular size or in a particular location. The size of the keyboard is not guaranteed to be the same from one input method to another and may also change between different releases of iOS. In addition, even for a single language and system release, the keyboard dimensions can vary depending on the orientation of your app. For example, Figure 4-3 shows the relative sizes of the URL keyboard in both the portrait and landscape modes. Using the information inside the keyboard notifications ensures that you always have the correct size and position information.";
    self.xTextView.delegate = self;
    [self.view addSubview:self.xTextView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)handleKeyboardNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect keyboardScreenBeginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue] ;
    CGRect keyboardScreenEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboardScreenBeginFrame:%@,keyboardScreenEndFrame:%@",NSStringFromCGRect(keyboardScreenBeginFrame),NSStringFromCGRect(keyboardScreenEndFrame));
    
    CGFloat originDelta = keyboardScreenEndFrame.origin.y - keyboardScreenBeginFrame.origin.y;
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect frame = self.xTextView.frame;
        frame.size.height = frame.size.height + originDelta;
        self.xTextView.frame = frame;
    } completion:^(BOOL finished) {
        ;
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.xTextView resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.xTextView resignFirstResponder];
}

-(UITextView *)xTextView{
    if (!_xTextView) {
        _xTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
        _xTextView.font = [UIFont systemFontOfSize:25];
    }
    return _xTextView;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
