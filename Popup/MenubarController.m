#import "MenubarController.h"
#import "StatusItemView.h"
#import "QueryResponse.h"

@implementation MenubarController

@synthesize statusItemView = _statusItemView;
@synthesize connectionsAreBlocked = _connectionsAreBlocked;

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
    
    self.connectionsAreBlocked = false;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
    
    return self;
}


- (void)updateCount {
    if (self.connectionsAreBlocked) {
        NSLog(@"Updates blocked.");
        return;
    }
    
    // beginning update
    
    NSString *urlString = @"http://www.nickmerrill.me/mail/urgent/";
    
    QueryResponse *response = [QueryResponse queryUrlWithString:urlString];
    
    if ([response.error code]) {
        NSLog(@"%@", [response.error localizedDescription]);
        [self blockUpdates:10.];
        self.statusItemView.title = nil;
        [self.statusItemView displayCount:-1];
        return;
    }
    
    int dataInt = [response.dataString intValue];
    self.statusItemView.title = response.dataString;
    [self.statusItemView displayCount:dataInt];
}

// returns true if request to block updates was successful
- (bool)blockUpdates:(double)time {
    if (self.connectionsAreBlocked) {
        return false;
    } else {
        NSLog(@"Blocking updates.");
        self.connectionsAreBlocked = true;
        [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(unblockUpdates) userInfo:nil repeats:NO];
        return true;
    }
}

- (void)unblockUpdates {
    if (!(self.connectionsAreBlocked)) return;
    
    self.connectionsAreBlocked = false;
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
