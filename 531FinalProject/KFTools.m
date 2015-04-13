//
//  KFTools.m
//  531
//
//  Created by Kevin French on 4/12/14.
//  Copyright (c) 2014 Kevin French. All rights reserved.
//

#import "KFTools.h"

@implementation KFTools

+(int)convertToKilos:(int) x {
    return x * 0.453592;
}

+(int)convertToPounds:(int) x {
    return x / 0.453592;
}

/*
 Print the contents of th saved data to file
 */
+ (void) logFile
{
    NSFileManager * fm;
    NSString * docsDir;
    NSArray * dirPaths;
    
    fm = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    
    NSString * dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingString:@"/data.archive"]];
    
    NSMutableArray * savedData;
    
    if ([fm fileExistsAtPath: dataFilePath]) {
        savedData = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        NSLog(@"Actual File Contents\n%@", savedData);
    } else {
        NSLog(@"No file saved");
    }
}

@end
