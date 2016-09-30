# Runtime
iOS Runtime学习整理。



- 常见方法

  - 获取属性列表

  ```objective-c
  unsigned int count;
  objc_property_t *propertyList = class_copyPropertyList([NSObject class], &count);
  for (int i=0; i<count; i++) {
  	const char *propertyName = property_getName(propertyList[i]);
  	NSLog(@"property--->%@", [NSString stringWithUTF8String:propertyName]);
  }
  ```

  - 获取方法列表

  ```objective-c
  unsigned int count;
  Method *methodList = class_copyMethodList([UIView class], &count);
  for (int i=0; i<count; i++) {
  	Method method = methodList[i];
  	NSLog(@"method--->%@", NSStringFromSelector(method_getName(method)));
  }
  ```

  - 获取实例变量列表

  ```objective-c
  unsigned int count;
  Ivar *ivarList = class_copyIvarList([UIViewController class], &count);
  for (int i=0; i<count; i++) {
  	const char *ivarName = ivar_getName(ivarList[i]);
  	NSLog(@"Ivar--->%@", [NSString stringWithUTF8String:ivarName]);
  }
  ```

  - 获取协议列表

  ```objective-c
  unsigned int count;
  __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UITableView class], &count);
  for (int i=0; i<count; i++) {
  	const char *protocolName = protocol_getName(protocolList[i]);
  	NSLog(@"Protocol--->%@", [NSString stringWithUTF8String:protocolName]);
  }
  ```


- 方法交换

```c
method_exchangeImplementations(Method m1, Method m2)
```

- 动态关联属性

```objective-c
//存取方法
- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, "name");
}
```

- 归档/解档
- 字典模型转换





主要参考：

[http://gcblog.github.io/2016/04/16/runtime%E8%AF%A6%E8%A7%A3/#more](http://gcblog.github.io/2016/04/16/runtime%E8%AF%A6%E8%A7%A3/#more)

[https://github.com/Tuccuay/RuntimeSummary](https://github.com/Tuccuay/RuntimeSummary)

[http://southpeak.github.io/categories/objectivec/](http://southpeak.github.io/categories/objectivec/)

