/**
    Kuklomenos
	SettingsWrapper.h copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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
#include "settings.h"

@interface SettingsWrapper : NSObject
{
	BOOL autoSkipConfig;
	Settings *localSettings;
}

- (IBAction)saveAndUse:(id)sender;

- (BOOL)autoSkipConfig;
- (NSSize)screenSize;
- (BOOL)fullscreen;
- (BOOL)useAntiAliasing;
- (BOOL)gridVisible;
- (BOOL)zoomEnabled;
- (BOOL)rotatingView;

- (void)setAutoSkipConfig:(BOOL)value;
- (void)setScreenSize:(NSSize)value;
- (void)setFullscreen:(BOOL)value;
- (void)setUseAntiAliasing:(BOOL)value;
- (void)setGridVisible:(BOOL)value;
- (void)setZoomEnabled:(BOOL)value;
- (void)setRotatingView:(BOOL)value;

@end
