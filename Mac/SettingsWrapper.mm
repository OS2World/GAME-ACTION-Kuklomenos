/**
    Kuklomenos
	SettingsWrapper.mm copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

#import "SettingsWrapper.h"

@implementation SettingsWrapper

+ (void)initialize
{
	NSSize currentRes = [[NSScreen mainScreen] frame].size;

	NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithBool:FALSE],                 @"AutoSkipConfig",
			[NSNumber numberWithInt:currentRes.width],       @"ScreenWidth",
			[NSNumber numberWithInt:currentRes.height],      @"ScreenHeight",
			[NSNumber numberWithBool:TRUE],                  @"Fullscreen",
			[NSNumber numberWithBool:TRUE],                  @"AntiAliasing",
			[NSNumber numberWithBool:settings.showGrid],     @"IsGridVisible",
			[NSNumber numberWithBool:settings.zoomEnabled],  @"ZoomEnabled",
			[NSNumber numberWithBool:settings.rotatingView], @"RotatingView",
			nil];
			
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults registerDefaults:defaultValues];
}

- (id)init
{
	self = [super init];
	if (!self)
		return nil;
		
	localSettings = new Settings(settings);
	localSettings->fps = 60;
	localSettings->videoFlags = 0;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	autoSkipConfig = [defaults boolForKey:@"AutoSkipConfig"];
	localSettings->width        = [defaults integerForKey:@"ScreenWidth"];
	localSettings->height       = [defaults integerForKey:@"ScreenHeight"];
	localSettings->fullscreen   = [defaults boolForKey:@"Fullscreen"];
	localSettings->useAA        = [defaults boolForKey:@"AntiAliasing"];
	localSettings->showGrid     = [defaults boolForKey:@"IsGridVisible"];
	localSettings->zoomEnabled  = [defaults boolForKey:@"ZoomEnabled"];
	localSettings->rotatingView = [defaults boolForKey:@"RotatingView"];
	
	return self;
}

- (void)dealloc
{
	delete localSettings;
	
	[super dealloc];
}

- (IBAction)saveAndUse:(id)sender
{
	settings = *localSettings;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:autoSkipConfig              forKey:@"AutoSkipConfig"];
	[defaults setInteger:localSettings->width     forKey:@"ScreenWidth"];
	[defaults setInteger:localSettings->height    forKey:@"ScreenHeight"];
	[defaults setBool:localSettings->fullscreen   forKey:@"Fullscreen"];
	[defaults setBool:localSettings->useAA        forKey:@"AntiAliasing"];
	[defaults setBool:localSettings->showGrid     forKey:@"IsGridVisible"];
	[defaults setBool:localSettings->zoomEnabled  forKey:@"ZoomEnabled"];
	[defaults setBool:localSettings->rotatingView forKey:@"RotatingView"];
	
	[defaults synchronize];
}

- (BOOL)autoSkipConfig  { return autoSkipConfig; }
- (NSSize)screenSize    { return NSMakeSize(localSettings->width, localSettings->height); }
- (BOOL)fullscreen      { return localSettings->fullscreen; }
- (BOOL)useAntiAliasing { return localSettings->useAA; }
- (BOOL)gridVisible     { return localSettings->showGrid; }
- (BOOL)zoomEnabled     { return localSettings->zoomEnabled; }
- (BOOL)rotatingView    { return localSettings->rotatingView; }

- (void)setScreenSize:(NSSize)value
{
	localSettings->width  = (int)value.width;
	localSettings->height = (int)value.height;
}

- (void)setAutoSkipConfig:(BOOL)value  { autoSkipConfig = value; }
- (void)setFullscreen:(BOOL)value      { localSettings->fullscreen   = value; }
- (void)setUseAntiAliasing:(BOOL)value { localSettings->useAA        = value; }
- (void)setGridVisible:(BOOL)value     { localSettings->showGrid     = value; }
- (void)setZoomEnabled:(BOOL)value     { localSettings->zoomEnabled  = value; }
- (void)setRotatingView:(BOOL)value    { localSettings->rotatingView = value; }

@end
