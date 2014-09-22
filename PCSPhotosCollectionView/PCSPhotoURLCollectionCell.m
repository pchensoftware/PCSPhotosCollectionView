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
#define kProgressViewLeftMargin     20
#define kProgressViewHeight         20

@interface PCSPhotoURLCollectionCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIProgressView *progressView;

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
      
      self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
      self.progressView.frame = CGRectMake(kProgressViewLeftMargin, self.frame.size.height / 2 - kProgressViewHeight,
                                           self.frame.size.width - 2 * kProgressViewLeftMargin, kProgressViewHeight);
      self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
      self.progressView.progress = 0;
      [self addSubview:self.progressView];
      
   }
   return self;
}

- (void)setPhotoURL:(NSString *)photoURL {
   _photoURL = photoURL;
   self.progressView.alpha = 1;
   __weak PCSPhotoURLCollectionCell *weakself = self;
   
   [self.imageView sd_setImageWithURL:[NSURL URLWithString:_photoURL] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageContinueInBackground|SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
      weakself.progressView.progress = (float) receivedSize / expectedSize;
      
   } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      weakself.progressView.alpha = 0;
   }];
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
