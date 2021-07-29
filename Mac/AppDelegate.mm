/**
    Kuklomenos
	AppDelegate.m copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/*   Originally SDLMain.m - main entry point for our Cocoa-ized SDL app
       Initial Version: Darrell Walisser <dwaliss1@purdue.edu>
       Non-NIB-Code & other changes: Max Horn <max@quendi.de>

    Feel free to customize this file to suit your needs
*/

#import <Carbon/Carbon.h>
#import <SDL/SDL.h>
#import "AppDelegate.h"

void initialize_system();
void initialize_video();
void run_game();

@implementation AppDelegate

- (id)init
{
	self = [super init];
	if (!self)
		return nil;

	settings = [[SettingsWrapper alloc] init];

	return self;
}

- (void)dealloc
{
	[settings release];
	[settingsPanelController release];
	
	[super dealloc];
}

- (BOOL)shouldForceSettingsPanel
{
	return (GetCurrentEventKeyModifiers() & 0x1000) != 0;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	if ([self shouldForceSettingsPanel] || ![settings autoSkipConfig])
		[self showSettingsPanel:self];
	else
		[self runGame:self];
}

- (IBAction)showSettingsPanel:(id)sender
{
	if (!settingsPanelController)
		settingsPanelController = [[SettingsPanelController alloc] initWithSettings:settings];
		
	[settingsPanelController showWithRunTarget:self selector:@selector(runGame:)];
}

- (IBAction)runGame:(id)sender
{
	[settings saveAndUse:self];

	initialize_system();
	initialize_video();
	run_game();
	
	[NSApp terminate:self];
}

@end

#ifdef main
# undef main
#endif

int main(int argc, const char *argv[])
{
	return NSApplicationMain(argc, argv);
}
