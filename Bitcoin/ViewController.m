//
//  ViewController.m
//  Bitcoin
//
//  Created by Omar Basrawi on 8/5/14.
//  Copyright (c) 2014 Omar Basrawi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *countdownLabel;

@end

@implementation ViewController
int counter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self getPrice];
    counter = 10;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getPrice{
    NSURL *url = [NSURL URLWithString:@"https://coinbase.com/api/v1/prices/spot_rate"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (connectionError == nil) {
            NSDictionary *spotPrice = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            self.priceLabel.text = [[[spotPrice objectForKey:@"amount"] stringByAppendingString:@" "] stringByAppendingString:[spotPrice objectForKey:@"currency"]];
            
        }
    }];
}

-(void)countdown {
    counter--;
    self.countdownLabel.text = [NSString stringWithFormat:@"%d", counter];
    if (counter == 0) {
        counter = 15;
        [self getPrice];
    }
}
@end
