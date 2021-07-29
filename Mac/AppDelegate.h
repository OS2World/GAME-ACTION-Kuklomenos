/**
    Kuklomenos
	AppDelegate.h copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

/*   Originally SDLMain.h - main entry point for our Cocoa-ized SDL app
       Initial Version: Darrell Walisser <dwaliss1@purdue.edu>
       Non-NIB-Code & other changes: Max Horn <max@quendi.de>

    Feel free to customize this file to suit your needs
*/

#import <Cocoa/Cocoa.h>
#import "SettingsWrapper.h"
#import "SettingsPanelController.h"

@interface AppDelegate : NSObject
{
	SettingsWrapper *settings;
	SettingsPanelController *settingsPanelController;
}

- (BOOL)shouldForceSettingsPanel;

- (IBAction)showSettingsPanel:(id)sender;
- (IBAction)runGame:(id)sender;


@end
