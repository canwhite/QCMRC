//
//  Person.h
//  QCMRRTest
//
//  Created by EricZhang on 2018/9/3.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface Person : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) int age;

#pragma mark - person have car
//[Car copyWithZone:]: unrecognized selector sent to instance 0x600000008700
//注意copy自定义对象的时候要遵守NSCopying协议，并且在car中上述方法，否则就会爆上边错误
@property(nonatomic,copy) Car *car;



@end
