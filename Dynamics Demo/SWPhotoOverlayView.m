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
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@end

@implementation SWPhotoOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        CGRect imageViewFrame = CGRectInset(self.bounds, 50, 150);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        imageView.backgroundColor = [UIColor redColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        self.imageView.userInteractionEnabled = YES;
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self.imageView addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}

- (void)handlePanGesture:(UIGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [gestureRecognizer locationInView:self.imageView];
        UIOffset offset = UIOffsetMake(touchLocation.x - self.imageView.frame.size.width/2, touchLocation.y - self.imageView.frame.size.height/2);
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.imageView offsetFromCenter:offset attachedToAnchor:[gestureRecognizer locationInView:self]];
        attachment.length = 0.0;
        [self.animator addBehavior:attachment];
        self.attachmentBehavior = attachment;
        
        UIGravityBehavior *fall = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
        fall.magnitude = 4.0;
        fall.action = ^{
            if (!CGRectIntersectsRect(self.frame, self.imageView.frame)) {
                self.animator = nil;
                [self fadeOut:0.2];
            }
        };
        [self.animator addBehavior:fall];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        [self.animator removeBehavior:self.attachmentBehavior];
        self.attachmentBehavior = nil;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.attachmentBehavior.anchorPoint = [gestureRecognizer locationInView:self];
    }
}

- (void)handleTapGesture:(UIGestureRecognizer*)gestureRecognizer {
    if (CGRectContainsPoint(self.imageView.frame, [gestureRecognizer locationInView:self])) {
        NSLog(@"Got a tap on the image view");
        
        UIPushBehavior *kick = [[UIPushBehavior alloc] initWithItems:@[self.imageView] mode:UIPushBehaviorModeInstantaneous];
        kick.angle = M_PI_2 * 3;
        kick.magnitude = 20.0;
        
        UIGravityBehavior *fall = [[UIGravityBehavior alloc] initWithItems:@[self.imageView]];
        fall.magnitude = 4.0;
        fall.action = ^{
            if (!CGRectIntersectsRect(self.frame, self.imageView.frame)) {
                self.animator = nil;
                [self fadeOut:0.2];
            }
        };

        [self.animator addBehavior:kick];
        [self.animator addBehavior:fall];
    } else {
        [self fadeOut:0.5];
    }
}

- (void)fadeOut:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
