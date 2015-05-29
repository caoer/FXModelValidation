//
//  User.m
//  Examples
//
//  Created by Andrey on 19/11/14.
//
//

#import "User.h"

@implementation User

-(instancetype) init {
    if((self = [super init])) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[self class] validationInit];
        });
    }
    
    return self;
}

-(NSArray *)rules {
    return @[
             // username, email and password are all required in "register" scenario
             @{
                 TMPModelValidatorAttributes : @[@"username", @"email", @"password"],
                 TMPModelValidatorType : @"required",
                 TMPModelValidatorOn: @[@"register"],
                 },
             // username and password are required in "login" scenario
             @{
                 TMPModelValidatorAttributes : @[@"username", @"password"],
                 TMPModelValidatorType : @"required",
                 TMPModelValidatorOn: @[@"login"],
                 },
             // email should be valid email address
             @{
                 TMPModelValidatorAttributes : @"email",
                 TMPModelValidatorType : @"email", 
                 TMPModelValidatorOn: @[@"register"],
                 },

             ];
    
}

- (NSArray *)excludedFields
{
	//Just for demonstrating purpose - that we support already implemented 'excludedFields()' for FXForms.
	//Check result of that method after object initialization and you will see here other properties too.
    return @[
             @"someProperty",
             @"someOtherProperty",
             ];
}
@end
