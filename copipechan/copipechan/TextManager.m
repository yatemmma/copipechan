//
//  TextManager.m
//  copipechan
//
//  Created by yatemmma on 2014/12/04.
//  Copyright (c) 2014年 yatemmma. All rights reserved.
//

#import "TextManager.h"

static NSString *const kTextListSaveKey = @"TextListSaveKey";

@interface TextManager ()

@property (nonatomic) NSArray *textList;

@end

static TextManager *instance = nil;

@implementation TextManager

+ (instancetype)sharedManager
{
    if (instance == nil) {
        instance = [TextManager new];
    }
    return instance;
}

// override
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *savedList = [self loadTextList];
        self.textList = (savedList.count > 0) ? savedList : [self defaultTextList];
    }
    return self;
}

- (NSArray *)allText
{
    return self.textList ? : @[];
}

- (void)addText:(NSString *)text
{
    if (text == nil || [text isEqualToString:@""]) {
        return;
    }
    self.textList = [self.textList arrayByAddingObject:text];
    [self saveTextList:self.textList];
}

#pragma mark - Private Methods
- (void)saveTextList:(NSArray *)list
{
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:kTextListSaveKey];
    
    if (![[NSUserDefaults standardUserDefaults] synchronize]) {
        // TODO: error occurred.
    }
}

- (NSArray *)loadTextList
{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:kTextListSaveKey] ? : @[];
}

- (NSArray *)defaultTextList
{
    return @[@"awsome text", @"frequently used word"];
}

@end
