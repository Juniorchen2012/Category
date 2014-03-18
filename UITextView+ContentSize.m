//
//  UITextView+ContentSize.m
//
//
//  Created by Juniorchen on 14-3-18.
//
//

#import "UITextView+ContentSize.h"

@implementation UITextView (ContentSize)
- (CGSize)ContentSize {
  __weak UITextView *textView = atextView;
  if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
    // This is the code for iOS 7. contentSize no longer returns the correct
    // value, so
    // we have to calculate it.
    //
    // This is partly borrowed from HPGrowingTextView, but I've replaced the
    // magic fudge factors with the calculated values (having worked out where
    // they came from)

    CGRect frame = textView.bounds;

    // Take account of the padding added around the text.

    UIEdgeInsets textContainerInsets = textView.textContainerInset;
    UIEdgeInsets contentInsets = textView.contentInset;

    CGFloat leftRightPadding = textContainerInsets.left +
                               textContainerInsets.right +
                               textView.textContainer.lineFragmentPadding * 2 +
                               contentInsets.left + contentInsets.right;
    CGFloat topBottomPadding = textContainerInsets.top +
                               textContainerInsets.bottom + contentInsets.top +
                               contentInsets.bottom;

    frame.size.width -= leftRightPadding;
    frame.size.height -= topBottomPadding;

    NSString *textToMeasure = textView.text;
      //注意不能以空格开头
    if ([textToMeasure hasSuffix:@"\n"]) {
      textToMeasure = [NSString stringWithFormat:@"%@-", textView.text];
    }

    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.

    NSMutableParagraphStyle *paragraphStyle =
        [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];

    NSDictionary *attributes = @{
      NSFontAttributeName : textView.font,
      NSParagraphStyleAttributeName : paragraphStyle
    };

    CGRect size = [textToMeasure
        boundingRectWithSize:CGSizeMake(CGRectGetWidth(frame), MAXFLOAT)
                     options:NSStringDrawingUsesLineFragmentOrigin
                  attributes:attributes
                     context:nil];

    CGFloat measuredHeight = ceilf(CGRectGetHeight(size) + topBottomPadding);
    return measuredHeight;
  } else {
    return textView.contentSize.height;
  }
}
@end
