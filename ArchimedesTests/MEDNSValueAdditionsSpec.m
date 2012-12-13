//
//  MEDNSValueAdditionsSpec.m
//  Archimedes
//
//  Created by Justin Spahr-Summers on 2012-12-12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

SpecBegin(MEDNSValueAdditions)

CGRect rect = CGRectMake(10, 20, 30, 40);
CGPoint point = CGPointMake(100, 200);
CGSize size = CGSizeMake(300, 400);

it(@"should wrap a CGRect", ^{
	NSValue *value = [NSValue med_valueWithRect:rect];
	expect(value).notTo.beNil();
	expect(CGRectEqualToRect(value.med_rectValue, rect)).to.beTruthy();
});

it(@"should wrap a CGSize", ^{
	NSValue *value = [NSValue med_valueWithSize:size];
	expect(value).notTo.beNil();
	expect(CGSizeEqualToSize(value.med_sizeValue, size)).to.beTruthy();
});

it(@"should wrap a CGPoint", ^{
	NSValue *value = [NSValue med_valueWithPoint:point];
	expect(value).notTo.beNil();
	expect(CGPointEqualToPoint(value.med_pointValue, point)).to.beTruthy();
});

describe(@"MEDBox", ^{
	it(@"should wrap a CGRect", ^{
		NSValue *value = MEDBox(rect);
		expect(value).to.equal([NSValue med_valueWithRect:rect]);
	});

	it(@"should wrap a CGSize", ^{
		NSValue *value = MEDBox(size);
		expect(value).to.equal([NSValue med_valueWithSize:size]);
	});

	it(@"should wrap a CGPoint", ^{
		NSValue *value = MEDBox(point);
		expect(value).to.equal([NSValue med_valueWithPoint:point]);
	});
});

SpecEnd
