/**
    Kuklomenos
	NSScreen+AvailableResolutions.m copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

@implementation NSScreen(AvailableResolutions)

- (NSArray *)availableResolutions
{
	CGDirectDisplayID displayID = (CGDirectDisplayID)[[[self deviceDescription] valueForKey:@"NSScreenNumber"] unsignedIntValue];
	
	NSArray *availableModes = (NSArray *)CGDisplayAvailableModes(displayID);
	int modeCount = [availableModes count];
	NSMutableArray *availableResolutions = [[NSMutableArray alloc] initWithCapacity:modeCount];
	
	NSSize lastResolution = NSMakeSize(0, 0);
	for (int i = 0; i < modeCount; i++)
	{
		NSDictionary *mode = [availableModes objectAtIndex:i];

		NSNumber *width  = [mode objectForKey:(NSString *)kCGDisplayWidth];
		NSNumber *height = [mode objectForKey:(NSString *)kCGDisplayHeight];
		
		NSSize resolution = NSMakeSize([width floatValue], [height floatValue]);
		if (resolution.width != lastResolution.width && resolution.height != lastResolution.height)
		{
			[availableResolutions insertObject:[NSValue valueWithSize:resolution] atIndex:0];
		}
		
		lastResolution = resolution;
	}
	
	return [availableResolutions autorelease];
}

@end
