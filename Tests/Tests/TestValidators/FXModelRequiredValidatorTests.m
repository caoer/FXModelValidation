#import "CommonHelper.h"

SpecBegin(TMPModelRequiredValidator)
		__block Form *form;

		describe(@"validateValue", ^{
			beforeEach(^{
				form = [[Form alloc] init];
			});

			it(@"-required valueString should add error when empty", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"required",
						},
				] force:YES];

				form.scenario = @"update";
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
				expect([[form getErrors:@"valueString"] count]).to.equal(1);
			});

			it(@"-required valueString should be valid when not empty", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"required",
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"new string";
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@NO);
			});

			it(@"-required valueString should add error if not equal requiredValue", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"required",
								TMPModelValidatorRequiredValue: @"test string",
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"new string";
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
				expect([[form getErrors:@"valueString"] count]).to.equal(1);
				form.valueString = @"test string";
				form.validate;
				expect(form.hasErrors).to.equal(@NO);
			});

			afterEach(^{
				form = nil;
			});
		});
SpecEnd