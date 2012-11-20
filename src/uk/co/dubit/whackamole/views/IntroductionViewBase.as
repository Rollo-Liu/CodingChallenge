package uk.co.dubit.whackamole.views
{
	import flash.events.Event;
	
	import spark.components.Button;
	import spark.components.Group;
	
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;
	
	[Event(name="introductionStart", type="uk.co.dubit.whackamole.views.events.IntroductionViewEvent")]
	public class IntroductionViewBase extends Group
	{		
		public var startButton:Button;
		
		private var difficulty:String = IntroductionViewEvent.DIFFICULTY_MEDIUM;
		
		protected function onStartButtonClick() : void
		{
			dispatchEvent(new IntroductionViewEvent(IntroductionViewEvent.START, this.difficulty));
		}
		
		protected function onRadioButtonEasyClick(event:Event) : void
		{
			this.difficulty = IntroductionViewEvent.DIFFICULTY_EASY;
		}
		
		protected function onRadioButtonMediumClick(event:Event) : void
		{
			this.difficulty = IntroductionViewEvent.DIFFICULTY_MEDIUM;
		}
		
		protected function onRadioButtonHardClick(event:Event) : void
		{
			this.difficulty = IntroductionViewEvent.DIFFICULTY_HARD;
		}
	}
}