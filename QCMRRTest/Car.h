//
//  Car.h
//  QCMRRTest
//
//  Created by EricZhang on 2018/9/4.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject<NSCopying>

#pragma mark - 属性车牌号
@property(nonatomic,strong) NSString*no;

#pragma mark - 公共方法
-(void)run;


@end
