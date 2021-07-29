/**
    Kuklomenos
	SettingsPanelController.h copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

#import <Cocoa/Cocoa.h>
#import "SettingsWrapper.h"

@interface SettingsPanelController : NSObject
{
	IBOutlet NSPanel *settingsPanel;
	IBOutlet NSArrayController *resolutionArrayController;

	NSMutableArray *availableResolutions;
	int selectedResolutionIndex;

	SettingsWrapper *settings;
	id target;
	SEL selector;
}

- (id)init;
- (id)initWithSettings:(SettingsWrapper *)newSettings;

- (void)showWithRunTarget:(id)newTarget selector:(SEL)newSelector;

- (IBAction)play:(id)sender;

- (SettingsWrapper *)settings;
- (NSArray *)availableResolutions;
- (int)selectedResolutionIndex;

- (void)setSettings:(SettingsWrapper *)value;
- (void)setSelectedResolutionIndex:(int)value;

@end
