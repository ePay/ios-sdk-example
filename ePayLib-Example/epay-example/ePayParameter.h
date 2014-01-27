//
//  ePayParameter.h
//  ePayLib
//

#import <Foundation/Foundation.h>

@interface ePayParameter : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

+ (ePayParameter*)key:(NSString *)key value:(NSString*)value;

@end
