//
//  SWPhotoCollectionViewController.m
//  Dynamics Demo
//
//  Created by Simon Whitaker on 24/11/2013.
//  Copyright (c) 2013 Simon Whitaker. All rights reserved.
//

#import "SWPhotoCollectionViewController.h"
#import "SWPhotoCell.h"
#import "SWPhotoOverlayView.h"

static NSString *const kCellId = @"cellId";

@interface SWPhotoCollectionViewController ()

@end

@implementation SWPhotoCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[SWPhotoCell class] forCellWithReuseIdentifier:kCellId];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    cell.imageView.image = [self _imageForIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SWPhotoOverlayView *pov = [[SWPhotoOverlayView alloc] initWithFrame:self.view.bounds];
    pov.imageView.image = [self _imageForIndexPath:indexPath];
    pov.alpha = 0.0;
    [self.view addSubview:pov];
    [UIView animateWithDuration:0.2 animations:^{
        pov.alpha = 1.0;
    }];
}

- (UIImage*)_imageForIndexPath:(NSIndexPath*)indexPath {
    return [UIImage imageNamed:[NSString stringWithFormat:@"photo_%02i.jpg", indexPath.row + 1]];
}

@end
