package uk.co.dubit.whackamole.views.events
{
	import flash.events.Event;
	
	public class IntroductionViewEvent extends Event
	{
		public static const START:String = "introductionStart";
		public static const DIFFICULTY_EASY:String = "difficultyEasy";
		public static const DIFFICULTY_MEDIUM:String = "difficultyMedium";
		public static const DIFFICULTY_HARD:String = "difficultyHard";
		
		private var _difficulty:String;
		
		public function IntroductionViewEvent(type:String, difficulty:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_difficulty = difficulty;
			super(type, bubbles, cancelable);
		}
		
		public function get difficulty():String
		{
			return _difficulty;
		}
	}
}