//
//  SWPhotoCell.m
//  Dynamics Demo
//
//  Created by Simon Whitaker on 24/11/2013.
//  Copyright (c) 2013 Simon Whitaker. All rights reserved.
//

#import "SWPhotoCell.h"

@interface SWPhotoCell()
@property (nonatomic, readwrite, weak) UIImageView *imageView;
@end

@implementation SWPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

@end
