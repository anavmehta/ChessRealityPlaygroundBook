//
//  CommandQueue.h
//  ChessEngine
//
//  Created by Anav Mehta on 5/19/19.
//  Copyright © 2019 Anav Mehta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandQueue: NSObject {
    NSMutableArray *contents;
}

- (instancetype)init;

- (BOOL)isEmpty;
- (int)size;
- (id)front;
- (id)back;
- (void)push:(id)object;
- (id)pop;

@end
