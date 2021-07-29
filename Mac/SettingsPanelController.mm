/**
    Kuklomenos
	SettingsPanelController.m copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

#import "NSScreen+AvailableResolutions.h"
#import "SettingsPanelController.h"

@implementation SettingsPanelController

- (id)init
{
	SettingsWrapper *initialSettings = [[SettingsWrapper alloc] init];
	return [self initWithSettings:[initialSettings autorelease]];
}

- (id)initWithSettings:(SettingsWrapper *)newSettings
{
	self = [super init];
	if (!self)
		return nil;
		
	[self setSettings:newSettings];
	
	NSValue *selectedSizeValue = [NSValue valueWithSize:[settings screenSize]];
	
	availableResolutions = [NSMutableArray arrayWithArray:[[NSScreen mainScreen] availableResolutions]];
	selectedResolutionIndex = [availableResolutions indexOfObject:selectedSizeValue];
	
	if (selectedResolutionIndex == NSNotFound)
	{
		[availableResolutions addObject:selectedSizeValue];
		selectedResolutionIndex = [availableResolutions count] - 1;
	}
	
	[NSBundle loadNibNamed:@"SettingsPanel" owner:self];
	
	return self;
}

- (void)dealloc
{
	[availableResolutions release];
	[settings release];
	[settingsPanel release];
	
	[super dealloc];
}

- (void)showWithRunTarget:(id)newTarget selector:(SEL)newSelector
{
	target = newTarget;
	selector = newSelector;
	
	[settingsPanel center];
	[settingsPanel makeKeyAndOrderFront:self];
}

- (IBAction)play:(id)sender
{
	NSSize resolution = [[availableResolutions objectAtIndex:selectedResolutionIndex] sizeValue];
	[settings setScreenSize:resolution];
	
	[settingsPanel close];
	
	if (target && selector)
		[target performSelector:selector withObject:self];
}

- (NSArray *)availableResolutions
{
	return [[availableResolutions retain] autorelease];
}

- (int)selectedResolutionIndex
{
	return selectedResolutionIndex;
}

- (SettingsWrapper *)settings
{
	return [[settings retain] autorelease];
}

- (void)setSettings:(SettingsWrapper *)value
{
	if (settings == value)	
		return;
	
	[self willChangeValueForKey:@"settings"];
	
	[settings release];
	settings = [value retain];

	[self didChangeValueForKey:@"settings"];
}

- (void)setSelectedResolutionIndex:(int)value
{
	[self willChangeValueForKey:@"selectedResolutionIndex"];

	selectedResolutionIndex = value;

	[self didChangeValueForKey:@"selectedResolutionIndex"];
}

@end
