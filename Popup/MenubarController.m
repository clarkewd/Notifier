#import "MenubarController.h"
#import "StatusItemView.h"

@implementation MenubarController

@synthesize statusItemView = _statusItemView;
@synthesize urgentCount = _urgentCount;


#pragma mark -

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        // Install status item into the menu bar
        NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_VIEW_WIDTH];
        _statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
        _statusItemView.image = [NSImage imageNamed:@"Status"];
        _statusItemView.alternateImage = [NSImage imageNamed:@"StatusHighlighted"];
        _statusItemView.action = @selector(togglePanel:);
    }
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
    return self;
}

- (void)updateCount
{
    // beginning update
    
    NSString *urlString = [[NSString alloc] initWithCString:"http://www.nickmerrill.me/mail/urgent/" encoding:NSUTF8StringEncoding];
    
    NSString *data = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    
    int dataInt = [data intValue];
    [self.statusItemView updateCount:dataInt];
}

- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

#pragma mark -
#pragma mark Public accessors

- (NSStatusItem *)statusItem
{
    return self.statusItemView.statusItem;
}

#pragma mark -

- (BOOL)hasActiveIcon
{
    return self.statusItemView.isHighlighted;
}

- (void)setHasActiveIcon:(BOOL)flag
{
    self.statusItemView.isHighlighted = flag;
}

@end
