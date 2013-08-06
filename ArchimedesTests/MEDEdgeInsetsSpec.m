//
//  MEDEdgeInsetsSpec.m
//  Archimedes
//
//  Created by Indragie Karunaratne on 8/6/2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "MEDEdgeInsets.h"

MEDEdgeInsets insets = (MEDEdgeInsets){1, 2, 3, 4};

SpecBegin(MEDNSEdgeInsets);

it(@"should check equality between MEDEdgeInsets", ^{
	MEDEdgeInsets insets2 = (MEDEdgeInsets){1.05f, 2.05f, 3.05f, 4.05f};
	MEDEdgeInsets insets3 = (MEDEdgeInsets){5, 6, 7, 8};
	expect(MEDEdgeInsetsEqualToEdgeInsets(insets, insets)).to.beTruthy();
	expect(MEDEdgeInsetsEqualToEdgeInsets(insets, insets2)).to.beTruthy();
	expect(MEDEdgeInsetsEqualToEdgeInsets(insets, insets3)).to.beFalsy();
});

it(@"should make an MEDEdgeInsets", ^{
	expect(MEDEdgeInsetsEqualToEdgeInsets(MEDEdgeInsetsMake(1, 2, 3, 4), insets)).to.beTruthy();
});

it(@"should inset a CGRect", ^{
	CGRect rect = CGRectMake(10, 10, 10, 10);
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	CGRect insetRect = CGRectMake(12, 11, 4, 6);
#elif TARGET_OS_MAC
	CGRect insetRect = CGRectMake(12, 13, 4, 6);
#endif
	expect(CGRectEqualToRect(MEDEdgeInsetsInsetRect(rect, insets), insetRect));
});

it(@"should create a string from an MEDEdgeInsets", ^{
	expect(NSStringFromMEDEdgeInsets(insets)).to.equal(@"{1, 2, 3, 4}");
});

it(@"should create an MEDEdgeInsets from a string", ^{
	expect(MEDEdgeInsetsEqualToEdgeInsets(insets, MEDEdgeInsetsFromString(@"{1, 2, 3, 4}"))).to.beTruthy();
});

SpecEnd;
