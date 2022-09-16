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
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Freaky on a Friday Night",	"Play on a Friday... Night",			   'friday_night_play',	 	true],		//0
		["Tavern Initiate",				"Beat Week 1 on any difficulty.",				  'week1_beat',		false],		//1
		["The Bigger They Are...",		"Beat Week 1 on Hard with no Misses.",		    'week1_nomiss',		false],		//2
		["Tim's Got the Shotgun", 		"Beat Week 2 on any difficulty.",				  'week2_beat',		false],		//3
		["Thumbs Down",					"Beat Week 2 on Hard with no Misses.",			'week2_nomiss',		false],		//4
		["We Made Heaven",				"Beat Week 3 on any difficulty.",				  'week3_beat',		false],		//5	
		["Too Much of Heaven",			"Beat Week 3 on Hard with no Misses.",			'week3_nomiss',		false],		//6
		["Two Pointer",					"Beat Week 4 on any difficulty.",				  'week4_beat',		false],		//7	
		["Quad City King",				"Beat Week 4 on Hard with no Misses.",			'week4_nomiss',		false],		//8
		["GREEN LIGHT",					"Beat Week 5 on any difficulty.",				  'week5_beat', 	false],		//9	
		["BLACK LIGHT",					"Beat Week 5 on Hard with no Misses.",			'week5_nomiss',		false],		//10
		["Getting Your Feet Wet",		"Beat Week 6 on any difficulty.",				  'week6_beat',		false],		//11	
		["Bless the Rain",				"Beat Week 6 on Hard with no Misses.",			'week6_nomiss',		false],		//12
		["Whiplash",					"Beat Week 7 on any difficulty.",				  'week7_beat',		false],		//13	
		["Rhapsody in Red",				"Beat Week 7 on Hard with no Misses.",			'week7_nomiss',		false],		//14
		["Boned",						"Beat Week 8 on any difficulty.",				  'week8_beat',		false],		//15	
		["Rattled",						"Beat Week 8 on Hard with no Misses.",			'week8_nomiss',		false],		//16
		["Dungeon... Raided",			"Beat Week 9 on any difficulty.",				  'week9_beat',		false],		//17	
		["Dethroned",					"Beat Week 9 on Hard with no Misses.",			'week9_nomiss',		false],		//18
		["Fresh Out The Bag",			"Beat Week 10 on any difficulty.",				 'week10_beat',		false],		//19	
		["Usurped",						"Beat Week 10 on Hard with no Misses.",		   'week10_nomiss',		false],		//20
		["Purged",						"Beat Week 11 on any difficulty.",				 'week11_beat',		false],		//21	
		["Case Closed",					"Beat Week 11 on Hard with no Misses.",		   'week11_nomiss',		false],		//22
		["Pubstar",						"Beat Week 12 on any difficulty.",				 'week12_beat',		false],		//23	
		["Pubstomp",					"Beat Week 12 on Hard with no Misses.",		   'week12_nomiss',		false],		//24
		["What a Funkin' Disaster!",	"Complete a Song with a rating lower than 20%.",	  'ur_bad',		false],		//25
		["Perfectionist",				"Complete a Song with a rating of 100%.",			 'ur_good',		false],		//26
		["Roadkill Enthusiast",			"Watch the Henchmen die over 100 times.",'roadkill_enthusiast',		false],		//27
		["Oversinging Much...?",		"Hold down a note for 20 seconds.",				 'oversinging', 	false],		//28
		["Hyperactive",					"Finish a Song without going Idle.",				    'hype',		false],		//29
		["Just the Two of Us",			"Finish a Song pressing only two keys.",			'two_keys',		false],		//30
		["Toaster Gamer",				"Have you tried to run the game on a toaster?",		 'toastie',		false],		//31
		["Debugger",					"Beat the \"Test\" Stage from the Chart Editor.",	'debugger',		true],		//32
		["A bit sussy!",				"See a suspicious looking board in the tutorial stage.", 'sus',		true],		//33
		["Oh Yeah.",					"See Heaven's hidden face.",						   'face1',		true],		//34
		["It's Time To Slam!",			"See Charles's true face.",							   'face2',		true],		//35
		["Achieve Enlightenment",		"...",												   'trick',		true]		//36
	];

	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function lockAchievement(name:String):Void {
		achievementsMap.set(name, false);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image('achievements/' + tag));
		} else {
			loadGraphic(Paths.image('achievements/lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
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
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievements/' + name));
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