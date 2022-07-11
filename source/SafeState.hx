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
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;

using StringTools;

class SafeState extends MusicBeatState
{
	var bg:FlxSprite;
	var fresh:FlxSprite;
	var madMan:FlxSprite;
	var dota2:FlxSprite;

	var safeDoorClosed:FlxSprite;
	var safeDoorOpen:FlxSprite;
	var keyPad:FlxSprite;

	var combination:Array<Int> = [];
	var safeText:FlxText;

	override function create()
	{
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

		safeDoorClosed = new FlxSprite(0 + 125, 0 + 50).loadGraphic(Paths.image('safe/Untitled-2'));
		safeDoorClosed.alpha = 1;
		add(safeDoorClosed);
		super.create();
    }

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (FlxG.mouse.overlaps(safeDoorClosed)) {
			safeDoorClosed.alpha = 0;
			if (FlxG.mouse.pressed) {
				//shadow over keypad numbers or hightlight, click sound, update text
			}
		} else {
			safeDoorClosed.alpha = 1;
		}
		
		super.update(elapsed);
	}
}