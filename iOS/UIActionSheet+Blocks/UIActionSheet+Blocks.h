#include <objc/runtime.h>

@class UIActionSheetCallback;

@interface UIActionSheet (Blocks)

typedef void (^UIActionSheetBlock)(UIActionSheet *actionSheet);
typedef void (^UIActionSheetBlockWithButtonIndex)(UIActionSheet *actionSheet, NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (void)addButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block;
- (void)addCancelButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block;
- (void)addDestructiveButtonWithTitle:(NSString *)title block:(UIActionSheetBlockWithButtonIndex)block;

@property (nonatomic, retain) UIActionSheetCallback *callback;

@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex clickedButtonCallback;
@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex didDismissCallback;
@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex willDismissCallback;
@property (nonatomic, copy) UIActionSheetBlock willPresentCallback;
@property (nonatomic, copy) UIActionSheetBlock didPresentCallback;
@property (nonatomic, copy) UIActionSheetBlock cancelCallback;

@end


#pragma mark -

@interface UIActionSheetCallback : NSObject <UIActionSheetDelegate>

@property (nonatomic, retain) NSMutableArray *buttonCallbacks;

@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex clickedButtonCallback;
@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex didDismissCallback;
@property (nonatomic, copy) UIActionSheetBlockWithButtonIndex willDismissCallback;
@property (nonatomic, copy) UIActionSheetBlock willPresentCallback;
@property (nonatomic, copy) UIActionSheetBlock didPresentCallback;
@property (nonatomic, copy) UIActionSheetBlock cancelCallback;

@end
