#import "UIActionSheet+Blocks.h"

@implementation UIActionSheet (Blocks)

static NSString *kUIActionSheetCallbackPropertyKey = @"callback";

#pragma mark - Properties

- (UIActionSheetCallback *)callback
{
    return objc_getAssociatedObject(self, kUIActionSheetCallbackPropertyKey);
}

- (void)setCallback:(UIActionSheetCallback *)callback
{
    objc_setAssociatedObject(self, kUIActionSheetCallbackPropertyKey, callback, OBJC_ASSOCIATION_RETAIN);
}

- (UIActionSheetBlockWithButtonIndex)clickedButtonCallback
{
    return self.callback.clickedButtonCallback;
}

- (void)setClickedButtonCallback:(UIActionSheetBlockWithButtonIndex)clickedButtonCallback
{
    self.callback.clickedButtonCallback = clickedButtonCallback;
}

- (UIActionSheetBlockWithButtonIndex)didDismissCallback
{
    return self.callback.didDismissCallback;
}

- (void)setDidDismissCallback:(UIActionSheetBlockWithButtonIndex)didDismissCallback
{
    self.callback.didDismissCallback = didDismissCallback;
}

- (UIActionSheetBlockWithButtonIndex)willDismissCallback
{
    return self.callback.willDismissCallback;
}

- (void)setWillDismissCallback:(UIActionSheetBlockWithButtonIndex)willDismissCallback
{
    self.callback.willDismissCallback = willDismissCallback;
}

- (UIActionSheetBlock)willPresentCallback
{
    return self.callback.willPresentCallback;
}

- (void)setWillPresentCallback:(UIActionSheetBlock)willPresentCallback
{
    self.callback.willPresentCallback = willPresentCallback;
}

- (UIActionSheetBlock)didPresentCallback
{
    return self.callback.willPresentCallback;
}

- (void)setDidPresentCallback:(UIActionSheetBlock)didPresentCallback
{
    self.callback.didPresentCallback = didPresentCallback;
}

- (UIActionSheetBlock)cancelCallback
{
    return self.callback.cancelCallback;
}

- (void)setCancelCallback:(UIActionSheetBlock)cancelCallback
{
    self.callback.cancelCallback = cancelCallback;
}

#pragma mark - Extensions

- (id)initWithTitle:(NSString *)title
{
    self = [self initWithTitle:title cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    return self;
}

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [self initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    if(self) {
        // デリゲートをセット
        UIActionSheetCallback *callback = [[UIActionSheetCallback alloc] init];
        self.delegate = callback;
        
        self.callback = callback;
        [callback release];
        
        // 特殊なボタンを処理
        if(destructiveButtonTitle) {
            [self addDestructiveButtonWithTitle:destructiveButtonTitle block:NULL];
        }
        
        if(cancelButtonTitle) {
            [self addCancelButtonWithTitle:cancelButtonTitle block:NULL];
        }
        
        // 可変長引数を処理
        va_list args;
        va_start(args, otherButtonTitles);
        
        for(NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg block:NULL];
        }
        
        va_end(args);
    }
    
    return self;
}

- (void)addButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block
{
    id blockObject = [NSNull null];
    if(block) blockObject = [[block copy] autorelease];
    
    [self addButtonWithTitle:title];
    [[(UIActionSheetCallback *)self.delegate buttonCallbacks] addObject:blockObject];
}

- (void)addCancelButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block
{
    NSInteger cancelButtonIndex = [[(UIActionSheetCallback *)self.delegate buttonCallbacks] count];
    [self addButtonWithTitle:title block:block];
    self.cancelButtonIndex = cancelButtonIndex;
}

- (void)addDestructiveButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block
{
    NSInteger destructiveButtonIndex = [[(UIActionSheetCallback *)self.delegate buttonCallbacks] count];
    [self addButtonWithTitle:title block:block];
    self.destructiveButtonIndex = destructiveButtonIndex;
}

@end


#pragma mark -

@implementation UIActionSheetCallback

- (id)init
{
    self = [super init];
    
    if(self) {
        self.buttonCallbacks = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc
{
    [_buttonCallbacks release];
    
    [_clickedButtonCallback release];
    [_didDismissCallback release];
    [_willDismissCallback release];
    [_willPresentCallback release];
    [_didPresentCallback release];
    [_cancelCallback release];
    
    [super dealloc];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(self.clickedButtonCallback) {
        self.clickedButtonCallback(actionSheet, buttonIndex);
    }
    
    // ボタンごとの処理を実行
    id blockObject = [self.buttonCallbacks objectAtIndex:buttonIndex];
    
    if(![blockObject isMemberOfClass:[NSNull class]]) {
        ((UIActionSheetBlockWithButtonIndex)blockObject)(actionSheet, buttonIndex);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.didDismissCallback) {
        self.didDismissCallback(actionSheet, buttonIndex);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.willDismissCallback) {
        self.willDismissCallback(actionSheet, buttonIndex);
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    if(self.willPresentCallback) {
        self.willPresentCallback(actionSheet);
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    if(self.didPresentCallback) {
        self.didPresentCallback(actionSheet);
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if(self.cancelCallback) {
        self.cancelCallback(actionSheet);
    }
}

@end
