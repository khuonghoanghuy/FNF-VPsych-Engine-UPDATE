#if CUSTOM_REPLAY
package;

import flixel.FlxG;
import PlayState;
import flixel.FlxSprite;

// this states is powerful
// still very w.i.p
class ReplayState extends MusicBeatState
{
    var replayFrom:PlayState;

    var arrayJSON:Array<String> = [];
    var textPush:Array<String> = [];

    override function create()
    {
        super.create();

        textPush = CoolUtil.coolTextFile(Paths.txt("replayStuff",  "replay"));

        var str:String = textPush[i];

        // game load json file if need?
        arrayJSON.push(str);

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		add(bg);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.BACK)
            MusicBeatState.switchState(new MainMenuState());
    }
}
#end