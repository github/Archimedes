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

__block NSValue *rectValue;
__block NSValue *pointValue;
__block NSValue *sizeValue;

beforeEach(^{
	rectValue = [NSValue med_valueWithRect:rect];
	expect(rectValue).notTo.beNil();

	pointValue = [NSValue med_valueWithPoint:point];
	expect(pointValue).notTo.beNil();

	sizeValue = [NSValue med_valueWithSize:size];
	expect(sizeValue).notTo.beNil();
});

it(@"should wrap a CGRect", ^{
	expect(CGRectEqualToRect(rectValue.med_rectValue, rect)).to.beTruthy();
});

it(@"should wrap a CGPoint", ^{
	expect(CGPointEqualToPoint(pointValue.med_pointValue, point)).to.beTruthy();
});

it(@"should wrap a CGSize", ^{
	expect(CGSizeEqualToSize(sizeValue.med_sizeValue, size)).to.beTruthy();
});

describe(@"MEDBox", ^{
	it(@"should wrap a CGRect", ^{
		NSValue *value = MEDBox(rect);
		expect(value).to.equal(rectValue);
	});

	it(@"should wrap a CGPoint", ^{
		NSValue *value = MEDBox(point);
		expect(value).to.equal(pointValue);
	});

	it(@"should wrap a CGSize", ^{
		NSValue *value = MEDBox(size);
		expect(value).to.equal(sizeValue);
	});

	// Specifically used because we don't support it directly.
	it(@"should wrap a CGAffineTransform", ^{
		CGAffineTransform transform = CGAffineTransformMake(1, 2, 5, 8, 13, 21);

		NSValue *value = MEDBox(transform);
		expect(value).notTo.beNil();

		CGAffineTransform readTransform;
		[value getValue:&readTransform];

		expect(CGAffineTransformEqualToTransform(transform, readTransform)).to.beTruthy();
	});
});

describe(@"med_geometryStructType", ^{
	it(@"should identify a CGRect", ^{
		expect(rectValue.med_geometryStructType).to.equal(MEDGeometryStructTypeRect);
	});

	it(@"should identify a CGPoint", ^{
		expect(pointValue.med_geometryStructType).to.equal(MEDGeometryStructTypePoint);
	});

	it(@"should identify a CGSize", ^{
		expect(sizeValue.med_geometryStructType).to.equal(MEDGeometryStructTypeSize);
	});

	it(@"should return MEDGeometryStructTypeUnknown for unknown types", ^{
		NSNumber *num = @5;
		expect(num.med_geometryStructType).to.equal(MEDGeometryStructTypeUnknown);
	});
});

SpecEnd
