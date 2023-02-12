package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	public static var player:Player;

	var inBounds:Bool = true;

	var bg:FlxSprite;

	var isWalking:Bool = false;

	public static var enemy1:Enemy;

	var enemyHealth = {
		enemy: new UI.HealthBar(0, 0, 0, 'no')
	};

	public var lastFrame = 0;

	var canHit:Bool = true;

	var score:FlxText;

	var level:Float = 1;

	var strengthBar:UI.Bar;
	var tab:FlxSprite;
	var tab2:FlxSprite;

	var lvlText:FlxText;
	var strengthText:FlxText;

	override public function create()
	{
		bg = new FlxSprite(0, 0).loadGraphic('assets/images/bg.png');
		add(bg);
		player = new Player(0, 0);
		player.loadAnims();
		add(player);
		player.playAnim('idle');
		FlxG.watch.addQuick('Player Stuff', player);
		enemy1 = new Enemy(0, 0, "enemy" + Std.string(level));
		enemy1.loadAnims();
		enemy1.loadPos(500, 430);
		add(enemy1);
		enemy1.playAnim('idle');
		trace('enemyHealth: ' + enemy1.health);
		enemyHealth.enemy = new UI.HealthBar((enemy1.x - 20 - enemy1.width / 2), enemy1.y - 150, enemy1.health, enemy1.attributes.name);
		add(enemyHealth.enemy);
		player.loadPos(30, 360);
		FlxG.sound.playMusic('assets/music/Discovery.ogg');
		FlxG.watch.add(enemy1.attributes.hp, 'enemy maxHealth ');
		FlxG.watch.add(enemy1.health, 'enemy health ');
		FlxG.watch.add(enemy1.displayHealth, 'enemy displayHealth ');
		tab = new FlxSprite(804, -25).loadGraphic('assets/images/tab.png');
		add(tab);
		//		strengthBar = new UI.Bar(854, 81, player, 'strength', 1000, [0xff460de4, 0xff0cd4f3], 'Strength');
		//		add(strengthBar);
		strengthText = new FlxText(888, 4, 1000, "Strength: " + level, 30);
		strengthText.color = 0xFF000000;
		add(strengthText);
		tab2 = new FlxSprite(-5, -25).loadGraphic('assets/images/tab.png');
		tab2.flipX = true;
		add(tab2);
		lvlText = new FlxText(28, 4, 1000, "Level: " + level, 30);
		lvlText.color = 0xFF000000;
		add(lvlText);
		super.create();
	}

	private function move(amount:Int)
	{
		player.x += amount;
	}

	override public function update(elapsed:Float)
	{
		enemy1.calculateDisplay();
		lvlText.text = 'Level: ' + level;
		if (level > 2)
			strengthText.text = 'Strength: ' + player.strength + '\nFire Damage: ' + player.stats.fireDamage;
		else
			strengthText.text = 'Strength: ' + player.strength;
		if ((player.animation.curAnim.name != 'idle' && player.animation.curAnim.finished) || isWalking == false)
		{
			if (player.animation.curAnim.name == 'hit' && player.animation.curAnim.finished)
				player.playAnim('idle');
			if (isWalking == false && player.animation.curAnim.name != 'hit')
				player.playAnim('idle');
		}
		if (FlxG.keys.anyPressed([LEFT, A]))
		{
			if (inBounds)
			{
				isWalking = true;
				player.flipX = true;
				player.playAnim('walk');
				move(-7);
			}
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]))
		{
			if (inBounds)
			{
				isWalking = true;
				player.flipX = false;
				player.playAnim('walk');
				move(7);
			}
		}
		else if (FlxG.keys.anyJustPressed([SPACE, ENTER, Z]))
		{
			isWalking = false;
			if (inBounds && canHit == true)
			{
				player.playAnim('hit');
			}
		}
		else
		{
			isWalking = false;
		}

		#if debug
		if (FlxG.keys.justPressed.K)
		{
			player.strength += 1000;
		}
		#end

		if ((player.animation.curAnim.name == 'hit' || player.animation.curAnim.name == 'hit-fire')
			&& player.animation.curAnim.curFrame == 13)
		{
			if (lastFrame != 13)
			{
				if (player.overlaps(enemy1) && canHit == true)
				{
					canHit = false;
					//					enemy1.health -= player.strength;
					trace('hit enemy');
					if (score != null)
					{
						remove(score);
					}
					score = new FlxText(0, 0, 0, "" + (player.strength + player.stats.fireDamage), 60);
					score.color = flixel.util.FlxColor.fromRGB(0, 158, 219, 255);
					score.screenCenter();
					add(score);
					player.stats.timesHit++;
					flixel.tweens.FlxTween.tween(score, {alpha: 0}, 0.6, {
						type: ONESHOT,
						ease: flixel.tweens.FlxEase.quadInOut
					});
					flixel.tweens.FlxTween.tween(score, {y: score.y - 200}, 0.6, {
						type: ONESHOT,
						ease: flixel.tweens.FlxEase.quadOut
					});
					flixel.tweens.FlxTween.tween(enemy1, {health: enemy1.health - (player.strength + player.stats.fireDamage)}, 0.6, {
						type: ONESHOT,
						ease: flixel.tweens.FlxEase.quadOut,
						onComplete: function(twn:flixel.tweens.FlxTween)
						{
							player.strength += player.stats.strengthGain;

							var strength = new FlxText(0, 0, 0, "+ " + player.stats.strengthGain + " Strength!", 60);
							if (level > 2)
							{
								player.stats.fireDamage += player.stats.fireGain;
								strength.text += '\n+ ' + player.stats.fireGain + ' Fire Damage!';
							}
							strength.color = flixel.util.FlxColor.fromRGB(0, 158, 219, 255);
							strength.screenCenter();
							add(strength);
							flixel.tweens.FlxTween.tween(strength, {alpha: 0}, 0.6, {
								type: ONESHOT,
								ease: flixel.tweens.FlxEase.quadInOut
							});
							flixel.tweens.FlxTween.tween(strength, {y: strength.y - 200}, 0.6, {
								type: ONESHOT,
								ease: flixel.tweens.FlxEase.quadOut
							});
							if (enemy1.health <= 0)
							{
								enemy1.visible = false;
								new flixel.util.FlxTimer().start(1, function(tmr:flixel.util.FlxTimer)
								{
									canHit = true;
									//									FlxG.sound.play('assets/sounds/win.ogg');
									level++;
									if (level > 5)
									{
										FlxG.switchState(new Win());
									}
									player.stats.strengthGain = 5 * level;
									player.stats.fireGain = 10 * level;
									enemy1.health = enemy1.attributes.hp;
									if (level == 3)
									{
										player.stats.sword = 'fire';
										var strength = new FlxText(0, 0, 0, "Unlocked FIRE Sword!", 60);
										strength.color = flixel.util.FlxColor.fromRGB(0, 158, 219, 255);
										strength.screenCenter();
										add(strength);
										flixel.tweens.FlxTween.tween(strength, {alpha: 0}, 0.6, {
											type: ONESHOT,
											ease: flixel.tweens.FlxEase.quadInOut
										});
										flixel.tweens.FlxTween.tween(strength, {y: strength.y - 200}, 0.6, {
											type: ONESHOT,
											ease: flixel.tweens.FlxEase.quadOut
										});
									}
									else if (level < 3)
									{
										player.stats.sword = 'normal';
									}
									var image:FlxSprite = new FlxSprite(0, 0).loadGraphic('assets/images/win.png');
									image.screenCenter();
									add(image);
									remove(enemy1);
									enemy1 = new Enemy(0, 0, "enemy" + Std.string(level));
									enemy1.loadAnims();
									enemy1.loadPos(500, 430);
									add(enemy1);
									enemy1.playAnim('idle');
									remove(enemyHealth.enemy);
									trace('enemyHealth: ' + enemy1.health);
									enemyHealth.enemy = new UI.HealthBar((enemy1.x - 20 - enemy1.width / 2), enemy1.y - 150, enemy1.attributes.hp,
										enemy1.attributes.name);
									add(enemyHealth.enemy);

									flixel.tweens.FlxTween.tween(image, {alpha: 0, y: image.y - 200}, 0.6, {
										type: ONESHOT,
										ease: flixel.tweens.FlxEase.quadInOut,
										onComplete: function(twn:flixel.tweens.FlxTween)
										{
											remove(image);
										}
									});
								});
							}
							else
							{
								new flixel.util.FlxTimer().start(1, function(tmr:flixel.util.FlxTimer)
								{
									canHit = true;
									//									FlxG.sound.play('assets/sounds/lose.ogg');
									enemy1.health = enemy1.attributes.hp;
									var image:FlxSprite = new FlxSprite(0, 0).loadGraphic('assets/images/lose.png');
									image.screenCenter();
									add(image);

									flixel.tweens.FlxTween.tween(image, {alpha: 0, y: image.y - 200}, 0.6, {
										type: ONESHOT,
										ease: flixel.tweens.FlxEase.quadInOut,
										onComplete: function(twn:flixel.tweens.FlxTween)
										{
											remove(image);
										}
									});
								});
							}
						}
					});
				}
			}
		}

		super.update(elapsed);
	}
}
