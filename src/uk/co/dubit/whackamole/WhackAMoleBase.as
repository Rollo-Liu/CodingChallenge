package uk.co.dubit.whackamole
{
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	import spark.components.Group;
	
	import uk.co.dubit.whackamole.models.MoleAchievements;
	import uk.co.dubit.whackamole.models.MoleGame;
	import uk.co.dubit.whackamole.views.IntroductionView;
	import uk.co.dubit.whackamole.views.MoleGameView;
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;
	import uk.co.dubit.whackamole.views.events.MoleGameViewEvent;

	/**
	 * A small whack-a-mole game based around MVC principles
	 */
	public class WhackAMoleBase extends Application
	{
		public var viewContainer:Group;
				
		public function WhackAMoleBase() : void
		{
			super();
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public function loadIntroduction() : void
		{
			var introductionView:IntroductionView = new IntroductionView();
			introductionView.addEventListener(IntroductionViewEvent.START, onIntroductionViewStart);
			
			loadView(introductionView);
		}
		
		protected function onIntroductionViewStart(event:IntroductionViewEvent) : void
		{
			var difficulty:String = event.difficulty;
			
			event.target.removeEventListener(event.type, arguments.callee);
			
			loadMainGame(difficulty);
		}
		
		public function loadMainGame(difficulty:String) : void
		{
			// create the game view
			var moleGameView:MoleGameView = new MoleGameView();
			
			// create the acheivement system
			moleGameView.achievement = new MoleAchievements();
			
			// create the game
			moleGameView.moleGame = new MoleGame(moleGameView.achievement, difficulty);
			
			// add a listener for back to the introduction view
			moleGameView.addEventListener(MoleGameViewEvent.CONTINUE, onMoleGameViewContinue);
			
			
			loadView(moleGameView);
		}
		
		protected function onMoleGameViewContinue(event:MoleGameViewEvent) : void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			loadIntroduction()
		}
		
		private function loadView(view:Group) : void
		{
			//Clear any previous views in the container and add
			viewContainer.removeAllElements();
			viewContainer.addElement(view);
		}
		
		private function onCreationComplete(event:FlexEvent) : void
		{
			//When the application is first created, we want to show the introductory view 
			loadIntroduction();
		}
		
	}
}