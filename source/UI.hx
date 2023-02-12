package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class UI {}

class Bar extends FlxTypedGroup<Dynamic>
{
	public var bar:FlxBar;
	public var sprite:FlxSprite;
	public var name:FlxText;
	public var tag:String;

	public var stuff:FlxText;

	var hp:Float = 100;

	var pos = {
		x: 0.0,
		y: 0.0
	};

	public function new(x:Float, y:Float, track:Dynamic, tracking:String, max:Float, colors:Array<FlxColor>, tag:String)
	{
		super();
		this.tag = tag;
		sprite = new FlxSprite(x, y).loadGraphic('assets/images/bar.png');
		add(sprite);
		pos.x = sprite.x;
		pos.y = sprite.y;
		if (tag != 'no')
			createBar(track, tracking, max, colors);
		createName();
		stuff = new FlxText(pos.x + 190, pos.y + 12.25, 1000, 'value', 16);
		stuff.color = 0xFFffffff;
		add(stuff);
		stuff.visible = false;
	}

	private function updateStuff()
	{
		stuff.text = '' + bar.value;
	}

	private function createBar(track:Dynamic, tracking:String, max:Float, colors:Array<FlxColor>)
	{
		bar = new FlxBar(pos.x + 103, pos.y + 9, LEFT_TO_RIGHT, 227, 29, track, tracking, 0, max, false);
		bar.createFilledBar(colors[0], colors[1]);
		add(bar);
	}

	private function createName()
	{
		name = new FlxText(pos.x, pos.y -= 90, 1000, tag, 60);
		name.color = FlxColor.BLACK;
		add(name);
	}
}

class HealthBar extends FlxTypedGroup<Dynamic>
{
	public var bar:FlxBar;
	public var sprite:FlxSprite;
	public var name:FlxText;
	public var tag:String;

	var hp:Float = 100;

	var pos = {
		x: 0.0,
		y: 0.0
	};

	public function new(x:Float, y:Float, hbhp:Float, tag:String)
	{
		super();
		this.tag = tag;
		hp = hbhp;
		sprite = new FlxSprite(x, y).loadGraphic('assets/images/HP.png');
		add(sprite);
		pos.x = sprite.x;
		pos.y = sprite.y;
		if (tag != 'no')
			createBar(hbhp);
		createName();
	}

	private function createBar(barHealth:Float)
	{
		trace('health: ' + barHealth);
		bar = new FlxBar(pos.x + 104, pos.y + 9, LEFT_TO_RIGHT, 226, 29, PlayState.enemy1, "health", 0, PlayState.enemy1.attributes.hp, false);
		bar.parent = PlayState.enemy1;
		bar.createFilledBar(0xFFFF0000, 0xFF99FF99);
		add(bar);
	}

	private function createName()
	{
		name = new FlxText(pos.x, pos.y -= 90, 1000, tag, 60);
		name.color = FlxColor.BLACK;
		add(name);
	}
}
