//
//  SWPhotoOverlayView.m
//  Dynamics Demo
//
//  Created by Simon Whitaker on 24/11/2013.
//  Copyright (c) 2013 Simon Whitaker. All rights reserved.
//

#import "SWPhotoOverlayView.h"

@interface SWPhotoOverlayView()
@property (nonatomic, readwrite, weak) UIImageView *imageView;
@end

@implementation SWPhotoOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
        CGRect imageViewFrame = CGRectInset(self.bounds, 50, 50);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
        imageView.layer.shadowOffset = CGSizeMake(0, 2.0);
        imageView.layer.shadowRadius = 4.0;
        imageView.layer.shadowOpacity = 0.8;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (void)handleTapGesture:(UIGestureRecognizer*)gestureRecognizer {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
