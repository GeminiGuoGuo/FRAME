//
//  UILabel+ContentSize.m
//  test
//
//  Created by liyang on 14-7-15.
//  Copyright (c) 2014年 liyang. All rights reserved.
//

#import "UILabel+ContentSize.h"

@implementation UILabel (ContentSize)
- (CGSize)contentSize
{
    self.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize contentSize;
//    if([[[UIDevice currentDevice]  systemVersion] floatValue]<= 7.0)
//    {
        [self setNumberOfLines:0];
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
//        contentSize = [[self text] sizeWithFont:[self font] constrainedToSize:maximumLabelSize lineBreakMode:[self lineBreakMode]];
 
    
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    contentSize = [[self text] boundingRectWithSize:maximumLabelSize options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                        attributes:attribute context:nil].size;
    
//    }
//    else
//    {
//        NSMutableParagraphStyle * paragraphStyle = [[[NSMutableParagraphStyle alloc] init]autorelease];
//        paragraphStyle.lineBreakMode = self.lineBreakMode;
//        paragraphStyle.alignment = self.textAlignment;
//        NSDictionary * attributes = @{NSFontAttributeName : self.font,
//                                      NSParagraphStyleAttributeName : paragraphStyle};
//        contentSize = [self.text boundingRectWithSize:self.frame.size
//                                              options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                           attributes:attributes
//                                              context:nil].size;
//    }
    return contentSize;
}
@end
