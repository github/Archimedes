//
//  NSValue+MEDGeometryAdditions.h
//  Archimedes
//
//  Created by Justin Spahr-Summers on 2012-12-12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

// Boxes a geometry structure.
//
// Returns an NSValue.
#define MEDBox(VALUE) \
    ({ \
        __typeof__(VALUE) value_ = (VALUE); \
        const void *value_ptr_ = &value_; \
        \
        [NSValue valueWithBytes:value_ptr_ objCType:@encode(__typeof__(VALUE))]; \
    })

// Indicates the type of geometry structure that an NSValue contains.
//
// MEDGeometryStructTypeUnknown - The NSValue contains a value of unknown type.
// MEDGeometryStructTypeRect    - The NSValue contains a CGRect.
// MEDGeometryStructTypePoint   - The NSValue contains a CGPoint.
// MEDGeometryStructTypeSize    - The NSValue contains a CGSize.
typedef enum : NSUInteger {
    MEDGeometryStructTypeUnknown,
    MEDGeometryStructTypeRect,
    MEDGeometryStructTypePoint,
    MEDGeometryStructTypeSize
} MEDGeometryStructType;

// Implements a cross-platform interface for manipulating geometry structures
// stored in an NSValue.
@interface NSValue (MEDGeometryAdditions)

// Returns an NSValue wrapping the given rectangle.
+ (NSValue *)med_valueWithRect:(CGRect)rect;

// Returns an NSValue wrapping the given point.
+ (NSValue *)med_valueWithPoint:(CGPoint)point;

// Returns an NSValue wrapping the given size.
+ (NSValue *)med_valueWithSize:(CGSize)size;

// Returns the type of geometry structure stored in the receiver, or
// MEDGeometryStructTypeUnknown if the type can't be identified.
@property (nonatomic, assign, readonly) MEDGeometryStructType med_geometryStructType;

// Returns the CGRect value in the receiver.
@property (nonatomic, assign, readonly) CGRect med_rectValue;

// Returns the CGPoint value in the receiver.
@property (nonatomic, assign, readonly) CGPoint med_pointValue;

// Returns the CGSize value in the receiver.
@property (nonatomic, assign, readonly) CGSize med_sizeValue;

@end
