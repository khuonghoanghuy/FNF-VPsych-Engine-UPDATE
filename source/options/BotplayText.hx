package options;

import ClientPrefs;

class BotplayText
{   
    public static var botplaytxt:Array<String> = [];

    public function new()
    {
        botplaytxt = CoolUtil.coolTextFile(Paths.txt("botplayPush"));
        // ClientPrefs.botText = botplaytxt;
    }
}