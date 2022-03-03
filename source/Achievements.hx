import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Hidden achievement
		["Drinkin' on a Friday Night",	"Drink the beer on the main menu... on a Friday.",		 true],		//0
		["Dungeon Raided",				"Beat Week 1 on any difficulty. Thanks andrew",			false],		//1
		["The Bigger They Are...",		"Beat Week 1 on Hard with no Misses.",					false],		//2
		["Tim's Got the Shotgun", 		"Beat Week 2 on any difficulty.",						false],		//3
		["Thumbs Down",					"Beat Week 2 on Hard with no Misses.",					false],		//4
		["We Made Heaven",				"Beat Week 3 on any difficulty.",						false],		//5	
		["Too Much of Heaven",			"Beat Week 3 on Hard with no Misses.",					false],		//6
		["[week 4 comp]",				"Beat Week 4 on any difficulty.",						false],		//7	
		["Quad City King",				"Beat Week 4 on Hard with no Misses.",					false],		//8
		["[week 5 comp]",				"Beat Week 5 on any difficulty.",						false],		//9	
		["Dizasta",						"Beat Week 5 on Hard with no Misses.",					false],		//10
		["[week 6 comp]",				"Beat Week 6 on any difficulty.",						false],		//11	
		["Bless the Rain",				"Beat Week 6 on Hard with no Misses.",					false],		//12
		["[week 7 clear]",				"Beat Week 7 on any difficulty.",						false],		//13	
		["[week 7 nomiss]",				"Beat Week 7 on Hard with no Misses.",					false],		//14
		["[week 8 clear]",				"Beat Week 8 on any difficulty.",						false],		//15	
		["Rattled",						"Beat Week 8 on Hard with no Misses.",					false],		//16
		["[week 9 clear]",				"Beat Week 9 on any difficulty.",						false],		//17	
		["[week 9 nomiss]",				"Beat Week 9 on Hard with no Misses.",					false],		//18
		["Fresh out of the bag",		"Beat Week 10 on any difficulty.",						false],		//19	
		["[week 10 nomiss]",			"Beat Week 10 on Hard with no Misses.",					false],		//20
		["[week 11 clear]",				"Beat Week 11 on any difficulty.",						false],		//21	
		["Case Closed",					"Beat Week 11 on Hard with no Misses.",					false],		//22
		["[week 12 clear]",				"Beat Week 12 on any difficulty.",						false],		//23	
		["Pubstar",						"Beat Week 12 on Hard with no Misses.",					false],		//24
		["What a Funkin' Disaster!",	"Complete a Song with a rating lower than 20%.",		false],		//25
		["Perfectionist",				"Complete a Song with a rating of 100%.",				false],		//26
		["Roadkill Enthusiast",			"Watch the Henchmen die over 100 times.",				false],		//27
		["Oversinging Much...?",		"Hold down a note for 20 seconds.",						false],		//28
		["Hyperactive",					"Finish a Song without going Idle.",					false],		//29
		["Just the Two of Us",			"Finish a Song pressing only two keys.",				false],		//30
		["Toaster Gamer",				"Have you tried to run the game on a toaster?",			false],		//31
		["Debugger",					"Beat the \"Test\" Stage from the Chart Editor.",		 true],		//32
		["A bit sussy!",				"See a suspicious looking board in the tutorial stage.", true],		//33
		["Achieve Enlightenment",		"...",													 true]		//34
	];

	public static var achievementsUnlocked:Array<Dynamic> = [ //Save string and Achievement tag + is it unlocked?
		['friday_night_play', false],	//0
		['week1_complete', false],		//1
		['week1_nomiss', false],		//2
		['week2_complete', false],		//3
		['week2_nomiss', false],		//4
		['week3_complete', false],		//5
		['week3_nomiss', false],		//6
		['week4_complete', false],		//7
		['week4_nomiss', false],		//8
		['week5_complete', false],		//9
		['week5_nomiss', false],		//10
		['week6_complete', false],		//11
		['week6_nomiss', false],		//12
		['week7_complete', false],		//13
		['week7_nomiss', false],		//14
		['week8_complete', false],		//15
		['week8_nomiss', false],		//16
		['week9_complete', false],		//17
		['week9_nomiss', false],		//18
		['week10_complete', false],		//19
		['week10_nomiss', false],		//20
		['week11_complete', false],		//21
		['week11_nomiss', false],		//22
		['week12_complete', false],		//23
		['week12_nomiss', false],		//24
		['ur_bad', false],				//25
		['ur_good', false],				//26
		['roadkill_enthusiast', false],	//27
		['oversinging', false],			//28
		['hype', false],				//29
		['two_keys', false],			//30
		['toastie', false],				//31
		['debugger', false], 			//32
		['amogus', false],				//33
		['freebie', false]				//34
	];

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(id:Int):Void {
		FlxG.log.add('Completed achievement "' + achievementsStuff[id][0] +'"');
		achievementsUnlocked[id][1] = true;
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsUnlocked != null) {
				FlxG.log.add("Trying to load stuff");
				var savedStuff:Array<String> = FlxG.save.data.achievementsUnlocked;
				for (i in 0...achievementsUnlocked.length) {
					for (j in 0...savedStuff.length) {
						if(achievementsUnlocked[i][0] == savedStuff[j]) {
							achievementsUnlocked[i][1] = true;
						}
					}
				}
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}

		// YO if anyones lookin at this look at this cringe text wall someone left bruh WHAT THE HECK 

		// You might be asking "Why didn't you just fucking load it directly dumbass??"
		// Well, Mr. Smartass, consider that this class was made for Mind Games Mod's demo,
		// i'm obviously going to change the "Psyche" achievement's objective so that you have to complete the entire week
		// with no misses instead of just Psychic once the full release is out. So, for not having the rest of your achievements lost on
		// the full release, we only save the achievements' tag names instead. This also makes me able to rename
		// achievements later as long as the tag names aren't changed of course.

		// Edit: Oh yeah, just thought that this also makes me able to change the achievements orders easier later if i want to.
		// So yeah, if you didn't thought about that i'm smarter than you, i think

		// buffoon
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	public function new(x:Float = 0, y:Float = 0, id:Int = 0) {
		super(x, y);

		if(Achievements.achievementsUnlocked[id][1]) {
			loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
			animation.add('icon', [id], 0, false, false);
			animation.play('icon');
		} else {
			loadGraphic(Paths.image('lockedachievement'));
		}
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(id:Int, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievementgrid'), true, 150, 150);
		achievementIcon.animation.add('icon', [id], 0, false, false);
		achievementIcon.animation.play('icon');
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}