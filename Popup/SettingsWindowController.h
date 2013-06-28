//
//  SettingsWindowController.h
//  Notifier
//
//  Created by Nick Merrill on 6/28/13.
//
//

#import <Cocoa/Cocoa.h>

@interface SettingsWindowController : NSWindowController

@property (nonatomic, unsafe_unretained) IBOutlet NSButton *audioAlertCheckbox;

- (IBAction)audioAlertCheckboxChanged:(id)sender;

@end
