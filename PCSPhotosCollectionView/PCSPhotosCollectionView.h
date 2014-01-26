//====================================================================================================
// Author: Peter Chen
// Created: 1/12/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import <UIKit/UIKit.h>


@interface PCSPhotosCollectionView : UIView

@property (nonatomic, strong) NSArray *photoURLs; // array of NSString's
@property (nonatomic, assign) BOOL bottomPageControlHidden;

@end
