package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Win extends FlxState
{
	var winM:FlxSprite;

	override public function create()
	{
		super.create();
		FlxG.sound.pause();
		var bg = new FlxSprite(0, 0).loadGraphic('assets/images/bg.png');
		add(bg);
		winM = new FlxSprite(0, 0).loadGraphic('assets/images/winmessage.png');
		winM.screenCenter();
		add(winM);
		FlxTween.tween(winM, {y: winM.y - 50}, 0.6, {
			type: PINGPONG,
			ease: FlxEase.quadInOut,
			onComplete: function(twn:FlxTween) {}
		});
		FlxG.sound.play('assets/music/Win.ogg', 1, false, null, true, function()
		{
			FlxTween.tween(bg, {alpha: 0}, 1, {
				type: ONESHOT,
				ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					FlxG.switchState(new TitleState());
				}
			});
		});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
