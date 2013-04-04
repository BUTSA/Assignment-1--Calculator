//
//  ViewController.m
//  lesson2
//
//  Created by James on 12/11/12.
//  Copyright (c) 2012 James. All rights reserved.
//

// I have hacked again.
// I've just hack this file.
//jcfdjdjdydjydjdfjyd

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL pointispressed;
@property (nonatomic, strong) CalculatorBrain *brain;
@end



@implementation ViewController


@synthesize display = _display;
@synthesize pointispressed = _pointispressed;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

@synthesize brain = _brain;

- (CalculatorBrain *)brain

{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    
    return _brain;
    
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle; //新創一個指標叫digit,他指到一個string,這個string會get 使用者剛剛按的按鈕的title
    //NSLog(@"digit pressed = %@", digit);
    
    //UILabel *myDisplay = self.display; //[self display];
    //NSString *currentText = self.display.text; //[myDisplay text];
    //NSString *newText = [currentText stringByAppendingString : digit];
    //myDisplay.Text = newText;
    if (!self.pointispressed)
    {
        if (self.userIsInTheMiddleOfEnteringANumber)//我輸入第二個數字,因為之前已經把判別是改成YES 所以會跑這一行
     {
        
         self.display.text = [self.display.text stringByAppendingString:digit];/*display後面後面加上新的digit*/
         if ([digit isEqualToString:@"."]) {self.pointispressed = YES;}
         //NSLog(@"pointisNotpressed");
     }
    
     else
        {
            self.display.text = digit;//當你按下第一個數字的時候 就把上面顯示的0"改成"剛剛存進去的digit
            self.userIsInTheMiddleOfEnteringANumber = YES;
            if ([digit isEqualToString:@"."]) { self.pointispressed = YES;}
            //NSLog(@"pointisNotpressed");
        }
    }
    else
    {
        if (![digit isEqualToString: @"."] &&self.userIsInTheMiddleOfEnteringANumber)//我輸入第二個數字,因為之前已經把判別是改成YES 所以會跑這一行
        {
            self.display.text = [self.display.text stringByAppendingString: digit];
            //NSLog(@"%@",digit);
            //NSLog(@"pointispressed1");
        }
        else if (![digit isEqualToString:@"."])
        {
            self.display.text = digit;//當你按下第一個數字的時候 就把上面顯示的0"改成"剛剛存進去的digit
            self.userIsInTheMiddleOfEnteringANumber = YES;
            //NSLog(@"%@",digit);
            //NSLog(@"pointispressed2");
        }
    
        
        
        
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];

    NSString * operation =[sender currentTitle];
    //宣告一個字串去抓按下去的運算子 by James
    
    // [self showHistoryDisplay:operation];
     [self showHistoryDisplay: [operation stringByAppendingString:@"="]];
    //將運算子丟到showHistoryDisplay去顯示 by James
    //in order to add "="  rewrite this line  by James
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    
}

- (IBAction)clear {
    [self.brain clearstack];
    NSLog(@"clear Pressed");
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.pointispressed = NO;
    
    self.showhistory.text=@""; //將運算過程清空
    
}
/*- (IBAction)sqrtpressed:(UIButton *)sender
{
    double number = [self.display.text doubleValue];
    double result = sqrt(number);
    
    NSString * operation =[sender currentTitle];
    //宣告一個字串去抓按下去的運算子 by James
    [self showHistoryDisplay:operation];
    //將運算子丟到showHistoryDisplay去顯示 by James
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    }
- (IBAction)sinpressed:(UIButton *)sender
{
    double number = [self.display.text doubleValue];
    double result = sin(number);
    
    NSString * operation =[sender currentTitle];
    //宣告一個字串去抓按下去的運算子 by James
    [self showHistoryDisplay:operation];
    //將運算子丟到showHistoryDisplay去顯示 by James
    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
- (IBAction)cospressed:(UIButton *)sender
{
    double number = [self.display.text doubleValue];
    double result = cos(number);

    NSString * operation =[sender currentTitle];
    //宣告一個字串去抓按下去的運算子 by James
    [self showHistoryDisplay:operation];
    //將運算子丟到showHistoryDisplay去顯示 by James

    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
*/

- (IBAction)backspace {
    NSLog(@"Backspace pressed");
    NSString *resultString = self.display.text;
    NSLog(@"Display String = %@",resultString);
    int a = resultString.length;
    NSLog(@"a = %d",a);
    if(a)
    {
        resultString = [resultString substringWithRange:NSMakeRange(0, a-1)];
    }
    NSLog(@"Display String after delete= %@",resultString);
    self.display.text = resultString;
}

/*
-(IBAction)negpressed:(UIButton *)sender
{
    double result = 0-[self.display.text doubleValue];
    
    
    NSString * operation =[sender currentTitle];
    //宣告一個字串去抓按下去的運算子 by James
    [self showHistoryDisplay:operation];
    //將運算子丟到showHistoryDisplay去顯示 by James

    
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
*/
 
- (IBAction)enterPressed
{
    [self.brain pushOperand: [self.display.text doubleValue]];
    
    [self showHistoryDisplay:self.display.text];
    //將按enter之後確定的數字丟到showHistoryDisplay去顯示 by James
    
    self.userIsInTheMiddleOfEnteringANumber= NO;
    self.display.text = @"0";
}



// method for 處理運算過程顯示 by James
-(void)showHistoryDisplay:(NSString *)text

{
    
    self.showhistory.text=[self.showhistory.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    // add "=" in the history label via stringByReplacingOccurenceOfString method 
    
    
    self.showhistory.text= [self.showhistory.text stringByAppendingString:[NSString stringWithFormat:@"%@", text]];
}






@end