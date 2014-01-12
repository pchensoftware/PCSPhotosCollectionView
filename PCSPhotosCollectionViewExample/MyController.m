//====================================================================================================
// Author: Peter Chen
// Created: 1/12/14
// Copyright 2014 Peter Chen
//====================================================================================================

#import "MyController.h"
#import "PCSPhotosCollectionView.h"

@interface MyController()

@property (nonatomic, strong) PCSPhotosCollectionView *photosCollectionView;

@end

@implementation MyController

- (id)init {
   if ((self = [super init])) {
   }
   return self;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   self.title = @"Horizontal Photos";
   
   self.photosCollectionView = [[PCSPhotosCollectionView alloc] initWithFrame:self.view.bounds];
   self.photosCollectionView.photoURLs = @[ @"http://hidoodle.com/images/hidoodle/hidoodle-icon-and-text.png",
                                            @"http://upload.wikimedia.org/wikipedia/en/4/40/Octocat,_a_Mascot_of_Github.jpg",
                                            @"https://github-camo.global.ssl.fastly.net/20232135c459ea65f3b35e4c779725bc789b4c9c/687474703a2f2f6f63746f6465782e6769746875622e636f6d2f696d616765732f646f6a6f6361742e6a7067",
                                            @"http://octodex.github.com/images/octobiwan.jpg",
                                            @"https://github.global.ssl.fastly.net/images/modules/styleguide/linktocat.png",
                                            @"http://dotfiles.github.io/images/forktocat.jpg" ];
   self.photosCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   [self.view addSubview:self.photosCollectionView];
}

//====================================================================================================
#pragma mark - Events
//====================================================================================================



@end
