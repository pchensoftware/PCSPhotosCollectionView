//====================================================================================================
// Author: Peter Chen
// Created: 1/12/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "PCSPhotosCollectionView.h"
#import "PCSPhotoURLCollectionCell.h"

#define kPhotoRightMargin  10

@interface PCSPhotosCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PCSPhotosCollectionView

- (id)initWithFrame:(CGRect)frame {
   if ((self = [super initWithFrame:frame])) {
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
      layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
      layout.minimumInteritemSpacing = kPhotoRightMargin;
      layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kPhotoRightMargin);
      
      CGRect collectionViewFrame = self.bounds;
      collectionViewFrame.size.width = self.frame.size.width + kPhotoRightMargin;
      
      self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
      self.collectionView.alwaysBounceHorizontal = YES;
      self.collectionView.pagingEnabled = YES;
      self.collectionView.dataSource = self;
      self.collectionView.delegate = self;
      self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      [self.collectionView registerClass:[PCSPhotoURLCollectionCell class] forCellWithReuseIdentifier:@"CellId"];
      [self addSubview:self.collectionView];
   }
   return self;
}

- (void)setPhotoURLs:(NSArray *)photoURLs {
   _photoURLs = photoURLs;
}

- (void)setBottomIndicatorViewHidden:(BOOL)bottomIndicatorViewHidden {
   _bottomIndicatorViewHidden = bottomIndicatorViewHidden;
}

//====================================================================================================
#pragma mark - Collection view
//====================================================================================================

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return [self.photoURLs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   PCSPhotoURLCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
   cell.photoURL = self.photoURLs[indexPath.row];
   return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   return self.bounds.size;
}

@end
