//
//  NSValue+MEDGeometryAdditions.h
//  Archimedes
//
//  Created by Justin Spahr-Summers on 2012-12-12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

// Implements a cross-platform interface for manipulating geometry structures
// stored in an NSValue.
@interface NSValue (MEDGeometryAdditions)

// Returns an NSValue wrapping the given rectangle.
+ (NSValue *)med_valueWithRect:(CGRect)rect;

// Returns an NSValue wrapping the given point.
+ (NSValue *)med_valueWithPoint:(CGPoint)point;

// Returns an NSValue wrapping the given size.
+ (NSValue *)med_valueWithSize:(CGSize)size;

// Returns the `CGRect` value in the receiver.
@property (nonatomic, assign, readonly) CGRect med_rectValue;

// Returns the `CGPoint` value in the receiver.
@property (nonatomic, assign, readonly) CGPoint med_pointValue;

// Returns the `CGSize` value in the receiver.
@property (nonatomic, assign, readonly) CGSize med_sizeValue;

@end
