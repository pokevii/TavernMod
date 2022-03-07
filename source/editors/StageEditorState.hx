package editors;

import Conductor.BPMChangeEvent;
import Section.SwagSection;
import Song.SwagSong;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.format.JsonParser;
import haxe.io.Bytes;
import lime.media.AudioBuffer;
import lime.utils.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.ByteArray;

using StringTools;

#if desktop
// import Discord.DiscordClient;
#end
#if MODS_ALLOWED
import flash.media.Sound;
import sys.FileSystem;
import sys.io.File;
#end

class StageEditorState extends MusicBeatState
{
	var stageDropDown:FlxUIDropDownMenuCustom;

	override function create()
	{
		#if MODS_ALLOWED
		var stages:Array<String> = [
			Paths.mods('stages/'),
			Paths.mods(Paths.currentModDirectory + '/stages/'),
			Paths.getPreloadPath('stages/')
		];
		#else
		var stages:Array<String> = [Paths.getPreloadPath('stages/')];
		#end

		stageDropDown = new FlxUIDropDownMenuCustom(FlxG.width / 3, FlxG.height / 3, FlxUIDropDownMenuCustom.makeStrIdLabelArray(stages, true),
			function(character:String)
			{
				// stage = stages[Std.parseInt(character)];
			});
		var bg:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('stageEditor'));
		add(bg);

		var text = new FlxText(20, 20, 100, "Stage Editor!", 8);
		add(text);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE)
		{
			MusicBeatState.switchState(new MainMenuState());
		}
	}
}
