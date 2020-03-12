#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Onfido, NSObject)

RCT_EXTERN_METHOD(startSDK: (NSString *)token
                  applicantId: (NSString *)applicationID
                  countryId: (NSString *)countryId
                  resolver:(RCTResponseSenderBlock *)resolve
                  rejecter:(RCTResponseSenderBlock *)reject)

@end