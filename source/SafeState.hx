package;

#if desktop
import Discord.DiscordClient;
#end
import Achievements;
import editors.MasterEditorMenu;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;


using StringTools;

class SafeState extends MusicBeatState
{
	public static var undeadUnlocked:Bool = false;
	public static var freshUnlocked:Bool = false;
	public static var madmanUnlocked:Bool = false;
	public static var letspubUnlocked:Bool = false;

	var testing:Bool = true;

	var bg:FlxSprite;
	var fresh:FlxSprite;
	var madMan:FlxSprite;
	var dota2:FlxSprite;
	var timRain:FlxSprite;

	var freshNote:FlxSprite;
	var undeadNote:FlxSprite;
	var letspubNote:FlxSprite;
	var madManNote:FlxSprite;

	var freshComb:String = "6185198";
	var madManComb:String = "2242015";
	var letsPubComb:String = "792013";
	var tRComb:String = "26";
	var selectedSong:String = "";

	var doorTimer:Int; // lets the door animation play before switching to the song
	var correctComb:Bool = false; // prevents shadow from showing

	var safeDoorClosed:FlxSprite;
	var safeDoorOpen:BGSprite;
	var keyPad:FlxSprite;

	var mmEntered:Bool;
	var test:FlxSprite;

	var poundEnter:FlxSprite;
	var starCancel:FlxSprite;

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

	override function create()
	{
		doorTimer = -1;
		FlxG.mouse.visible = true;

		bg = new FlxSprite().loadGraphic(Paths.image('safe/safe'));
		add(bg);

		dota2 = new FlxSprite().loadGraphic(Paths.image('safe/safeletsPub'));
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

		undeadNote = new FlxSprite(30, 20).loadGraphic(Paths.image('safe/undeadNote'));
		add(undeadNote);

		freshNote = new FlxSprite(1075, 15).loadGraphic(Paths.image('safe/abaddreamNote'));
		add(freshNote);

		letspubNote = new FlxSprite(70, 540).loadGraphic(Paths.image('safe/letspubNote'));
		add(letspubNote);
		
		madManNote = new FlxSprite(1050, 520).loadGraphic(Paths.image('safe/madManNote'));
		add(madManNote);

		test = new FlxSprite(0, 0).loadGraphic(Paths.image('notes/download'));

		starCancel = new FlxSprite(691, 474).loadGraphic(Paths.image('safe/starCancel'));
		poundEnter = new FlxSprite(837, 474).loadGraphic(Paths.image('safe/poundEnter'));
		starCancel.alpha = 0;
		poundEnter.alpha = 0;
		add(starCancel);
		add(poundEnter);

		// theres probably a better way to code this but im 2 lazy and sleepy LOL
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

		safeDoorOpen = new BGSprite('safe/safeDoor', 160, 5, 1, 1, ['doorOpen0'], false);

		safeText = new FlxText(695, 150, 250, "", 32);
		safeText.setFormat(Paths.font("lcd.ttf"), 80, FlxColor.LIME, LEFT);
		safeText.autoSize = true;
		safeText.wordWrap = false;
		add(safeText);

		super.create();
	}

