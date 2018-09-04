//
//  Car.m
//  QCMRRTest
//
//  Created by EricZhang on 2018/9/4.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "Car.h"

@implementation Car
-(void)run{
    
    NSLog(@"Car(%@) run.",self.no);
    
}


- (id)copyWithZone:(NSZone *)zone {
    
    Car *car = [[[self class] allocWithZone:zone] init];
    car.no =self.no;
    return car;
}

#pragma mark - overwrite
-(void)dealloc{
    NSLog(@"Invoke Car(%@) dealloc method.",self.no);
    [super dealloc];
}


@end
