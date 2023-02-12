package;

import flixel.FlxSprite;

class Player extends FlxSprite
{
	var lastAnim:String = '';

	var offsets = {
		idle: [0, 0],
		walk: [0, -5],
		hit: [19, 5]
	};

	public var strength:Float = 0;

	public var stats = {
		sword: 'normal',
		strengthGain: 5.00,
		timesHit: 0.00,
		fireDamage: 0.00,
		fireGain: 5.00
	};

	public function new(x:Float, y:Float)
	{
		super();
	}

	public function playAnim(anim:String)
	{
		animation.play(anim);
		switch (anim)
		{
			case 'walk':
				offset.set(offsets.walk[0], offsets.walk[1]);
			case 'idle':
				offset.set(offsets.idle[0], offsets.idle[1]);
			case 'hit' | 'hit-fire':
				offset.set(offsets.hit[0], offsets.hit[1]);
		}
		lastAnim = anim;
	}

	public function loadPos(x, y)
	{
		this.x = x;
		this.y = y;
	}

	public function loadAnims()
	{
		frames = Ez.sparrow('assets/images/Player');
		animation.addByPrefix('idle', 'Viking0', 24, true);
		animation.addByPrefix('hit', 'Viking Sword0', 24, false);
		animation.addByPrefix('hit-fire', 'Viking Sword FIRE', 24, false);
		animation.addByPrefix('walk', 'Viking Walk', 24, false);
		playAnim('idle');
	}
}
