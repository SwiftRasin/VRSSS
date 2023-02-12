package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class TitleState extends FlxState
{
	var icon:FlxSprite;
	var bg:FlxSprite;

	override public function create()
	{
		super.create();
		bg = new FlxSprite(0, 0).loadGraphic('assets/images/bg.png');
		add(bg);
		icon = new FlxSprite(1230, 670).loadGraphic('assets/images/HaxeJamIcon.png');
		add(icon);
		var splashLogo:FlxSprite = new FlxSprite().loadGraphic('assets/images/Title.png');
		add(splashLogo);
		splashLogo.screenCenter(X);
		splashLogo.x -= 300;
		splashLogo.y += 75;
		FlxTween.tween(splashLogo, {y: splashLogo.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		var enter:FlxSprite = new FlxSprite().loadGraphic('assets/images/enter.png');
		add(enter);
		enter.screenCenter(X);
		enter.y = 650;
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new PlayState());
		}
		if (FlxG.mouse.overlaps(icon))
		{
			icon.scale.x = 1.1;
			icon.scale.y = 1.1;
			if (FlxG.mouse.justPressed)
			{
				FlxG.openURL('https://itch.io/jam/haxejam-2023-winter-jam');
			}
		}
		else
		{
			icon.scale.x = 1;
			icon.scale.y = 1;
		}
	}
}
