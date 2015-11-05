#import "CommonHelper.h"

@interface Form1: NSObject <TMPModelValidation>
@property (nonatomic, assign) NSInteger valueInteger;
@end;

@implementation Form1
@end;

SpecBegin(TMPModelSafeValidator)
		__block Form1 *form;

		describe(@"validateValue", ^{
			beforeEach(^{
				form = [[Form1 alloc] init];
			});

			it(@"-mass assignment should not work", ^{
				[form validationInitWithRules:@[
				] force:YES];

				form.valueInteger = 100;
				expect(form.valueInteger).to.equal(100);
				form.attributes = @{@"valueInteger": @200};
				expect(form.valueInteger).to.equal(100);
			});

			it(@"-mass assignment should work", ^{
				[form validationInitWithRules:@[
						@{
							TMPModelValidatorAttributes : @"valueInteger",
							TMPModelValidatorType: @"safe",
						},
				] force:YES];

				form.valueInteger = 100;
				expect(form.valueInteger).to.equal(100);
				form.attributes = @{@"valueInteger": @200};
				expect(form.valueInteger).to.equal(200);
			});

			afterEach(^{
				form = nil;
			});
		});
SpecEnd

