package editors;

import flixel.FlxSprite;
import openfl.net.FileReference;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIInputText;
import flixel.ui.FlxButton;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import haxe.Json;
import FlxUIDropDownMenuCustom;

// now i know that we can't do it!
class CodePad extends MusicBeatState
{
  var _file:FileReference;

  var str:String = "";
  var saveFile:FlxButton;
  var openFile:FlxButton;
  var partInput:FlxUIInputText;

  override function create()
  {
    super.create();

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set();
		bg.color = 0xFF222222;
		add(bg);

    addButton();
    addDrop();
    addInput();

		FlxG.mouse.visible = true;
  }

  function addButton()
  {
    saveFile = new FlxButton(FlxG.width - 400, 25, "Save", saveFileStuff);
    saveFile.scrollFactor.set();
    add(saveFile);

    openFile = new FlxButton(saveFile.x + 100, saveFile.y, "Open", openFileStuff);
    openFile.scrollFactor.set();
    add(openFile);
  }

  var typeFileDrop:FlxUIDropDownMenuCustom;
  var needType:String;

  function addDrop()
  {
    var type:Array<String> = CoolUtil.coolTextFile(Paths.txt('typeFile'));
    typeFileDrop = new FlxUIDropDownMenuCustom(saveFile.x + -200, saveFile.y, FlxUIDropDownMenuCustom.makeStrIdLabelArray(type), function(typeStr:String)
    {
      needType = type[Std.parseInt(typeStr)];
    });
    add(typeFileDrop);
  }

  function addInput()
  {
    partInput = new FlxUIInputText(FlxG.width - 400, 50, 100, str, 50, FlxColor.BLACK, FlxColor.WHITE);
    partInput.resize(50, 150);
    partInput.scrollFactor.set();
    add(partInput);
  }

  function saveFileStuff()
  {
    var code = str;

    var data:String = Json.stringify(code, "\t");

    if (data.length > 0)
    {
      _file = new FileReference();
      _file.addEventListener(Event.COMPLETE, onSaveComplete);
      _file.addEventListener(Event.CANCEL, onSaveCancel);
      _file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
      _file.save(code, "." + needType);
    }
  }

  function openFileStuff()
  {

  }

  override function update(elapsed:Float)
  {
    super.update(elapsed);

    partInput.text = str; // str is need for typing stuff

    if (FlxG.keys.justPressed.ESCAPE) {
      FlxG.switchState(new MasterEditorMenu());
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
