package options;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;

using StringTools;

class BotplaySubState extends BaseOptionsMenu
{
    public function new()
    {
        title = 'Botplay';
		rpcTitle = 'Botplay Settings Menu'; //for Discord Rich Presence

        var option:Option = new Option('Light Player Strums', 
            "If checked, when botplay hit a note, note will won't light until this setting turn off.",
            "botplayLight",
            "bool",
            false
        );
        addOption(option);

        var option:Option = new Option('Force Gain Score',
            "If checked, when botplay hit a note, score will gain like you pressing a note\nBut when end a songs, score will back to 0",
            "botplayScore",
            "bool",
            false
        );
        addOption(option);

        var option:Option = new Option("Don't play Anim",
            "If checked, when botplay hit a note, characters as player will not play animation left/down/up/right.",
            "botplayAmin",
            "bool",
            false
        );
        addOption(option);

        super();
    }
}