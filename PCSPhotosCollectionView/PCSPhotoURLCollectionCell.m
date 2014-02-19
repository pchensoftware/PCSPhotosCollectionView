//====================================================================================================
// Author: Peter Chen
// Created: 1/12/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "PCSPhotoURLCollectionCell.h"
#import "UIImageView+WebCache.h" // From SDWebImage

#define kMinZoomScale               1
#define kMaxZoomScale               6
#define kZoomInByWhenDoubleTapped   2

@interface PCSPhotoURLCollectionCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PCSPhotoURLCollectionCell

- (id)initWithFrame:(CGRect)frame {
   if ((self = [super initWithFrame:frame])) {
      self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
      self.scrollView.minimumZoomScale = kMinZoomScale;
      self.scrollView.maximumZoomScale = kMaxZoomScale;
      self.scrollView.showsHorizontalScrollIndicator = NO;
      self.scrollView.showsVerticalScrollIndicator = NO;
      self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      self.scrollView.delegate = self;
      [self.contentView addSubview:self.scrollView];
      
      UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_scrollViewDoubleTapped)];
      doubleTapGesture.numberOfTapsRequired = 2;
      [self.scrollView addGestureRecognizer:doubleTapGesture];
      
      self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
      self.imageView.contentMode = UIViewContentModeScaleAspectFit;
      self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      [self.scrollView addSubview:self.imageView];
   }
   return self;
}

- (void)setPhotoURL:(NSString *)photoURL {
   _photoURL = photoURL;
   [self.imageView setImageWithURL:[NSURL URLWithString:_photoURL] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageContinueInBackground];
}

//==================================================
#pragma mark - Scroll view
//==================================================

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   return self.imageView;
}

- (void)_scrollViewDoubleTapped {
   if (self.scrollView.zoomScale == kMaxZoomScale)
      [self.scrollView setZoomScale:kMinZoomScale animated:YES];
   else
      [self.scrollView setZoomScale:MIN(kMaxZoomScale, self.scrollView.zoomScale * kZoomInByWhenDoubleTapped) animated:YES];
}

@end
