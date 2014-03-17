//
//  UIImageView+TapImageV.m
//  JASidePanels
//
//  Created by Juniorchen on 14-3-14.
//
//

#import "UIImageView+TapImageV.h"
#import "JAAppDelegate.h"
#import "JASidePanelController.h"

@implementation UIImageView (TapImageV)

#pragma mark - UIImageView tap gestrure
- (void)addTap {
  self.userInteractionEnabled = YES;
  UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(tap)];
  [self addGestureRecognizer:tap];
  return;
}

- (void)tap {
  MWPhotoBrowser *mw = [[MWPhotoBrowser alloc] initWithDelegate:self];
  mw.displayActionButton = NO;
  UINavigationController *nav =
      [[UINavigationController alloc] initWithRootViewController:mw];
  JAAppDelegate *appdelegate =
      (JAAppDelegate *)[UIApplication sharedApplication].delegate;
  [appdelegate.viewController presentViewController:nav
                                           animated:YES
                                         completion:nil];
  return;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
  return 1;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser
               photoAtIndex:(NSUInteger)index {
  MWPhoto *photo = [[MWPhoto alloc] initWithImage:self.image];
  return photo;
}
@end
