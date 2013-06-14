

#import <objc/runtime.h>



void CCSwapInstanceMethods(Class class, SEL originalSelector, SEL supplementarySelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method supplementaryMethod = class_getInstanceMethod(class, supplementarySelector);
    method_exchangeImplementations(originalMethod, supplementaryMethod);
}


void CCSwapClassMethods(Class class, SEL originalSelector, SEL supplementarySelector) {
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method supplementaryMethod = class_getClassMethod(class, supplementarySelector);
    method_exchangeImplementations(originalMethod, supplementaryMethod);
}

