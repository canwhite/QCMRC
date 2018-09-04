//
//  ViewController.m
//  QCMRRTest
//
//  Created by EricZhang on 2018/9/3.
//  Copyright © 2018年 BYX. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Car.h"

@interface ViewController ()

@property(nonatomic,strong) Person *sperson;
@property(nonatomic,assign) Person *aperson;
@property(nonatomic,strong) Person *cperson;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    self.view.backgroundColor = [UIColor whiteColor];
    //[self test1];
    //[self test2];
    //[self test3];
    
    //[self test4];
    
    [self test5];
    
}



#pragma mark - （1）局部变量初始化和释放的基础概念
-(void)test1{
    
    //在oc中当使用alloc、retain、new、copy方法之后，引用计数就会在原有的基础上加1
    Person *p = [Person new];
    p.name = @"qiao";
    p.age = 28;
    
    NSLog(@"retainCount=%lu",[p retainCount]);//2018-09-03 16:12:51.179131+0800 QCMRRTest[16985:322718] retainCount=1
    
    //我们可以通过dealloc知道一个对象被回收
    [p release];//Invoke Person's dealloc method，使用release引用计数减1
    
    //释放了但是没有置空，报野指针错误  Thread 1: EXC_BAD_ACCESS (code=EXC_I386_GPFLT)
    //NSLog(@"retainCount=%lu",[p retainCount]);
    
    //我们先置空
    p = nil;
    
    //设置了p=nil，就不会报错了，p已经是空指针了，给空指针发送信息是不会报错的
    NSLog(@"retainCount=%lu",[p retainCount]);
    
    /*
     这里区分一下野指针和空指针
     野指针：野指针就是不知道指向哪里的指针，或者说不知道指向的内存是不是可以使用
            一般是刚刚声明没有初始化的指针，或者是内容释放之后没有置空的指针
     空指针：我们常见的空指针指向0地址，即空指针的内部全部用0来表示
            NULL或者nil是一个标准规定的宏定义，用来表示空指针常量。在C++里面被直接定义成了整数立即数的0，即false
     */
    
    
}

#pragma mark - （2）局部变量的引用计数，retain和release

-(void)test2{
    
    Person *p = [Person new];
    p.name = @"qiao";
    p.age = 28;
    
    NSLog(@"retainCount=%lu",[p retainCount]);//2018-09-03 16:12:51.179131+0800 QCMRRTest[16985:322718] retainCount=1
    
    [p retain];//引用计数+1
    NSLog(@"retainCount=%lu",[p retainCount]);//2018-09-03 16:12:51.179131+0800 QCMRRTest[16985:322718] retainCount=2
    
    [p release];//引用计数-1
    NSLog(@"retainCount=%lu",[p retainCount]);//2018-09-03 16:12:51.179131+0800 QCMRRTest[16985:322718] retainCount=1
    
    [p release];//引用计数再-1
    p = nil;
    NSLog(@"retainCount=%lu",[p retainCount]);//2018-09-03 16:12:51.179131+0800 QCMRRTest[16985:322718] retainCount=0
    
    
    
}



#pragma mark - （3）属性参数  属性用strong／retain修饰，默认set方法的认知

//如果我们用retain／strong修饰属性，先release原来的值，然后再retain新值
-(void)test3{
    //全局变量没有初始化的时候是空指针
    NSLog(@"retainCount=%lu",[self.sperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=0
    
    self.sperson = [Person new];//初始化 引用计数 +2,点语法setter的时候引用计数 + 1 ，然后初始化的时候应用计数 + 1
    self.sperson.name = @"乔";
    self.sperson.age = 28;
    NSLog(@"retainCount=%lu",[self.sperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=2


    [self.sperson release];//引用计数-1，变成1
    
    //因为nil不等于以前的person，调用下边的seter方法
    //属性参数使用strong。retain的时候会自动先release原来的值，然后再retain新值
    //    -(void)setperson:(Person *)person{
    //        if (_person!=person) { //首先判断要赋值的变量和当前成员变量是不是同一个变量，nil和之前的不同
    //            [_person release]; //释放之前的对象，retain = 0
    //            _person=[person retain];//赋值时重新retain，但是如果是nil的retain仍然是nil，所以释放完成
    //        }
    //    }
    self.sperson = nil;
    NSLog(@"retainCount=%lu",[self.sperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=0
    

    
    
}


#pragma mark - （4）属性参数 属性用assign修饰，默认set方法的不同
//如果我们用assign修饰属性，将上边的属性修饰修改
-(void)test4{
    
    self.aperson = [Person new];//set方法并不存在retain 只是new的时候retain + 1
    self.aperson.name = @"乔";
    self.aperson.age = 28;
    NSLog(@"retainCount=%lu",[self.aperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=1
    
    [self.aperson release];
    self.aperson = nil;
    
    NSLog(@"retainCount=%lu",[self.aperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=0


}

#pragma mark - (5)如果person拥有car,我们这里使用的是copy修饰的person,

-(void)test5{
    
//    -(void)setperson:(NSString *)person{
//        if(_person!=person){
//            [_person release];
//            _person=[person copy];
//        }
//    }
    
    
    self.cperson =  [Person new];//引用计数应该是2
    self.cperson.name = @"qiao";
    NSLog(@"retainCount=%lu",[self.cperson retainCount]);//2018-09-03 16:40:19.548753+0800 QCMRRTest[17822:347880] retainCount=1
    
    
    [self haveCar:self.cperson];
    
    [self.cperson.car run];
    [self.cperson release];
    self.cperson =nil;
    
}


-(void)haveCar:(Person *)p{
    
    Car *car1 = [Car new];
    car1.no = @"888888";
    p.car = car1;
    
    NSLog(@"retainCount(p)=%lu",[p.car retainCount]);
    
    Car *car2 = [Car new];
    car2.no = @"666666";
    p.car = car2;
    
    
    //我们把car1，和car2 给释放了，但是car属性还存在
    [car1 release];
    car1 = nil;
    
    [car2 release];
    car2 = nil;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
