//
//  CustomKeyboardView.h
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/2/24.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomKeyboardDelegate

-(void) keyboardItemDidClicked:(NSString *) item;

@end


@interface CustomKeyboardView : UIView

@property(nonatomic, weak) id<CustomKeyboardDelegate> delegate;

@end
