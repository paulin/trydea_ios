
#import "TryDeaListCell.h"

@implementation TryDeaListCell

@synthesize publishedCustomAccessoryView, customAccessoryView, customBackgroundView, customSelectedBackgroundView;

- (void)dealloc
{
	[customAccessoryView release];
    [publishedCustomAccessoryView release];
	[customBackgroundView release];
	[customSelectedBackgroundView release];
	[super dealloc];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
}

@end
