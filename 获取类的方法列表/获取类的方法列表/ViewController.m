//
//  ViewController.m
//  获取类的方法列表
//
//  Created by Sun on 2019/10/20.
//  Copyright © 2019 Sun. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) Person *p1;
@property (nonatomic, strong) Person *p2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建对象p1
    self.p1 = [[Person alloc] init];
    self.p1.age = 1;
    
    // 创建对象p2
    self.p2 = [[Person alloc] init];
    self.p2.age = 2;
    
    // 给对象p1添加观察者
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.p1 addObserver:self forKeyPath:@"age" options:options context:@"123"];
    
    [self printMethodNamesOfClas: object_getClass(self.p1)];
    [self printMethodNamesOfClas: object_getClass(self.p2)];
}

- (void)printMethodNamesOfClas: (Class)cls {
    unsigned int count;
    Method *methodList = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [methodNames appendString: methodName];
        [methodNames appendString: @", "];
    }
    
    free(methodList);
    NSLog(@"%@, %@", cls, methodNames);
}

@end
