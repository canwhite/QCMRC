//
//  Person.m
//  QCMRRTest
//
//  Created by EricZhang on 2018/9/3.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - 重写dealloc方法，在这个方法中通常进行对象释放操作
-(void)dealloc{
    
    NSLog(@"Invoke Person's dealloc method .");
    //注意最后要调用父类的dealloc方法，两个目的
    //1.父类可能有其他引用对象需要释放
    //2.当前对象真正的释放操作是在super的dealloc中完成的
    [self.car release];//在此释放对象，即使没有赋值过，因为空指针也不会出错
    [super dealloc];
    
    
}






@end
