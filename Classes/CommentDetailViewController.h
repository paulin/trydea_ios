//
//  CommentDetailViewController.h
//  tryDea
//
//  Created by Xenia Hertzenberg on 4/5/12.
//  Copyright (c) 2012 Feline Infinity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentDetailViewController : UIViewController
{
    NSString *commentText;
    NSString *commentType;
    NSString *commentAuthor;
    bool isEditing;
    
    UILabel *authorLabel;
    UILabel *typeLabel;
    UITextView *commentTextView;
}

@property (nonatomic, retain) NSString *commentText;
@property (nonatomic, retain) NSString *commentType;
@property (nonatomic, retain) NSString *commentAuthor;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UITextView *commentTextView;

@end
