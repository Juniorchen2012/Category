//
//  UIImageView+TapImageV.h
//  JASidePanels
//
//  Created by Juniorchen on 14-3-14.
//
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface UIImageView (TapImageV)<MWPhotoBrowserDelegate>
-(void)addTap;
@end
