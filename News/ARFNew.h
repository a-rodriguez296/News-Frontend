//
//  ARFNew.h
//  News
//
//  Created by Alejandro Rodriguez on 4/27/15.
//  Copyright (c) 2015 Alejandro Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface ARFNew : PFObject

+(id) createNewWithTitle:(NSString *) title
                    text:(NSString *) text
                   photo:(UIImage *) image
                  author:(NSString *) author;

@end
