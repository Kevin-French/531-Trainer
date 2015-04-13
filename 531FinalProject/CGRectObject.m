//
//  CGRectObject.m
//  531 Trainer
//
//  Created by Kevin French on 3/24/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "CGRectObject.h"

@implementation CGRectObject

-(instancetype)initWithX:(double) x y:(double) y width:(double) width height:(double) height {

    if (self = [super init]) {
        self.x = x;
        self.y = y;
        self.width = width;
        self.height = height;
    }
    
    return self;
}

-(instancetype)initWithRect:(CGRect)rect {

    if (self = [super init]) {
        self.x = rect.origin.x;
        self.y = rect.origin.y;
        self.width = rect.size.width;
        self.height = rect.size.height;
    }
    
    return self;
}

-(CGRect)CGRectFromObject {
    
    return CGRectMake(self.x, self.y, self.width, self.height);
}

@end
