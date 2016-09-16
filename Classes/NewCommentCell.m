
#import "NewCommentCell.h"

@implementation NewCommentCell

@synthesize commentsTextView, commentsTypeSegmentedControl;

- (void)dealloc
{
	[commentsTextView release];
    [commentsTypeSegmentedControl release];
	[super dealloc];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([commentsTextView isFirstResponder] && [touch view] != commentsTextView)
    {
        [commentsTextView resignFirstResponder];
    }
    
}

@end
