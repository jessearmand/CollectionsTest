#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSInteger iterationIndex;
	NSAutoreleasePool *innerPool;
	const NSInteger NUM_ELEMENTS = 1000000;
	const NSInteger NUM_TEST_ITERATIONS = 3;
	NSDate *startTime;
	NSDate *endTime;
	NSMutableArray *keys = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
	NSMutableArray *objects = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
	
	NSLog(@"Constructing test data for %d elements.", NUM_ELEMENTS);

	//
	// Preconstruct the arrays of keys and objects to use in the tests
	//
	NSAutoreleasePool *constructionPool = [[NSAutoreleasePool alloc] init];
	for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
	{
		NSString *keyString = [NSString stringWithFormat:@"%010ld", (long)(iterationIndex * 7)];
		[keys addObject:keyString];
		
		NSNumber *objectValue = [NSNumber numberWithInteger:iterationIndex];
		[objects addObject:objectValue];
		
	}
	[constructionPool drain];

	for (int i = 0; i < NUM_TEST_ITERATIONS; i++)
	{
		NSAutoreleasePool *loopPool = [[NSAutoreleasePool alloc] init];
		
		NSLog(@"=== Beginning test loop. Iteration %d of %d ===", i + 1, NUM_TEST_ITERATIONS);

		NSMutableArray *arrayOfObjects = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
		NSMutableArray *unsizedArray = [NSMutableArray array];
		NSMutableSet *setOfObjects = [NSMutableSet setWithCapacity:NUM_ELEMENTS];
		NSMutableSet *setFromArray = nil;
		NSMutableSet *unsizedSet = [NSMutableSet set];
		NSMapTable *testTable = [NSMapTable mapTableWithStrongToStrongObjects];
		NSMutableDictionary *testDictionary = [NSMutableDictionary dictionary];
		
		//
		// Test 1: Array construction when arrayWithCapacity: is used
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in objects)
		{
			[arrayOfObjects addObject:number];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the preallocated array took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 2: Array construction when arrayWithCapacity: is NOT used
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in objects)
		{
			[unsizedArray addObject:number];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the unpreallocated array took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 2: Array construction when arrayWithCapacity: is NOT used
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in arrayOfObjects)
		{
		}
		endTime = [NSDate date];
		NSLog(@"Iterating the array took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
//		//
//		// Test 2a: Array querying by isEqualTo:
//		//
//		innerPool = [[NSAutoreleasePool alloc] init];
//		startTime = [NSDate date];
//		for (NSNumber *number in objects)
//		{
//			[arrayOfObjects indexOfObject:number];
//		}
//		endTime = [NSDate date];
//		NSLog(@"Array querying by isEqualTo: took %g seconds",
//			[endTime timeIntervalSinceDate:startTime]);
//		[innerPool drain];
//		
//		//
//		// Test 2b: Array querying by pointer value
//		//
//		innerPool = [[NSAutoreleasePool alloc] init];
//		startTime = [NSDate date];
//		for (NSNumber *number in objects)
//		{
//			[arrayOfObjects indexOfObjectIdenticalTo:number];
//		}
//		endTime = [NSDate date];
//		NSLog(@"Array querying by pointer value took %g seconds",
//			[endTime timeIntervalSinceDate:startTime]);
//		[innerPool drain];
		
		//
		// Test 3: Set construction when setWithCapacity: is used
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in objects)
		{
			[setOfObjects addObject:number];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the preallocated set took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 4: Set construction when setWithCapacity: is NOT used
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in objects)
		{
			[unsizedSet addObject:number];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the unpreallocated set took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 4z: Set construction directly from an array of objects
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		setFromArray = [NSSet setWithArray:objects];
		endTime = [NSDate date];
		NSLog(@"Constructing the set from an array took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 4y: Set iterating
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in setOfObjects)
		{
		}
		endTime = [NSDate date];
		NSLog(@"Iterating the set took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 4a: Set querying
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSNumber *number in objects)
		{
			[setOfObjects containsObject:number];
		}
		endTime = [NSDate date];
		NSLog(@"Set querying took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 5: Dictionary construction
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
		{
			[testDictionary
				setObject:[objects objectAtIndex:iterationIndex]
				forKey:[keys objectAtIndex:iterationIndex]];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the dictionary took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 5: MapTable construction
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
		{
			[testTable
				setObject:[objects objectAtIndex:iterationIndex]
				forKey:[keys objectAtIndex:iterationIndex]];
		}
		endTime = [NSDate date];
		NSLog(@"Constructing the map table took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 6: Dictionary querying
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSString *key in testDictionary)
		{
			[testDictionary objectForKey:key];
		}
		endTime = [NSDate date];
		NSLog(@"Iterating and querying the dictionary took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];

		//
		// Test 7: MapTable querying
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSString *key in testTable)
		{
			[testTable objectForKey:key];
		}
		endTime = [NSDate date];
		NSLog(@"Iterating and querying the map table took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		//
		// Test 6: Dictionary querying
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSString *key in keys)
		{
			[testDictionary objectForKey:key];
		}
		endTime = [NSDate date];
		NSLog(@"Querying the dictionary by keys from different source took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];

		//
		// Test 7: MapTable querying
		//
		innerPool = [[NSAutoreleasePool alloc] init];
		startTime = [NSDate date];
		for (NSString *key in keys)
		{
			[testTable objectForKey:key];
		}
		endTime = [NSDate date];
		NSLog(@"Querying the map table by keys from different source took %g seconds",
			[endTime timeIntervalSinceDate:startTime]);
		[innerPool drain];
		
		[loopPool drain];
	}
	
	[pool drain];
    return 0;
}
