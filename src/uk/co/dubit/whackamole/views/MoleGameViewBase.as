package uk.co.dubit.whackamole.views
{
	import mx.collections.ArrayCollection;
	import mx.effects.Sequence;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	
	import uk.co.dubit.whackamole.models.MoleGame;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	
	public class MoleGameViewBase extends Group
	{	
		public var startAnimation:Sequence;
		public var endAnimation:Sequence;
		public var restartAnimation:Sequence;
		public var playAgainButton:Button;
		
		[Bindable]
		protected var moleHoles:ArrayCollection;
		
		[Bindable]
		protected var _moleGame:MoleGame;
		
		// final score send from mole game event
		[Bindable]
		protected var finalScore:int;
		
		public function MoleGameViewBase() 
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public function set moleGame(value:MoleGame) : void
		{
			_moleGame = value;
			moleHoles = value.moleHoles;
		}
		
		protected function onCreationComplete(event:FlexEvent) : void
		{
			startAnimation.play();
		}
		
		protected function startAnimationEnd() : void
		{
			_moleGame.addEventListener(MoleGameEvent.GAME_OVER, onGameOver);
			_moleGame.start();
		}
		
		protected function onGameOver(event:MoleGameEvent) : void
		{
			finalScore = event.score;			
			event.target.removeEventListener(event.type, arguments.callee);
			endAnimation.play();
		}
		
		protected function endAnimationEnd() : void
		{
			playAgainButton.visible = true;
		}
		
		protected function onPlayAgainButtonClick() : void
		{
			playAgainButton.visible = false;
			restartAnimation.play();
		}
		
		protected function restartAnimationEnd() : void
		{
			_moleGame.addEventListener(MoleGameEvent.GAME_OVER, onGameOver);
			_moleGame.restart();
		}
	}
}