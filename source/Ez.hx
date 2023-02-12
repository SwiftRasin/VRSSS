package;

import flixel.graphics.frames.FlxAtlasFrames;

class Ez
{
	public static function sparrow(path):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSparrow(path + ".png", path + ".xml");
	}
}
