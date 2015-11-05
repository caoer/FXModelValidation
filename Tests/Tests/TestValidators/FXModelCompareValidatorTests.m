#import "NSObject+TMPModelValidation.h"
#import "CommonHelper.h"

@interface Form2: NSObject <TMPModelValidation>
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, assign) NSInteger value_repeat;
@property (nonatomic, assign) NSInteger value2;
@end

@implementation Form2
@end

SpecBegin(TMPModelCompareValidator)
		__block TMPModelCompareValidator *validator;
		__block NSError *error;
		__block Form2 *form;

		describe(@"validateValue", ^{
			beforeEach(^{
				validator = [[TMPModelCompareValidator alloc] init];
			});

			describe(@"compareValue", ^{
				beforeEach(^{
					validator.compareValue = @100;
				});

				it(@"-should be valid", ^{
					validator.compareOperator = @"==";
					error = [validator validateValue:@(100)];
					expect(error).to.beNil();
					error = [validator validateValue:@(101)];
					expect(error).notTo.beNil();

					validator.compareOperator = @">";
					error = [validator validateValue:@(101)];
					expect(error).to.beNil();
					error = [validator validateValue:@(10)];
					expect(error).notTo.beNil();

					validator.compareOperator = @">=";
					error = [validator validateValue:@(101)];
					expect(error).to.beNil();
					error = [validator validateValue:@(100)];
					expect(error).to.beNil();
					error = [validator validateValue:@(10)];
					expect(error).notTo.beNil();

					validator.compareOperator = @"<";
					error = [validator validateValue:@(10)];
					expect(error).to.beNil();
					error = [validator validateValue:@(101)];
					expect(error).notTo.beNil();

					validator.compareOperator = @"<=";
					error = [validator validateValue:@(10)];
					expect(error).to.beNil();
					error = [validator validateValue:@(100)];
					expect(error).to.beNil();
					error = [validator validateValue:@(101)];
					expect(error).notTo.beNil();

					validator.compareOperator = @"!=";
					error = [validator validateValue:@(101)];
					expect(error).to.beNil();
					error = [validator validateValue:@(100)];
					expect(error).notTo.beNil();
				});
			});

			afterEach(^{
				validator = nil;
				error = nil;
			});
		});

		describe(@"validate repeat", ^{
			beforeEach(^{
				form = [[Form2 alloc] init];
			});

			it(@"-should be valid", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"value",
								TMPModelValidatorType : @"compare",
								TMPModelValidatorOperator: @">",
						},
				] force:YES];

				form.value = 100;
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@NO);
				form.value_repeat = 101;
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
			});

			afterEach(^{
				form = nil;
				error = nil;
			});
		});

		describe(@"compareAttribute", ^{
			beforeEach(^{
				form = [[Form2 alloc] init];
			});

			it(@"-should be valid", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"value",
								TMPModelValidatorType : @"compare",
								TMPModelValidatorOperator: @">",
								TMPModelValidatorCompareAttribute: @"value2",
						},
				] force:YES];

				form.value = 100;
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@NO);
				form.value2 = 101;
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
			});

			afterEach(^{
				form = nil;
				error = nil;
			});
		});

		describe(@"compareAttribute and compareValue", ^{
			beforeEach(^{
				form = [[Form2 alloc] init];
			});

			it(@"-should be valid", ^{
				[form validationInitWithRules:@[
						@{
								TMPModelValidatorAttributes : @"value",
								TMPModelValidatorType : @"compare",
								TMPModelValidatorOperator: @">",
								TMPModelValidatorCompareAttribute: @"value2",
								TMPModelValidatorCompareValue: @101,
						},
				] force:YES];

				form.value = 100;
				expect(form.hasErrors).to.equal(@NO);
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
				form.value2 = 102;
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
				form.value_repeat = 102;
				form.validate;
				expect(form.hasErrors).to.equal(@YES);
				form.value = 102;
				form.validate;
				expect(form.hasErrors).to.equal(@NO);

			});

			afterEach(^{
				form = nil;
				error = nil;
			});
		});
SpecEnd