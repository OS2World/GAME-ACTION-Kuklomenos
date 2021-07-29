/**
    Kuklomenos
	Mac_conffile.h copyright (C) 2008 Sijmen Mulder <sjmulder@gmail.com>

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

#include <Cocoa/Cocoa.h>
#include "conffile.h"

Config::Config() :
    rating(5.0),
    shouldUpdateRating(false)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber *ratingNumber = [defaults objectForKey:@"Rating"];

	if (ratingNumber)
		rating = [ratingNumber doubleValue];
		
	[pool release];
}

void Config::write()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setFloat:(float)rating forKey:@"Rating"];
	[defaults synchronize];
		
	[pool release];
}

Config config;
