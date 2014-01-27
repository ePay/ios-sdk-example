//
//  ViewController.m
//  ePay Example
//

#import "ViewController.h"
#import "ePayLib.h"
#import "ePayParameter.h"

@interface ViewController ()
{
    ePayLib* epaylib;
}

@end

@implementation ViewController

@synthesize activityIndicatorView;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Listen to ePay Lib notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentAcceptedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentLoadingAcceptPageNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowCancelledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:PaymentWindowLoadingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:ErrorOccurredNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:NetworkActivityNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(event:) name:NetworkNoActivityNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)goToPaymentClick:(id)sender {
    [self initPayment];
}

- (void)initPayment {
    // Declare your unique OrderId
    NSString *orderId = [NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]];
    
    // Init the ePay Lib with parameters and the view to add it to.
    epaylib = [[ePayLib alloc] initWithView:self.view];
    
    // Add parameters to the array
    [epaylib.parameters addObject:[ePayParameter key:@"merchantnumber" value:@"8013990"]];          //http://tech.epay.dk/en/specification#258
    [epaylib.parameters addObject:[ePayParameter key:@"currency" value:@"DKK"]];                    //http://tech.epay.dk/en/specification#259
    [epaylib.parameters addObject:[ePayParameter key:@"amount" value:@"100"]];                      //http://tech.epay.dk/en/specification#260
    [epaylib.parameters addObject:[ePayParameter key:@"orderid" value:orderId]];                    //http://tech.epay.dk/en/specification#261
    //[parameters addObject:[KeyValue initKey:@"windowid" value:@"1"]];                             //http://tech.epay.dk/en/specification#262
    [epaylib.parameters addObject:[ePayParameter key:@"paymentcollection" value:@"0"]];             //http://tech.epay.dk/en/specification#263
    [epaylib.parameters addObject:[ePayParameter key:@"lockpaymentcollection" value:@"0"]];         //http://tech.epay.dk/en/specification#264
    //[parameters addObject:[KeyValue initKey:@"paymenttype" value:@"1,2,3"]];                      //http://tech.epay.dk/en/specification#265
    [epaylib.parameters addObject:[ePayParameter key:@"language" value:@"0"]];                      //http://tech.epay.dk/en/specification#266
    [epaylib.parameters addObject:[ePayParameter key:@"encoding" value:@"UTF-8"]];                  //http://tech.epay.dk/en/specification#267
    //[parameters addObject:[KeyValue initKey:@"mobilecssurl" value:@""]];                          //http://tech.epay.dk/en/specification#269
    [epaylib.parameters addObject:[ePayParameter key:@"instantcapture" value:@"0"]];                //http://tech.epay.dk/en/specification#270
    //[parameters addObject:[KeyValue initKey:@"splitpayment" value:@"0"]];                         //http://tech.epay.dk/en/specification#272
    //[parameters addObject:[KeyValue initKey:@"callbackurl" value:@""]];                           //http://tech.epay.dk/en/specification#275
    [epaylib.parameters addObject:[ePayParameter key:@"instantcallback" value:@"1"]];               //http://tech.epay.dk/en/specification#276
    [epaylib.parameters addObject:[ePayParameter key:@"ordertext" value:@"iOS Test"]];              //http://tech.epay.dk/en/specification#278
    //[parameters addObject:[KeyValue initKey:@"group" value:@"group"]];                            //http://tech.epay.dk/en/specification#279
    [epaylib.parameters addObject:[ePayParameter key:@"description" value:@"iOS Test Description"]];//http://tech.epay.dk/en/specification#280
    //[parameters addObject:[KeyValue initKey:@"hash" value:@""]];                                  //http://tech.epay.dk/en/specification#281
    //[parameters addObject:[KeyValue initKey:@"subscription" value:@"0"]];                         //http://tech.epay.dk/en/specification#282
    //[parameters addObject:[KeyValue initKey:@"subscriptionname" value:@"0"]];                     //http://tech.epay.dk/en/specification#283
    //[parameters addObject:[KeyValue initKey:@"mailreceipt" value:@""]];                           //http://tech.epay.dk/en/specification#284
    //[parameters addObject:[KeyValue initKey:@"googletracker" value:@"0"]];                        //http://tech.epay.dk/en/specification#286
    //[parameters addObject:[KeyValue initKey:@"backgroundcolor" value:@""]];                       //http://tech.epay.dk/en/specification#287
    //[parameters addObject:[KeyValue initKey:@"opacity" value:@""]];                               //http://tech.epay.dk/en/specification#288
    [epaylib.parameters addObject:[ePayParameter key:@"declinetext" value:@"Decline Text"]];        //http://tech.epay.dk/en/specification#289
    
    // Set the hash key
    [epaylib setHashKey:@"MartinBilgrau2013"];
    
    // Show/hide the Cancel button
    [epaylib setDisplayCancelButton:YES];
    
    // Load the payment window
    [epaylib loadPaymentWindow];
}

- (void)event:(NSNotification*)notification {
    // Here we handle all events sent from the ePay Lib
    
    if ([[notification name] isEqualToString:PaymentAcceptedNotification]) {
        NSLog(@"EVENT: PaymentAcceptedNotification");
        
        for (ePayParameter *item in [notification object]) {
            NSLog(@"Data: %@ = %@", item.key, item.value);
        }
    }
    else if ([[notification name] isEqualToString:PaymentLoadingAcceptPageNotification]) {
        NSLog(@"EVENT: PaymentLoadingAcceptPageNotification");
    }
    else if ([[notification name] isEqualToString:PaymentWindowCancelledNotification]) {
        NSLog(@"EVENT: PaymentWindowCancelledNotification");
    }
    else if ([[notification name] isEqualToString:PaymentWindowLoadingNotification]) {
        NSLog(@"EVENT: PaymentWindowLoadingNotification");
        
        // Display a loading indicator while loading the payment window
        [activityIndicatorView startAnimating];
    }
    else if ([[notification name] isEqualToString:PaymentWindowLoadedNotification]) {
        NSLog(@"EVENT: PaymentWindowLoadedNotification");
        
        // Stop our loading indicator when the payment window is loaded
        [activityIndicatorView stopAnimating];
    }
    else if ([[notification name] isEqualToString:ErrorOccurredNotification]) {
        // Display error object if we get a error notification
        NSLog(@"EVENT: ErrorOccurredNotification - %@", [notification object]);
    }
    else if ([[notification name] isEqualToString:NetworkActivityNotification]) {
        // Display network indicator in the statusbar
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    else if ([[notification name] isEqualToString:NetworkNoActivityNotification]) {
        // Hide network indicator in the statusbar
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

@end