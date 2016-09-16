
#import "CommentCell.h"

@implementation CommentCell

@synthesize topLabel, bottomLabel, customImageView;

- (void)dealloc
{
	[topLabel release];
	[bottomLabel release];
	[customImageView release];
	[super dealloc];
}


@end
