//====================================================================================================
// Author: Peter Chen
// Created: 1/12/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "PCSPhotoURLCollectionCell.h"
#import "UIImageView+WebCache.h" // From SDWebImage

@interface PCSPhotoURLCollectionCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PCSPhotoURLCollectionCell

- (id)initWithFrame:(CGRect)frame {
   if ((self = [super initWithFrame:frame])) {
      self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
      self.imageView.contentMode = UIViewContentModeScaleAspectFit;
      self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      [self addSubview:self.imageView];
   }
   return self;
}

- (void)setPhotoURL:(NSString *)photoURL {
   _photoURL = photoURL;
   [self.imageView setImageWithURL:[NSURL URLWithString:_photoURL] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageContinueInBackground];
}

@end
