//
//  SettingsWindowController.m
//  Notifier
//
//  Created by Nick Merrill on 6/28/13.
//
//

#import "SettingsWindowController.h"

@interface SettingsWindowController ()

@end

@implementation SettingsWindowController

@synthesize audioAlertCheckbox = _audioAlertCheckbox;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}


- (void)audioAlertCheckboxChanged:(id)sender {
    NSButton *checkbox = (NSButton *)sender;
    BOOL checkboxIsChecked = [checkbox state] == NSOnState;
    [[NSUserDefaults standardUserDefaults] setBool:checkboxIsChecked forKey:@"AudioAlertsAreEnabled"];
}

@end