	override function update(elapsed:Float)
	{
		//trace(undeadUnlocked);
		// safeDoorOpen.alpha -= 0.01;
		safeText.size = 72;
		safeDoorOpen.y += 1;
		doorTimer--;

		if (undeadUnlocked) {
			undeadNote.alpha = 1;
		} else {
			undeadNote.alpha = 0;
		}
		if (freshUnlocked) {
			freshNote.alpha = 1;
		} else {
			freshNote.alpha = 0;
		}
		if (madmanUnlocked) {
			madManNote.alpha = 1;
		} else {
			madManNote.alpha = 0;
		}
		if (letspubUnlocked) {
			letspubNote.alpha = 1;
		} else {
			letspubNote.alpha = 0;
		}

		if (safeText.text != "") {
			starCancel.alpha = 1;
			poundEnter.alpha = 1;
		} else if (safeText.text == "") {
			starCancel.alpha = 0;
			poundEnter.alpha = 0;
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (FlxG.mouse.overlaps(sh1) && correctComb == false)
		{
			sh1.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{
				sh1.alpha = 0;
			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "1";
			}
		}
		else
		{
			sh1.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh2) && correctComb == false)
		{
			sh2.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "2";
			}
		}
		else
		{
			sh2.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh3) && correctComb == false)
		{
			sh3.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "3";
			}
		}
		else
		{
			sh3.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh4) && correctComb == false)
		{
			sh4.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "4";
			}
		}
		else
		{
			sh4.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh5) && correctComb == false)
		{
			sh5.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "5";
			}
		}
		else
		{
			sh5.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh6) && correctComb == false)
		{
			sh6.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "6";
			}
		}
		else
		{
			sh6.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh7) && correctComb == false)
		{
			sh7.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "7";
			}
		}
		else
		{
			sh7.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh8) && correctComb == false)
		{
			sh8.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "8";
			}
		}
		else
		{
			sh8.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh9) && correctComb == false)
		{
			sh9.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "9";
			}
		}
		else
		{
			sh9.alpha = 0;
		}
		if (FlxG.mouse.overlaps(sh0) && correctComb == false)
		{
			sh0.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/selected'), 1);
				safeText.text += "0";
			}
		}
		else
		{
			sh0.alpha = 0;
		}

		if (FlxG.mouse.overlaps(shStar) && correctComb == false)
		{
			shStar.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				FlxG.sound.play(Paths.sound('safe/cancel'), 1);
				safeText.text = "";
			}
		}
		else
		{
			shStar.alpha = 0;
		}

		if (FlxG.mouse.overlaps(shPound) && correctComb == false)
		{
			shPound.alpha = 0.5;
			if (FlxG.mouse.pressed)
			{

			}
			else if (FlxG.mouse.justReleased)
			{
				trace(safeText.text); FlxG.sound.play(Paths.sound('safe/selected'), 1);

				switch (safeText.text)
				{
					// Undead song unlock
					case '26':
						selectUnlock('undead');
						undeadUnlocked = testing;
						FlxG.save.data.undeadUnlocked = undeadUnlocked;
						FlxG.sound.play(Paths.sound('secretSound'), 0.7);
						FlxG.sound.play(Paths.sound('safe/safeOpen'), 1);
						FlxG.save.flush();
						trace('opening safe');
					// Fresh song unlock
					case '6185198':
						selectUnlock('a-bad-dream');
						freshUnlocked = testing;
						FlxG.sound.play(Paths.sound('secretSound'), 0.7);
						FlxG.sound.play(Paths.sound('safe/safeOpen'), 1);
						FlxG.save.data.freshUnlocked = freshUnlocked;
						FlxG.save.flush();
					// Lets Pub song unlock
					case '792013':
						selectUnlock('lets-pub');
						letspubUnlocked = testing;
						FlxG.save.data.letspubUnlocked = letspubUnlocked;
						FlxG.sound.play(Paths.sound('secretSound'), 0.7);
						FlxG.sound.play(Paths.sound('safe/safeOpen'), 1);
						FlxG.save.flush();
					// Madman song unlock
					case '2242015':
						selectUnlock('chrome');
						madmanUnlocked = testing;
						FlxG.sound.play(Paths.sound('secretSound'), 0.7);
						FlxG.sound.play(Paths.sound('safe/safeOpen'), 1);
						FlxG.save.data.madmanUnlocked = madmanUnlocked;
						FlxG.save.flush();
					default:
						safeText.text = "";
						FlxG.sound.play(Paths.sound('safe/wrongcomb'), 1);
						correctComb = false;
				}
			}
			
			if (safeDoorOpen.animation.finished)
			{
				selectUnlock(selectedSong);
			}

			trace(safeDoorOpen.animation.finished);
			super.update(elapsed);
		}
		else
		{
			shPound.alpha = 0;
		}
	}

	public function selectUnlock(name:String)
	{
		var hard:Int = 1;

		var songNameAndDif:String = Highscore.formatSong(name, hard);

		PlayState.isStoryMode = false;
		PlayState.isFreeplay = false;
		PlayState.storyDifficulty = hard;
		PlayState.SONG = Song.loadFromJson(songNameAndDif, name); // either a direct string or a weird fuckign variable will idk

		LoadingState.loadAndSwitchState(new PlayState(), true);
		FreeplayState.destroyFreeplayVocals();
		trace("selectUnlock done");
	}

	private function openSafe(song:String)
	{
		add(safeDoorOpen);
		safeDoorOpen.animation.play("doorOpen0", true);
		safeDoorOpen.alpha = 1;
		safeDoorClosed.alpha = 0;
		safeDoorOpen.y = 5;
		correctComb = true;
		selectedSong = song;
		mmEntered = true;
		safeText.text = "";
		trace("safe opened");
	}

	//i think this works i just wanna wait until everything else is done before testing
	//but this should load the notes on startup if you've already unlocked them
	/*public function loadNotes():Void {
		if (FlxG.save.data.freshUnlocked != null) {
			freshUnlocked = FlxG.save.data.freshUnlocked;
		}
		if (FlxG.save.data.undeadUnlocked != null) {
			undeadUnlocked = FlxG.save.data.undeadUnlocked;
		}
		if (FlxG.save.data.letspubUnlocked != null) {
			letspubUnlocked = FlxG.save.data.undeadUnlocked;
		}
		if (FlxG.save.data.madmanUnlocked != null) {
			madmanUnlocked = FlxG.save.data.madmanUnlocked;
		}
	}*/
}
// [file_contents,assets/data//blammed.json]
