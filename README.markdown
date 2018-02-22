## MGObservers

**MGObservers** provides an lightweight API for keypath observing and UIControl event
handling.

### Setup

```
pod 'MGObservers'
```

### Examples

```objc
#import <MGObservers/MGObservers.h>
``` 

### Keypath Observing

```objc
[box onChangeOf:@"selected" do:^{
    NSLog(@"the new selected value is: %d", box.selected);
}];
```

### Control Event Observing

```objc
[button onControlEvent:UIControlEventTouchUpInside do:^{
    NSLog(@"i've been touched up inside. golly.");
}];
```

Or in Swift: 

```swift
button.onControlEvent(.TouchUpInside) {
    print("you touched me!")
}
```

