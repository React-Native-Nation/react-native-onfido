#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Onfido, NSObject)

RCT_EXTERN_METHOD(startSDK:
                  (NSString *) flowType
                  token: (NSString *) token
                  applicantId: (NSString *)applicantId
                  countryId: (NSString *)countryId
                  resolver:(RCTResponseSenderBlock *)resolve
                  rejecter:(RCTResponseSenderBlock *)reject
                  primaryColor: (NSString *)primaryColor
                  )
@end
