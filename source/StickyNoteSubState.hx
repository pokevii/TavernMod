package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
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

class StickyNoteSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var fresh:FlxSprite;
	var madMan:FlxSprite;
	var letsPub:FlxSprite;
	var timRain:FlxSprite;

	var sad:FlxSprite;

	public function new(note:String)
	{
		super();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.7;
		add(bg);

		fresh = new FlxSprite().loadGraphic(Paths.image('notes/fresh'));
		madMan = new FlxSprite().loadGraphic(Paths.image('notes/madMan'));
		letsPub = new FlxSprite().loadGraphic(Paths.image('notes/letsPub'));
		timRain = new FlxSprite().loadGraphic(Paths.image('notes/rainTim'));
		sad = new FlxSprite().loadGraphic(Paths.image('notes/download'));

		sad.screenCenter(X);
		sad.screenCenter(Y);

		fresh.screenCenter(X);
		fresh.screenCenter(Y);
		madMan.screenCenter(X);
		madMan.screenCenter(Y);
		letsPub.screenCenter(X);
		letsPub.screenCenter(Y);
		timRain.screenCenter(X);
		timRain.screenCenter(Y);
		
		sad.alpha = 1;
		fresh.alpha = 0;
		madMan.alpha = 0;
		letsPub.alpha = 0;
		timRain.alpha = 0;

		add(sad);
		add(fresh);
		add(madMan);
		add(letsPub);
		add(timRain);

		if (note == "fresh") {
			fresh.alpha = 1;
		} else {
			fresh.alpha = 0;
		}
		if (note == "madMan") {
			madMan.alpha = 1;
		} else {
			madMan.alpha = 0;
		}
		if (note == "letsPub") {
			letsPub.alpha = 1;
		} else {
			letsPub.alpha = 0;
		}
		if (note == "timRain") {
			timRain.alpha = 1;
		} else {
			timRain.alpha = 0;
		}
    }

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		sad.alpha -= 0.01;

		if (controls.BACK || controls.ACCEPT || FlxG.mouse.pressed)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
		}

		super.update(elapsed);
	}
}