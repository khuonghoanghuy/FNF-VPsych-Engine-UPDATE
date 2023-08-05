package options;

class ScreenShotSubState extends BaseOptionsMenu
{
    public function new()
    {
        var option:Option = new Option("Allow Save File", "If checked, When take a screenshot, game will save the image file for you", "allowSaveFile", "bool", true);
        addOption(option);

        var option:Option = new Option("Allow Capture Mouse", "If checked, When take a screenshot, the image will capture your mouse too", "allowCaptureMouse", "bool", true);
        addOption(option);

        super();
    }    
}