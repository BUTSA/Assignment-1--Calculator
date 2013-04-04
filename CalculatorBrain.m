//
//  CalculatorBrain.m
//  lesson2
//
//  Created by James on 12/13/12.
//  Copyright (c) 2012 James. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

//@property(nonatomic, strong) NSMutableArray *operandStack;

@property(nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;


-(NSMutableArray *)programStack
{
    
if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    
    
    return _programStack;

}


- (void)pushOperand:(double)operand
{
//  NSNumber *operandObject = [NSNumber numberWithDouble:operend];
[self.programStack addObject:[NSNumber numberWithDouble:operand]];
    
}

// -(double)popOperand

//  {
//   NSNumber *operandObject = [self.operandStack lastObject];
//   if (operandObject)[self.operandStack removeLastObject];
//   return [operandObject doubleValue];

//  }

//hello world
- (double)performOperation:(NSString *)operation;
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
    
    
}
    
    
-(id)program
{
    return [self.programStack copy];

    
}

+(NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this is Assignment 2";
}


+(double)popOperandOffStack:(NSMutableArray *)stack
{
    //如果算5+3 我輸入 5 enter 3 enter +
    //stack會是[5,3,+]
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue]; //(1)
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        
        NSString *operation = topOfStack;
        
        if([ operation isEqualToString:@"+"]){//這時候+已經沒了,剩下[5,3]
            result = [self popOperandOffStack:stack]/*這時候左邊跑一次(1),topOfStack抓到3,把3砍了stack剩下[5],回傳3,知道左邊這個[xxxx]=3*/ + [self popOperandOffStack:stack];/*左邊這個再做一次(1),抓到5,回傳5,stack為空*/
        }
        else if ([@"*" isEqualToString:operation])
        {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        
        
        else if([@"-" isEqualToString:operation])
        {
            double subtrahend = [self popOperandOffStack:stack]; //他先抓出3 把它存在subtrahend這個東西裡面
            result = [self popOperandOffStack:stack] - subtrahend;//然後這時候跑pop(得到[xxx]回傳值=5),result=5-3
        }
        
        else if([@"/" isEqualToString:operation])
        {
            //result = [self popOperand] / [self popOperand];
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack]/divisor;
        }
        
        
        else if([@"sin" isEqualToString:operation])
        {
            result = sin([self popOperandOffStack:stack]);
        }
        
        else if([@"cos" isEqualToString:operation])
            
        {
            result = cos([self popOperandOffStack:stack]);
        }
        
        else if([@"sqrt" isEqualToString:operation])
        {
            result = sqrt([self popOperandOffStack:stack]);
        }
        
        //PI 
        else if([@"PI" isEqualToString:operation])
        {
            result = M_PI;
        }
        
        else if([@"+/-" isEqualToString:operation])
        {
            result = [self popOperandOffStack:stack] * -1;
        }
        
        
    }
    
    return result;
    
    
}

+(double)runProgram:(id)program
{
    
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]])
    {
        stack = [program mutableCopy];
        
    }
    
    return [self popOperandOffStack:stack];
}

// clearing all items in stack
- (double)clearstack
{
    double a = 0;
    if (self.programStack || self.programStack.count){
        [self.programStack removeAllObjects];
    }
    return a;
}

@end
