//
//  ePayLib.h
//  ePayLib
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>

extern NSString *const PaymentAcceptedNotification;
extern NSString *const PaymentWindowLoadingNotification;
extern NSString *const PaymentWindowLoadedNotification;
extern NSString *const PaymentWindowCancelledNotification;
extern NSString *const ErrorOccurredNotification;
extern NSString *const PaymentLoadingAcceptPageNotification;
extern NSString *const NetworkActivityNotification;
extern NSString *const NetworkNoActivityNotification;

/*! ePayLib for doing
 */
@interface ePayLib : NSObject <UIWebViewDelegate>

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSMutableArray *parameters;
@property (nonatomic, strong) NSString *hashKey;
@property (nonatomic) BOOL displayCancelButton;

/*! Initializes the ePay Lib with a view where the payment windows will be added to.
 \param view The view where the payment window will be added to as a subview.
 \retuns nil
 */
- (id)initWithView:(UIView*)view;

/*! Initializes the ePay Lib with paramters and a view where the payment windows will be added to.
 \param dictionary An NSMutableArray of ePayParameter.
 \param view The view where the payment window will be added to as a subview.
 \retuns nil
 */
- (id)initWithParameters:(NSMutableArray*)dictionary view:(UIView*)view;

/*! Loads the payment window and add a webView to the view specified in initWithParameters.
 */
- (void)loadPaymentWindow;

/*! Remove the webView from it's superview.
 */
- (void)hidePaymentWindow;

@end

// Category extension
@interface NSString (MD5)

/*! Returns an MD5 hash string of the given input string
*/
- (NSString *)md5Hash;

@end