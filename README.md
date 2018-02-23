# 深入讲解iOS键盘一：控制键盘隐藏显示
在iOS的开发中，我们一般使用UITextField、UITextView处理文字输入等操作，大部分情况下我们只需要一两行代码去手动管理键盘的显示隐藏：让UITextField或UITextView成为第一相应者的时候会自动唤起键盘，当我们点击其他区域的时候让UITextField或UITextView失去焦点，键盘自动隐藏。

```
//是否能成为第一响应者
- (BOOL)canBecomeFirstResponder;    // default is NO
//成为第一响应者(弹出键盘)
- (BOOL)becomeFirstResponder;
//是否能放弃成为第一响应者
- (BOOL)canResignFirstResponder;    // default is YES
//放弃城额外对响应者(隐藏键盘)
- (BOOL)resignFirstResponder;

```

但有的情况下，我们还需要控制键盘的显示以及隐藏的动画,比如系统的iMessage的键盘跟随UITextField的弹出/隐藏效果。
![键盘跟随弹出](http://7xij1g.com1.z0.glb.clouddn.com/keyboard_1.gif)
这个时候我们就需要通过动态的调整TextField的Frame来实现跟随键盘移动的动画效果。为了解决这个问题，我们自然而然需要了解键盘的高度和键盘的动画，这样我们才能让键盘上部的TextField跟随键盘运动。
![](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Art/keyboard_input_2x.png)
![](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Art/keyboard_size_2x.png)
由于键盘在横竖屏的情况下的高度不同，以及可能存在工具栏（影响键盘的高度），因此如果每次都动态获取键盘高度的话会非常繁琐，幸好苹果给我们提供了一套关于键盘处理的解决方案。

##### 键盘通知
为了让开发者在键盘弹出/隐藏时方便做处理，苹果提供了键盘的几个通知，分别是
- [UIKeyboardWillShowNotification](https://developer.apple.com/documentation/foundation/nsnotification.name/1621576-uikeyboardwillshow)
- [UIKeyboardDidShowNotification](https://developer.apple.com/documentation/uikit/uikeyboarddidshownotification)
- [UIKeyboardWillHideNotification](https://developer.apple.com/documentation/foundation/nsnotification.name/1621606-uikeyboardwillhide)
- [UIKeyboardDidHideNotification](https://developer.apple.com/documentation/foundation/nsnotification.name/1621579-uikeyboarddidhide)

我们在监听了以上的某个通知后，可以获取到当前状态下的键盘高度，键盘动画的一些参数
```
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(keyboardWasShown:)
            name:UIKeyboardDidShowNotification object:nil];

   [[NSNotificationCenter defaultCenter] addObserver:self
             selector:@selector(keyboardWillBeHidden:)
             name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //获取结束时的Frame值
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //获取动画时间
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //...
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //...
}
```
有了键盘通知以后，我们可以轻易的实现本文开头提出的问题，这里笔者做了个Demo演示如下：
![](http://7xij1g.com1.z0.glb.clouddn.com/keyboard_2.gif)

[点此进入代码在github中的地址](https://github.com/zjh171/KeyboardManagerDemo.git)


#####引用
[Text Programming Guide for iOS](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html)
