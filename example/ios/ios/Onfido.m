
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Onfido, NSObject)

RCT_EXTERN_METHOD(startSDK: (NSString *)token
                  applicantId: (NSString *)applicationID
                  resolver:(RCTResponseSenderBlock *)resolve
                  rejecter:(RCTResponseSenderBlock *)reject)

@end

/*
@implementation Onfido

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

@end
*/
