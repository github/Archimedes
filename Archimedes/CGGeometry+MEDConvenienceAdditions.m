//
//  CGGeometry+MEDConvenienceAdditions.m
//  Archimedes
//
//  Created by Justin Spahr-Summers on 18.01.12.
//  Copyright 2012 GitHub. All rights reserved.
//

/*

Portions copyright (c) 2012, Bitswift, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Neither the name of the Bitswift, Inc. nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#import "CGGeometry+MEDConvenienceAdditions.h"

// Conditionalizes fmax() and similar floating-point functions based on argument
// type, so they compile without casting on both OS X and iOS.
#import <tgmath.h>

// Hide our crazy macros within the implementation.
#undef CGRectDivide
#undef CGRectDivideWithPadding

CGPoint CGRectCenterPoint(CGRect rect) {
	return CGPointMake(CGRectGetMinX(rect) + CGRectGetWidth(rect) / 2, CGRectGetMinY(rect) + CGRectGetHeight(rect) / 2);
}

CGRect CGRectRemainder(CGRect rect, CGFloat amount, CGRectEdge edge) {
	CGRect slice, remainder;
	CGRectDivide(rect, &slice, &remainder, amount, edge);

	return remainder;
}

CGRect CGRectSlice(CGRect rect, CGFloat amount, CGRectEdge edge) {
	CGRect slice, remainder;
	CGRectDivide(rect, &slice, &remainder, amount, edge);

	return slice;
}

CGRect CGRectScaleAspectFit(CGRect rect, CGRect maxRect) {
    CGFloat originalAspectRatio = CGRectGetWidth(rect) / CGRectGetHeight(rect);
    CGFloat maxAspectRatio = CGRectGetWidth(maxRect) / CGRectGetHeight(maxRect);
    
    CGRect newRect = maxRect;
    if (originalAspectRatio > maxAspectRatio) { // scale by width
        newRect.size.height = CGRectGetHeight(maxRect) * CGRectGetHeight(rect) / CGRectGetWidth(rect);
        newRect.origin.y += (CGRectGetHeight(maxRect) - CGRectGetHeight(newRect))/2.0;
    } else { // or scale by height
        newRect.size.width = CGRectGetHeight(maxRect) * CGRectGetWidth(rect) / CGRectGetHeight(rect);
        newRect.origin.x += (CGRectGetWidth(maxRect) - CGRectGetWidth(newRect))/2.0;
    }
    
    return newRect;
}

CGRect CGRectScaleAspectFill(CGRect rect, CGRect minRect) {
    CGFloat scaleWidth = CGRectGetWidth(minRect) / CGRectGetWidth(rect);
    CGFloat scaleHeight = CGRectGetHeight(minRect) / CGRectGetWidth(rect);

    CGFloat scale = MAX(scaleWidth, scaleHeight);

    
    CGFloat newWidth = CGRectGetWidth(rect) * scale;
    CGFloat newHeight = CGRectGetHeight(rect) * scale;
    
    CGFloat newX = ((CGRectGetWidth(minRect) - newWidth) / 2.0f);
    CGFloat newY = ((CGRectGetHeight(minRect) - newHeight) / 2.0f);
    
    CGRect newRect = CGRectMake(newX, newY, newWidth, newHeight);
    return newRect;
}

CGRect CGRectGrow(CGRect rect, CGFloat amount, CGRectEdge edge) {
	switch (edge) {
		case CGRectMinXEdge:
			return CGRectMake(CGRectGetMinX(rect) - amount, CGRectGetMinY(rect), CGRectGetWidth(rect) + amount, CGRectGetHeight(rect));

		case CGRectMinYEdge:
			return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) - amount, CGRectGetWidth(rect), CGRectGetHeight(rect) + amount);

		case CGRectMaxXEdge:
			return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect) + amount, CGRectGetHeight(rect));

		case CGRectMaxYEdge:
			return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect) + amount);

		default:
			NSCAssert(NO, @"Unrecognized CGRectEdge %i", (int)edge);
			return CGRectNull;
	}
}

void CGRectDivideWithPadding(CGRect rect, CGRect *slicePtr, CGRect *remainderPtr, CGFloat sliceAmount, CGFloat padding, CGRectEdge edge) {
	CGRect slice;

	// slice
	CGRectDivide(rect, &slice, &rect, sliceAmount, edge);
	if (slicePtr) *slicePtr = slice;

	// padding / remainder
	CGRectDivide(rect, &slice, &rect, padding, edge);
	if (remainderPtr) *remainderPtr = rect;
}

CGRect CGRectFloor(CGRect rect) {
	#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
		return CGRectMake(floor(rect.origin.x), floor(rect.origin.y), floor(rect.size.width), floor(rect.size.height));
	#elif TARGET_OS_MAC
		return CGRectMake(floor(rect.origin.x), ceil(rect.origin.y), floor(rect.size.width), floor(rect.size.height));
	#endif
}

CGRect CGRectMakeInverted(CGRect containingRect, CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
	CGRect rect = CGRectMake(x, y, width, height);
	return CGRectInvert(containingRect, rect);
}

CGRect CGRectInvert(CGRect containingRect, CGRect rect) {
	return CGRectMake(CGRectGetMinX(rect), CGRectGetHeight(containingRect) - CGRectGetMaxY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
}

BOOL CGRectEqualToRectWithAccuracy(CGRect rect, CGRect rect2, CGFloat epsilon) {
	return CGPointEqualToPointWithAccuracy(rect.origin, rect2.origin, epsilon) && CGSizeEqualToSizeWithAccuracy(rect.size, rect2.size, epsilon);
}

CGRect CGRectWithSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

CGRect CGRectConvertToUnitRect(CGRect rect) {
	CGAffineTransform unitTransform = CGAffineTransformMakeScale(1 / CGRectGetWidth(rect), 1 / CGRectGetHeight(rect));
	return CGRectApplyAffineTransform(rect, unitTransform);
}

CGRect CGRectConvertFromUnitRect(CGRect rect, CGRect destinationRect) {
	CGAffineTransform unitTransform = CGAffineTransformMakeScale(CGRectGetWidth(rect), CGRectGetHeight(rect));
	return CGRectApplyAffineTransform(destinationRect, unitTransform);
}

BOOL CGSizeEqualToSizeWithAccuracy(CGSize size, CGSize size2, CGFloat epsilon) {
	return (fabs(size.width - size2.width) <= epsilon) && (fabs(size.height - size2.height) <= epsilon);
}

CGSize CGSizeScale(CGSize size, CGFloat scale) {
	return CGSizeMake(size.width * scale, size.height * scale);
}

CGPoint CGPointFloor(CGPoint point) {
	#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
		return CGPointMake(floor(point.x), floor(point.y));
	#elif TARGET_OS_MAC
		return CGPointMake(floor(point.x), ceil(point.y));
	#endif
}

BOOL CGPointEqualToPointWithAccuracy(CGPoint p, CGPoint q, CGFloat epsilon) {
	return (fabs(p.x - q.x) <= epsilon) && (fabs(p.y - q.y) <= epsilon);
}

CGFloat CGPointDotProduct(CGPoint point, CGPoint point2) {
	return (point.x * point2.x + point.y * point2.y);
}

CGPoint CGPointScale(CGPoint point, CGFloat scale) {
	return CGPointMake(point.x * scale, point.y * scale);
}

CGFloat CGPointLength(CGPoint point) {
	return (CGFloat)sqrt(CGPointDotProduct(point, point));
}

CGPoint CGPointNormalize(CGPoint point) {
	CGFloat len = CGPointLength(point);
	if (len > 0) return CGPointScale(point, 1/len);

	return point;
}

CGPoint CGPointProject(CGPoint point, CGPoint direction) {
	CGPoint normalizedDirection = CGPointNormalize(direction);
	CGFloat distance = CGPointDotProduct(point, normalizedDirection);

	return CGPointScale(normalizedDirection, distance);
}

CGPoint CGPointProjectAlongAngle(CGPoint point, CGFloat angleInDegrees) {
	CGFloat angleInRads = (CGFloat)(angleInDegrees * M_PI / 180);
	CGPoint direction = CGPointMake(cos(angleInRads), sin(angleInRads));
	return CGPointProject(point, direction);
}

CGFloat CGPointAngleInDegrees(CGPoint point) {
	return (CGFloat)(atan2(point.y, point.x) * 180 / M_PI);
}

CGPoint CGPointAdd(CGPoint p1, CGPoint p2) {
	return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint CGPointSubtract(CGPoint p1, CGPoint p2) {
	return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}
