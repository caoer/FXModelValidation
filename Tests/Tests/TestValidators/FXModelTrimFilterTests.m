#import "CommonHelper.h"

SpecBegin(TMPModelTrimFilter)
		__block Form *form;

		describe(@"trim", ^{
			beforeEach(^{
				form = [[Form alloc] init];
			});

			it(@"-trim filter should trim whitespaces from valueString", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"trim",
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"   test string   ";
				expect(form.valueString).to.equal(@"   test string   ");
				form.validate;
				expect(form.valueString).to.equal(@"test string");
			});

			it(@"-trim filter should trim begging letters from valueString", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"trim",
								TMPModelValidatorSet : [NSCharacterSet letterCharacterSet],
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"test string   ";
				form.validate;
				expect(form.valueString).to.equal(@" string   ");
			});

			afterEach(^{
				form = nil;
			});
		});
SpecEnd