//
//  AppDelegate.m
//  CollectionsTest
//
//  Created by Jesse Armand on 8/1/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)performTests
{
    NSInteger iterationIndex;
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
    @autoreleasepool {
        for (iterationIndex = 0; iterationIndex < NUM_ELEMENTS; iterationIndex++)
        {
            NSString *keyString = [NSString stringWithFormat:@"%010ld", (long)(iterationIndex * 7)];
            [keys addObject:keyString];
            
            NSNumber *objectValue = [NSNumber numberWithInteger:iterationIndex];
            [objects addObject:objectValue];
            
        }
    }
    
	for (int i = 0; i < NUM_TEST_ITERATIONS; i++)
	{
        @autoreleasepool {
            
            NSLog(@"=== Beginning test loop. Iteration %d of %d ===", i + 1, NUM_TEST_ITERATIONS);
            
            NSMutableArray *arrayOfObjects = [NSMutableArray arrayWithCapacity:NUM_ELEMENTS];
            NSMutableArray *unsizedArray = [NSMutableArray array];
            NSMutableSet *setOfObjects = [NSMutableSet setWithCapacity:NUM_ELEMENTS];
            NSSet *setFromArray = nil;
            NSMutableSet *unsizedSet = [NSMutableSet set];
#if (!TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR)
            NSMapTable *testTable = [NSMapTable mapTableWithStrongToStrongObjects];
#endif
            NSMutableDictionary *testDictionary = [NSMutableDictionary dictionary];
            
            //
            // Test 1: Array construction when arrayWithCapacity: is used
            //
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [arrayOfObjects addObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Constructing the preallocated array took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 2: Array construction when arrayWithCapacity: is NOT used
            //
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [unsizedArray addObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Constructing the unpreallocated array took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 2a: Array iteration
            //
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in unsizedArray)
                {
                }
                endTime = [NSDate date];
                NSLog(@"Iterating the unpreallocated array took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in arrayOfObjects)
                {
                }
                endTime = [NSDate date];
                NSLog(@"Iterating the preallocated array took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 2b: Array querying by isEqualTo:
            // Takes a very long time.
            
//            @autoreleasepool {
//                startTime = [NSDate date];
//                for (NSNumber *number in objects)
//                {
//                    [arrayOfObjects indexOfObject:number];
//                }
//                endTime = [NSDate date];
//                NSLog(@"Array querying by isEqualTo: took %g seconds",
//                      [endTime timeIntervalSinceDate:startTime]);
//            }
            
            // Test 2c: Array querying by pointer value
            
//            @autoreleasepool {
//                startTime = [NSDate date];
//                for (NSNumber *number in objects)
//                {
//                    [arrayOfObjects indexOfObjectIdenticalTo:number];
//                }
//                endTime = [NSDate date];
//                NSLog(@"Array querying by pointer value took %g seconds",
//                      [endTime timeIntervalSinceDate:startTime]);
//            }
            
            //
            // Test 3: Set construction when setWithCapacity: is used
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [setOfObjects addObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Constructing the preallocated set took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 4: Set construction when setWithCapacity: is NOT used
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [unsizedSet addObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Constructing the unpreallocated set took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 4z: Set construction directly from an array of objects
            //
            @autoreleasepool {
                startTime = [NSDate date];
                setFromArray = [NSSet setWithArray:objects];
                endTime = [NSDate date];
                NSLog(@"Constructing the set from an array took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 4y: Set iterating
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in setOfObjects)
                {
                }
                endTime = [NSDate date];
                NSLog(@"Iterating the preallocated set took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in unsizedSet)
                {
                }
                endTime = [NSDate date];
                NSLog(@"Iterating the unpreallocated set took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in setFromArray)
                {
                }
                endTime = [NSDate date];
                NSLog(@"Iterating non-mutable set took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 4a: Set querying
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [setOfObjects containsObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Preallocated set querying took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [unsizedSet containsObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"Unpreallocated set querying took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSNumber *number in objects)
                {
                    [setFromArray containsObject:number];
                }
                endTime = [NSDate date];
                NSLog(@"non-mutable set querying took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 5: Dictionary construction
            //
            @autoreleasepool {
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
            }
            
            //
            // Test 5: MapTable construction
            //
            
#if (!TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR)
            @autoreleasepool {
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
            }
#endif
            
            //
            // Test 6: Dictionary querying
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSString *key in testDictionary)
                {
                    [testDictionary objectForKey:key];
                }
                endTime = [NSDate date];
                NSLog(@"Iterating and querying the dictionary took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 7: MapTable querying
            //
            
#if (!TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR)
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSString *key in testTable)
                {
                    [testTable objectForKey:key];
                }
                endTime = [NSDate date];
                NSLog(@"Iterating and querying the map table took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
#endif
            
            //
            // Test 6: Dictionary querying
            //
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSString *key in keys)
                {
                    [testDictionary objectForKey:key];
                }
                endTime = [NSDate date];
                NSLog(@"Querying the dictionary by keys from different source took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
            
            //
            // Test 7: MapTable querying
            //
            
#if (!TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR)
            @autoreleasepool {
                startTime = [NSDate date];
                for (NSString *key in keys)
                {
                    [testTable objectForKey:key];
                }
                endTime = [NSDate date];
                NSLog(@"Querying the map table by keys from different source took %g seconds",
                      [endTime timeIntervalSinceDate:startTime]);
            }
#endif
            
        }
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performTests];
    });
    
    UIViewController *viewController = [[UIViewController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = viewController;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
