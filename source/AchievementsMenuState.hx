package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import Achievements;

using StringTools;

class AchievementsMenuState extends MusicBeatState
{
	var options:Array<String> = [];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Array<Int> = [0, 0];
	private var achievementArray:Array<AttachedAchievement> = [];
	private var achievementIndex:Array<Int> = [];
	private var descText:FlxText;
	private var titleText:FlxText;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Achievements Menu", null);
		#end

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(menuBG);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		Achievements.loadAchievements();
		for (i in 0...Achievements.achievementsStuff.length) {
			if(!Achievements.achievementsStuff[i][3] || Achievements.achievementsMap.exists(Achievements.achievementsStuff[i][2])) {
				options.push(Achievements.achievementsStuff[i]);
				achievementIndex.push(i);
			}
		}

		for (i in 0...options.length) {
			var achieveName:String = Achievements.achievementsStuff[achievementIndex[i]][2];
			var optionText:Alphabet = new Alphabet((100 * i), 0 + 210, '', false, false);
			optionText.isMenuItem = true;
			optionText.isAchievementMenu = true;
			optionText.x += 250;
			optionText.y -= 150;
			while(optionText.x > 1200){
				optionText.x -= 1000;
				optionText.y += 100;
			}
			optionText.xAdd = 150;
			//optionText.targetY = 1;
			grpOptions.add(optionText);

			var icon:AttachedAchievement = new AttachedAchievement(optionText.x, optionText.y, achieveName);

			icon.sprTracker = optionText;
			achievementArray.push(icon);
			//trace("Icon " + i + "|| x = " +  icon.x + " || y = " + icon.y );					DEBUG FOR POSITIONING !!!!!!!!!!!!!!!!!!!!!!
			add(icon);
		}

		descText = new FlxText(150, 600, 980, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		titleText = new FlxText(150, 550, 980, "", 48);
		titleText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleText.scrollFactor.set();
		titleText.borderSize = 2.6;
		add(titleText);

		changeSelection();

		super.create();
		trace("Finished!");
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_LEFT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(-1, 0);
		}
		if (controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(1, 0);
		}
		if (controls.UI_UP_P){
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(0, -1);
		}
		if (controls.UI_DOWN_P){
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(0, 1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}
	}

	function changeSelection(changeX:Int = 0, changeY:Int = 0) {
		
		curSelected[0] += changeX;
		curSelected[1] += changeY;

		if (curSelected[0] > 9)
			curSelected[0] = 0;
		else if (curSelected[0] < 0){
			curSelected[0] = 9;
		}
		if (curSelected[1] > Std.int(options.length / 10)) // Hard coded, try FlxMath.roundDecimal((options.length / 10), 0) later.
			curSelected[1] = 0;
		else if (curSelected[1] < 0){
			curSelected[1] = Std.int(options.length / 10);
		}

		
		var index = curSelected[0] + (10*curSelected[1]);
		trace("Index: " + index + " || curSelected[0] == " + curSelected[0] + " || curSelected[1] == " + curSelected[1]);

		while (curSelected[0] * curSelected[1] > index){
			while((curSelected[0]*curSelected[1]) - index >= 10){
				curSelected[1] -= 1;
			}
			while((curSelected[0]*curSelected[1]) - index < 10){
				curSelected[0] -= 1;
			}
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - index; // check
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}

		for (i in 0...achievementArray.length) {
			achievementArray[i].alpha = 0.6;
			if(i == index) {
				achievementArray[i].alpha = 1;
			}
		}
		descText.text = Achievements.achievementsStuff[achievementIndex[index]][1];
		titleText.text = Achievements.achievementsStuff[achievementIndex[index]][0];
	}
}
