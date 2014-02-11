//
// Created by Alexis Kinsella on 10/02/2014.
// Copyright (c) 2014 Alexis Kinsella. All rights reserved.
//

#import "LXPeripheralsFlowLayout.h"


@implementation LXPeripheralsFlowLayout


- (void)awakeFromNib
{
    [super awakeFromNib];

    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.footerReferenceSize = CGSizeMake(0, 0);
    self.headerReferenceSize = CGSizeMake(0, 0);

    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.itemSize = CGSizeMake(220, 220);
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    for(int i = 0; i < answer.count ; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[(NSUInteger) i];
        CGRect frame = currentLayoutAttributes.frame;
//        frame.origin.y = -64;
        currentLayoutAttributes.frame = frame;
    }
    return answer;
}

@end