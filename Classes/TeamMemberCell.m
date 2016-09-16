
#import "TeamMemberCell.h"

@implementation TeamMemberCell

@synthesize topLabel, bottomLabel, customImageView, customAccessoryView, leaveButton, leaveLabel;

- (void)dealloc
{
	[topLabel release];
	[bottomLabel release];
	[customImageView release];
    [leaveLabel release];
    [customAccessoryView release];
    [leaveButton release];
	[super dealloc];
}


@end
