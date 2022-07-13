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

class StickyNoteState extends MusicBeatState
{
	var bg:FlxSprite;
	var fresh:FlxSprite;
	var madMan:FlxSprite;
	var letsPub:FlxSprite;
	var timRain:FlxSprite;

	var note:String;

	override function create()
	{
		FlxG.mouse.visible = false;

		bg = new FlxSprite().loadGraphic(Paths.image('FUCK YOU'));
		add(bg);

		fresh = new FlxSprite().loadGraphic(Paths.image('safe/fresh'));
		madMan = new FlxSprite().loadGraphic(Paths.image('safe/madMan'));
		letsPub = new FlxSprite().loadGraphic(Paths.image('safe/letsPub'));
		timRain = new FlxSprite().loadGraphic(Paths.image('safe/timRain'));

		if (note == "fresh") {
			add(fresh);
		} else if (note == "madMan") {
			add(madMan);
		} else if (note == "letsPub") {
			add(letsPub);
		} else if (note == "timRain") {
			add(timRain);
		}

		super.create();
    }

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.BACK || controls.ACCEPT || FlxG.mouse.pressed)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new CreditsState());
		}

		super.update(elapsed);
	}
}