//
//  NSValue+MEDGeometryAdditions.h
//  Archimedes
//
//  Created by Justin Spahr-Summers on 2012-12-12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

// Boxes a CGRect, CGPoint, or CGSize value.
//
// Returns an NSValue.
#define MEDBox(VALUE) \
    ({ \
        __typeof__(VALUE) value_ = (VALUE); \
        const void *value_ptr_ = &value_; \
        \
        _Generic(value_, \
            CGRect: [NSValue med_valueWithRect:*(CGRect *)value_ptr_], \
            CGSize: [NSValue med_valueWithSize:*(CGSize *)value_ptr_], \
            CGPoint: [NSValue med_valueWithPoint:*(CGPoint *)value_ptr_] \
        ); \
    })

// Implements a cross-platform interface for manipulating geometry structures
// stored in an NSValue.
@interface NSValue (MEDGeometryAdditions)

// Returns an NSValue wrapping the given rectangle.
+ (NSValue *)med_valueWithRect:(CGRect)rect;

// Returns an NSValue wrapping the given point.
+ (NSValue *)med_valueWithPoint:(CGPoint)point;

// Returns an NSValue wrapping the given size.
+ (NSValue *)med_valueWithSize:(CGSize)size;

// Returns the CGRect value in the receiver.
@property (nonatomic, assign, readonly) CGRect med_rectValue;

// Returns the CGPoint value in the receiver.
@property (nonatomic, assign, readonly) CGPoint med_pointValue;

// Returns the CGSize value in the receiver.
@property (nonatomic, assign, readonly) CGSize med_sizeValue;

@end
