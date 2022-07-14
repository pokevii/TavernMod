package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;

using StringTools;

class SafeState extends MusicBeatState {
	var bg:FlxSprite;
	var fresh:FlxSprite;
	var madMan:FlxSprite;
	var dota2:FlxSprite;
	var timRain:FlxSprite;

	var freshComb:String;
	var madManComb:String;
	var letsPubComb:String;
	var tRComb:String;
	var selectedSong:String = "";

	var doorTimer:Int; //lets the door animation play before switching to the song
	var correctComb:Bool = false; //prevents shadow from showing

	var safeDoorClosed:FlxSprite;
	var safeDoorOpen:BGSprite;
	var keyPad:FlxSprite;

	var mmEntered:Bool;
	var test:FlxSprite;

	var sh0:FlxSprite;
	var sh1:FlxSprite;
	var sh2:FlxSprite;
	var sh3:FlxSprite;
	var sh4:FlxSprite;
	var sh5:FlxSprite;
	var sh6:FlxSprite;
	var sh7:FlxSprite;
	var sh8:FlxSprite;
	var sh9:FlxSprite;
	var shStar:FlxSprite;
	var shPound:FlxSprite;

	var safeText:FlxText;

	override function create()	{
		freshComb = "6185198";
		letsPubComb = "792013";
		madManComb = "2242015";
		tRComb = "26";
		doorTimer = -1;
		FlxG.mouse.visible = true;

		bg = new FlxSprite().loadGraphic(Paths.image('safe/safe'));
		add(bg);

		dota2 =  new FlxSprite().loadGraphic(Paths.image('safe/safeletsPub'));
		dota2.alpha = 0.5;
		add(dota2);

		fresh = new FlxSprite().loadGraphic(Paths.image('safe/safeFresh'));
		fresh.alpha = 0.5;
		add(fresh);

		madMan = new FlxSprite().loadGraphic(Paths.image('safe/safeMadman'));
		madMan.alpha = 0.5;
		add(madMan);

		safeDoorClosed = new FlxSprite(-10, 5).loadGraphic(Paths.image('safe/safeDoorClosed'));
		safeDoorClosed.alpha = 1;
		add(safeDoorClosed);

		test = new FlxSprite(0, 0).loadGraphic(Paths.image('notes/download'));

		//theres probably a better way to code this but im 2 lazy and sleepy LOL
		sh1 = new FlxSprite(691, 254).loadGraphic(Paths.image('safe/buttonShadow'));
		sh2 = new FlxSprite(765, 254).loadGraphic(Paths.image('safe/buttonShadow'));
		sh3 = new FlxSprite(837, 254).loadGraphic(Paths.image('safe/buttonShadow'));

		sh4 = new FlxSprite(691, 328).loadGraphic(Paths.image('safe/buttonShadow'));
		sh5 = new FlxSprite(765, 328).loadGraphic(Paths.image('safe/buttonShadow'));
		sh6 = new FlxSprite(837, 328).loadGraphic(Paths.image('safe/buttonShadow'));

		sh7 = new FlxSprite(691, 402).loadGraphic(Paths.image('safe/buttonShadow'));
		sh8 = new FlxSprite(765, 402).loadGraphic(Paths.image('safe/buttonShadow'));
		sh9 = new FlxSprite(837, 402).loadGraphic(Paths.image('safe/buttonShadow'));

		sh0 = new FlxSprite(765, 475).loadGraphic(Paths.image('safe/buttonShadow'));
		shStar = new FlxSprite(691, 475).loadGraphic(Paths.image('safe/buttonShadow'));
		shPound = new FlxSprite(837, 475).loadGraphic(Paths.image('safe/buttonShadow'));
		sh1.alpha = 0;
		sh2.alpha = 0;
		sh3.alpha = 0;
		sh4.alpha = 0;
		sh5.alpha = 0;
		sh6.alpha = 0;
		sh7.alpha = 0;
		sh8.alpha = 0;
		sh9.alpha = 0;
		sh0.alpha = 0;
		shStar.alpha = 0;
		shPound.alpha = 0;
		add(sh1);
		add(sh2);
		add(sh3);
		add(sh4);
		add(sh5);
		add(sh6);
		add(sh7);
		add(sh8);
		add(sh9);
		add(sh0);
		add(shStar);
		add(shPound);

		safeDoorOpen = new BGSprite('safe/safeDoor', 160, 5, 1, 1, ['doorOpen'], false);

		safeText = new FlxText(700, 100, 0, "", 32);
		safeText.setFormat(Paths.font("lcd.ttf"), 80, FlxColor.LIME, LEFT);
		add(safeText);

		super.create();
    }

	override function update(elapsed:Float)
	{
		safeDoorOpen.alpha -= 0.01;
		safeDoorOpen.y += 1;
		doorTimer--;

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (FlxG.mouse.overlaps(sh1) && correctComb == false) {
			sh1.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "1";
			}
		} else {
			sh1.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh2) && correctComb == false) {
			sh2.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "2";
			}
		} else {
			sh2.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh3) && correctComb == false) {
			sh3.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "3";
			}
		} else {
			sh3.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh4) && correctComb == false) {
			sh4.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "4";
			}
		} else {
			sh4.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh5) && correctComb == false) {
			sh5.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "5";
			}
		} else {
			sh5.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh6) && correctComb == false) {
			sh6.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "6";
			}
		} else {
			sh6.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh7) && correctComb == false) {
			sh7.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "7";
			}
		} else {
			sh7.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh8) && correctComb == false) {
			sh8.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "8";
			}
		} else {
			sh8.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh9) && correctComb == false) {
			sh9.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "9";
			}
		} else {
			sh9.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh0) && correctComb == false) {
			sh0.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text += "0";
			}
		} else {
			sh0.alpha = 0;
		}

		if (FlxG.mouse.overlaps(shStar) && correctComb == false) {
			shStar.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				safeText.text = "";
			}
		} else {
			shStar.alpha = 0;
		}

		if (FlxG.mouse.overlaps(shPound) && correctComb == false) {
			shPound.alpha = 0.5;
			if (FlxG.mouse.pressed) {
				//press sound here
			} else if (FlxG.mouse.justReleased) {
				//release sound here
				if (safeText.text == tRComb) {
					add(safeDoorOpen);
					safeDoorOpen.alpha = 1;
					safeDoorClosed.alpha = 0;
					safeDoorOpen.y = 5;
					doorTimer = 90;
					correctComb = true;
					selectedSong = 'blammed';
					mmEntered = true;
					safeText.text = "";
				} else {
					safeText.text = "";
					correctComb = false;
				}
		} else {
			shPound.alpha = 0;
		}

		if (doorTimer <= 0)
		{
		}

		if (selectedSong == 'blammed') {
			selectUnlock('blammed');
		}
		super.update(elapsed);
	}

	} public function selectUnlock(name:String) {
		var hard:Int = 2;

		var songNameAndDif:String = Highscore.formatSong(selectedSong, hard);

		PlayState.isStoryMode = false;
		PlayState.isFreeplay = false;
		PlayState.storyDifficulty = hard;
		PlayState.SONG = Song.loadFromJson(songNameAndDif, name); //either a direct string or a weird fuckign variable will idk

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
	}
}

//[file_contents,assets/data//blammed.json]