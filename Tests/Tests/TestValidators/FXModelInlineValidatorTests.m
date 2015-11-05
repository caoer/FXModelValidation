#import "CommonHelper.h"

SpecBegin(TMPModelInlineValidator)
		__block Form *form;

		describe(@"action", ^{
			beforeEach(^{
				form = [[Form alloc] init];
			});

			it(@"-inline block validator should add error", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType :^(id model, NSString *attribute, NSDictionary *params) {
									[model addError:attribute message:@"error from inline block validator"];
								},
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"   test string   ";
				expect(form.valueString).to.equal(@"   test string   ");
				form.validate;
				expect([form hasErrors:@"valueString"]).to.equal(@YES);
				expect([form getErrors:@"valueString"]).to.equal(@[@"error from inline block validator"]);
			});

			it(@"-inline method validator should add error", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"action_valueString",
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"   test string   ";
				expect(form.valueString).to.equal(@"   test string   ");
				form.validate;
				expect([form hasErrors:@"valueString"]).to.equal(@YES);
				expect([form getErrors:@"valueString"]).to.equal(@[@"error from inline method validator"]);
			});

			it(@"-inline unknown validator should raise error", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"valueString",
								TMPModelValidatorType : @"unknown",
						},
				] force:YES];

				form.scenario = @"update";
				form.valueString = @"   test string   ";
				expect(form.valueString).to.equal(@"   test string   ");
				expect(^{ form.validate; }).to.raiseAny();
			});

			afterEach(^{
				form = nil;
			});
		});
SpecEnd