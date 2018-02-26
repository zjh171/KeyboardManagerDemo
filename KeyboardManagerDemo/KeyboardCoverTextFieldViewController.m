//
//  KeyboardCoverTextFieldViewController.m
//  KeyboardManagerDemo
//
//  Created by zhujinhui on 2018/2/23.
//  Copyright © 2018年 kyson. All rights reserved.
//

#import "KeyboardCoverTextFieldViewController.h"

@interface KeyboardCoverTextFieldViewController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGRect activedTextFieldRect;

@end

@implementation KeyboardCoverTextFieldViewController

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowWithNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 24)];
        field.delegate = self;
        field.placeholder = [NSString stringWithFormat:@"You can input Something At Index %li",(long)indexPath.row];
        [cell.contentView addSubview:field];
    }
    
    return cell;
}


- (void)keyBoardWillShowWithNotification:(NSNotification *)notification {
    //get FrameEnd
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //get AnimationDuration
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //keyboard height > textView height, need scroll
    if ((self.activedTextFieldRect.origin.y + self.activedTextFieldRect.size.height) >  ([UIScreen mainScreen].bounds.size.height - rect.size.height))
    {
        [UIView animateWithDuration:duration animations:^{
            self.tableview.contentOffset = CGPointMake(0, 64 + self.activedTextFieldRect.origin.y + self.activedTextFieldRect.size.height - ([UIScreen mainScreen].bounds.size.height - rect.size.height));
        }];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activedTextFieldRect = [textField convertRect:textField.frame toView:self.tableview];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _tableview;
}


-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField",@"textField"];
    }
    return _titles;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
