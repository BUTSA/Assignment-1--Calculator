//
//  CalculatorBrain.h
//  lesson2
//
//  Created by James on 12/13/12.
//  Copyright (c) 2012 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;

//pushOperand:名字
//double:type
//operand(double)
//(double)operand:parameter


- (double)performOperation:(NSString *)operation;

- (double)clearstack;
// abc

@property (readonly) id program;

+ (double) runProgram : (id) program;

+ (NSString *) descriptionOfProgram:(id)program;

@end

//123
//電腦的計算機作用
//array [(double)數字1,(double)數字2,op]
//先看op,跑對應的function,把array的最後一個data去掉
//新的array[數字1,2]
//盡到function裡面,(e.g現在做加法)
//提array裡的最後一個數字(=數字2)提出來,把數字2移掉
//現在的array就只剩[數字1]
//再把array的最後一個數字(=數字1)提出來,跟數字2相加
//回傳