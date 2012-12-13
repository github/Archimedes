//
//  NSValue+MEDGeometryAdditions.m
//  Archimedes
//
//  Created by Justin Spahr-Summers on 2012-12-12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "NSValue+MEDGeometryAdditions.h"

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
	#import <AppKit/AppKit.h>
#endif

@implementation NSValue (MEDGeometryAdditions)

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED

+ (NSValue *)med_valueWithRect:(CGRect)rect {
	return [self valueWithCGRect:rect];
}

+ (NSValue *)med_valueWithPoint:(CGPoint)point {
	return [self valueWithCGPoint:point];
}

+ (NSValue *)med_valueWithSize:(CGSize)size {
	return [self valueWithCGSize:size];
}

- (CGRect)med_rectValue {
	return self.CGRectValue;
}

- (CGPoint)med_pointValue {
	return self.CGPointValue;
}

- (CGSize)med_sizeValue {
	return self.CGSizeValue;
}

#elif TARGET_OS_MAC

+ (NSValue *)med_valueWithRect:(CGRect)rect {
	return [self valueWithRect:rect];
}

+ (NSValue *)med_valueWithPoint:(CGPoint)point {
	return [self valueWithPoint:point];
}

+ (NSValue *)med_valueWithSize:(CGSize)size {
	return [self valueWithSize:size];
}

- (CGRect)med_rectValue {
	return self.rectValue;
}

- (CGPoint)med_pointValue {
	return self.pointValue;
}

- (CGSize)med_sizeValue {
	return self.sizeValue;
}

#endif

@end
