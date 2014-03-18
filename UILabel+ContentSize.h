//
//  UILabel+ContentSize.h
//
//
//  Created by Juniorchen on 14-3-18.
//
//

@interface UILabel (ContentSize)
- (CGSize)ContentSize {
  NSMutableParagraphStyle *paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineBreakMode = self.lineBreakMode;
  paragraphStyle.alignment = self.textAlignment;

  NSDictionary *attributes = @{
    NSFontAttributeName : self.font,
    NSParagraphStyleAttributeName : paragraphStyle
  };

  CGSize contentSize =
      [self.text boundingRectWithSize:self.frame.size
                              options:(NSStringDrawingUsesLineFragmentOrigin |
                                       NSStringDrawingUsesFontLeading)
                           attributes:attributes
                              context:nil].size;
  return contentSize;
}
@end
