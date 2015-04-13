//
//  CGRectObject.h
//  531 Trainer
//
//  Created by Kevin French on 3/24/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRectObject : NSObject

@property double x;
@property double y;

@property double width;
@property double height;

-(instancetype)initWithX:(double) x y:(double) y width:(double) width height:(double) height;
-(instancetype)initWithRect:(CGRect)rect;
-(CGRect)CGRectFromObject;

@end
