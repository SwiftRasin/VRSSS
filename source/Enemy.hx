package;

import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	public var lastAnim:String = '';

	public var type:String = '';

	public var displayHealth:Float = 100;

	public var attributes = {
		hp: 100,
		name: "Basic Demon"
	};

	public var healthBar:UI.HealthBar;

	public var offsets = {
		enemy1: {
			idle: [0, 0],
			glare: [0, 0]
		},
		enemy2: {
			idle: [0, 0]
		},
		enemy3: {
			idle: [1, 38]
		}
	};

	public function new(x:Float, y:Float, type:String)
	{
		super();
		this.type = type;
	}

	public function calculateDisplay() // for healthbar!
	{
		displayHealth = (attributes.hp / health) * 100;
		// display = (max health / current health) * 100
	}

	public function playAnim(anim:String)
	{
		animation.play(anim);
		switch (type)
		{
			case 'enemy3':
				if (anim == 'idle')
					offset.set(offsets.enemy3.idle[0], offsets.enemy3.idle[1]);
			case 'enemy2' | 'enemy4' | 'enemy5':
				if (anim == 'idle')
					offset.set(offsets.enemy2.idle[0], offsets.enemy2.idle[1]);
			case 'enemy1':
				if (anim == 'idle')
					offset.set(offsets.enemy1.idle[0], offsets.enemy1.idle[1]);
		}
		lastAnim = anim;
	}

	public function loadPos(x, y)
	{
		this.x = x;
		this.y = y;
	}

	public function loadHP()
	{
		health = attributes.hp;
	}

	public function loadAnims()
	{
		switch (type)
		{
			case 'enemy5':
				frames = Ez.sparrow('assets/images/Enemy1');
				animation.addByPrefix('idle', 'Enemy5', 24, true);
				playAnim('idle');
				attributes.hp = 8000;
				attributes.name = 'Shadow Demon';
				loadHP();
			case 'enemy4':
				frames = Ez.sparrow('assets/images/Enemy1');
				animation.addByPrefix('idle', 'Enemy4', 24, true);
				playAnim('idle');
				attributes.hp = 2000;
				attributes.name = 'Life Demon';
				loadHP();
			case 'enemy3':
				frames = Ez.sparrow('assets/images/Enemy1');
				animation.addByPrefix('idle', 'Enemy3', 24, true);
				playAnim('idle');
				attributes.hp = 500;
				attributes.name = 'Butterfly Demon';
				loadHP();
			case 'enemy2':
				frames = Ez.sparrow('assets/images/Enemy1');
				animation.addByPrefix('idle', 'Enemy2', 24, true);
				playAnim('idle');
				attributes.hp = 200;
				attributes.name = 'Strong Demon';
				loadHP();
			default:
				frames = Ez.sparrow('assets/images/Enemy1');
				animation.addByPrefix('idle', 'Enemy10', 24, true);
				animation.addByPrefix('attack', 'Enemy1 Attack', 24, true);
				playAnim('idle');
				attributes.hp = 100;
				attributes.name = 'Basic Demon';
				loadHP();
		}
		health = attributes.hp;
	}
}
