//
// Created by Andrey on 13/11/14.
// Copyright (c) 2014 Andrey Gayvoronsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMPModelValidation.h"

@interface Form : NSObject <TMPModelValidation>
@property (nonatomic, assign) BOOL valueBoolean;
@property (nonatomic, assign) NSInteger valueInteger;
@property (nonatomic, assign) CGFloat valueFloat;
@property (nonatomic, copy) NSString *valueString;
@property (nonatomic, copy) NSArray *valueArray;
@property (nonatomic, copy) NSDictionary *valueDictionary;
@property (nonatomic, copy) NSSet *valueSet;
@property (nonatomic, copy) NSNumber *valueNumber;

-(NSArray *)rules;

//inline 'value' for TMPModelDefaultValueValidator
-(id)default_valueString:(id)value;

//inline 'filter' for TMPModelFilterValidator
-(id)filter_valueString:(id)value params:(NSDictionary *)params;

//inline 'action' for TMPModelInlineValidator
-(void)action_valueString:(NSString *)attribute params:(NSDictionary *)params;

@end