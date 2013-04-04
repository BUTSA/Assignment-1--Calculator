//
//  ViewController.h
//  lesson2
//
//  Created by James on 12/11/12.
//  Copyright (c) 2012 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//e.g 如果brain寫在這邊 其他的.m用brain的時候 他們就會以為用的是這邊的這個brain. 但寫在.m的@interface時 xcode就會知道這個property只用在這個.m裡面.
@property (weak, nonatomic) IBOutlet UILabel *display;

@property (weak, nonatomic) IBOutlet UILabel *showhistory;  //宣告showhistory 給運算過程UI Label 使用 by James

@end
