# Runtime
iOS Runtime学习整理。

Objective-C具有相当多的动态特性，基本的，也是经常被提到和用到的有动态类型（Dynamic typing），动态绑定（Dynamic binding）和动态加载（Dynamic loading）。

- 一些概念

  - Runtime 简称运行时，就是系统在运行时候的一些机制，其中最主要的是消息机制。
  - 对于C语言，函数的调用在编译的时候会决定调用哪个函数，编译完成之后直接顺序执行，无任何二义性。
  - OC的函数调用成为消息发送。属于动态调用过程。在编译的时候并不能决定真正调用哪个函数（事实证明，在编译阶段，OC可以调用任何函数，即使这个函数并未实现，只要申明过就不会报错。而C语言在编译阶段就会报错）。
  - 只有在真正运行的时候才会根据函数的名称找到对应的函数来调用。
- Runtime 的具体实现


Objective-C 是动态语言，每个方法在运行时会被动态转为消息发送，即：objc_msgSend(receiver, selector)。

我们写的 OC 代码，它在运行的时候也是转换成了 runtime 方式运行的，更好的理解 runtime，也能帮我们更深的掌握 OC 语言。

- 每一个 OC 的方法，底层必然有一个与之对应的 runtime 方法。
  - 当我们用OC写下这样一段代码

  `[tableView cellForRowAtIndexPath:indexPath];`

  - 在编译时RunTime会将上述代码转化成[发送消息]

  `objc_msgSend(tableView, @selector(cellForRowAtIndexPath:),indexPath);`


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

https://onevcat.com/2012/04/objective-c-runtime/