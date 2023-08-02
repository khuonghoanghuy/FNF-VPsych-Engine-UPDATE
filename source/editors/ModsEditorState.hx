package editors;

import flixel.FlxG;
import haxe.Json;
#if desktop
import ModsMenuState.ModMetadata;
#end
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import openfl.utils.Assets;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.ui.FlxButton;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flash.net.FileFilter;
import lime.system.Clipboard;

using StringTools;

class ModsEditorState extends MusicBeatState
{
    var _file:FileReference;
    var saveButton:FlxButton;

    // data json stuff
    var name:String = 'Template';
    var desc:String = 'A Template Pack JSON';
    var restart:Bool = false;
    var asGlobally:Bool = false;

    // color setting
    var bgR:FlxUINumericStepper;
    var bgG:FlxUINumericStepper;
    var bgB:FlxUINumericStepper;

    var bg:FlxSprite;

    // input stuff
    var descInput:FlxUIInputText;
    var nameInput:FlxUIInputText;

    override function create()
    {
        super.create();

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		add(bg);

        addButton();
        addInput();

		FlxG.mouse.visible = true;
    }

    function addButton()
    {
        saveButton = new FlxButton(FlxG.width - 400, 25, "Save", saveJSON);
        add(saveButton);

        bgR = new FlxUINumericStepper(saveButton.x, saveButton.y + 25, 40, 0, 0, 255);
        add(bgR);

        bgG = new FlxUINumericStepper(bgR.x + 100, bgR.y, 40, 0, 0, 255);
        add(bgG);

        bgB = new FlxUINumericStepper(bgG.x + 100, bgR.y, 40, 0, 0, 255);
        add(bgB);
    }

    function addInput()
    {
        descInput = new FlxUIInputText(saveButton.x + -300, saveButton.y, 0, desc, 15, FlxColor.BLACK, FlxColor.WHITE);
        add(descInput);

        nameInput = new FlxUIInputText(descInput.x + -200, descInput.y, 0, name, 15, FlxColor.BLACK, FlxColor.WHITE);
        add(nameInput);
    }

    // color stuff
    var r:Int = 0;
    var g:Int = 0;
    var b:Int = 0;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        r = Math.round(bgR.value);
        g = Math.round(bgG.value);
        b = Math.round(bgB.value);

        bg.color = FlxColor.fromRGB(r, g, b);

        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MasterEditorMenu());
        }
    }

    function saveJSON()
    {
        var jsonCode = {
            "name": name,
            "description": desc,
            "restart": restart,
            "runsGlobally": asGlobally,
            "color": [r, g, b]
        }

        var data:String = Json.stringify(jsonCode, "\t");

		if (data.length > 0)
		{
			_file = new FileReference();
			_file.addEventListener(Event.COMPLETE, onSaveComplete);
			_file.addEventListener(Event.CANCEL, onSaveCancel);
			_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file.save(jsonCode, ".json");
		}
    }

    function onSaveComplete(_):Void
    {
        _file.removeEventListener(Event.COMPLETE, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
        FlxG.log.notice("Successfully saved LEVEL DATA.");
    }

    /**
     * Called when the save file dialog is cancelled.
     */
    function onSaveCancel(_):Void
    {
        _file.removeEventListener(Event.COMPLETE, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
    }

    /**
     * Called if there is an error while saving the gameplay recording.
     */
    function onSaveError(_):Void
    {
        _file.removeEventListener(Event.COMPLETE, onSaveComplete);
        _file.removeEventListener(Event.CANCEL, onSaveCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        _file = null;
        FlxG.log.error("Problem saving Level data");
    }
}