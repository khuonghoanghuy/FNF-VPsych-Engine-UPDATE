package options;

class OptimizationSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Optimization Settings';
		rpcTitle = 'Optimization Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Hide Characters And BG',
			'If checked, hide characters and bg, only display HUD.',
			'hideCharBG',
			'bool');
		addOption(option);

        var option:Option = new Option('Light Opponent Strums',
            "If unchecked, when opponent hit a note, the strums opponent won't light.",
            'lightOpponentStrums',
            'bool');
        addOption(option);

        var option:Option = new Option('Light Player Strums',
            "If unchecked, when player hit a note, the strums opponent won't light.",
            'lightPlayerStrums',
            'bool');
        addOption(option);

		super();
	}
}
