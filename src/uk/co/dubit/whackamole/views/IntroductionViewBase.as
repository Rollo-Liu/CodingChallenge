package uk.co.dubit.whackamole.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.effects.Parallel;
	import mx.effects.Sequence;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.RadioButton;
	
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;
	
	[Event(name="introductionStart", type="uk.co.dubit.whackamole.views.events.IntroductionViewEvent")]
	public class IntroductionViewBase extends Group
	{		
		public var titleEntryAnimation:Sequence;
		public var titleExitAnimation:Parallel;
		
		[Bindable]
		public var startButton:Button;
		
		private var difficulty:String = IntroductionViewEvent.DIFFICULTY_MEDIUM;
		
		public function IntroductionViewBase()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		protected function onStartButtonClick() : void
		{
			startButton.enabled = false;
			titleExitAnimation.play();
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
		
		protected function onCreationComplete(event:FlexEvent) : void
		{
			startButton.enabled = true;
			titleEntryAnimation.play();
		}
		
		protected function onExitAnimationEnd() : void
		{
			dispatchEvent(new IntroductionViewEvent(IntroductionViewEvent.START, this.difficulty));
		}
	}
}