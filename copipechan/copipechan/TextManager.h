//
//  TextManager.h
//  copipechan
//
//  Created by yatemmma on 2014/12/04.
//  Copyright (c) 2014年 yatemmma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextManager : NSObject

+ (instancetype)sharedManager;

- (NSArray *)allText;

- (void)addText:(NSString *)text;
- (void)deleteTextAtIndex:(NSUInteger)index;

@end
