package uk.co.dubit.whackamole.views
{
	import mx.collections.ArrayCollection;
	import mx.controls.Label;
	import mx.effects.Sequence;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	
	import uk.co.dubit.whackamole.models.MoleAcheivements;
	import uk.co.dubit.whackamole.models.MoleGame;
	import uk.co.dubit.whackamole.models.events.MoleAcheivementEvent;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	
	public class MoleGameViewBase extends Group
	{	
		public var startAnimation:Sequence;
		public var endAnimation:Sequence;
		public var restartAnimation:Sequence;
		public var playAgainButton:Button;
		public var acheivementApprenticeLabel:spark.components.Label;
		public var acheivementMasterLabel:spark.components.Label;
		public var acheivementMoleMassacreLabel:spark.components.Label;
		public var acheivementFiremanLabel:spark.components.Label;
		public var acheivementApocolypticaLabel:spark.components.Label;
		public var acheivementSoftTouchLabel:spark.components.Label;
		
		[Bindable]
		protected var moleHoles:ArrayCollection;
		
		[Bindable]
		protected var _moleGame:MoleGame;
		
		// final score send from mole game event
		[Bindable]
		protected var finalScore:int;
		
		protected var _acheivement:MoleAcheivements;
		
		public function MoleGameViewBase() 
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public function set moleGame(value:MoleGame) : void
		{
			_moleGame = value;
			moleHoles = value.moleHoles;
		}
		
		public function set acheivement(value:MoleAcheivements) : void
		{
			_acheivement = value;
		}
		
		public function get acheivement() : MoleAcheivements
		{
			return _acheivement;
		}
		
		protected function onCreationComplete(event:FlexEvent) : void
		{
			startAnimation.play();
		}
		
		protected function startAnimationEnd() : void
		{
			// add acheivement event listener
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_APPRENTICE, awardAheivement);
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_MASTER, awardAheivement);
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_MOLE_MASSACRE, awardAheivement);
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_FIREMAN, awardAheivement);
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_APOCOLYPTICA, awardAheivement);
			_acheivement.addEventListener(MoleAcheivementEvent.ACHEIVEMENT_SOFT_TOUCH, awardAheivement);
			
			// add gameover event listener
			_moleGame.addEventListener(MoleGameEvent.GAME_OVER, onGameOver);
			_moleGame.start();
		}
		
		protected function onGameOver(event:MoleGameEvent) : void
		{
			finalScore = event.score;
			event.target.removeEventListener(event.type, arguments.callee);
			endAnimation.play();
		}
		
		protected function awardAheivement(event:MoleAcheivementEvent) :  void
		{
			switch (event.type)
			{
				case MoleAcheivementEvent.ACHEIVEMENT_APPRENTICE:
				{
					acheivementApprenticeLabel.setStyle("fontWeight","bold");
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_MASTER:
				{
					acheivementMasterLabel.setStyle("fontWeight","bold");
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_MOLE_MASSACRE:
				{
					acheivementMoleMassacreLabel.setStyle("fontWeight","bold");
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_FIREMAN:
				{
					acheivementFiremanLabel.setStyle("fontWeight","bold");
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_APOCOLYPTICA:
				{
					acheivementApocolypticaLabel.setStyle("fontWeight","bold");
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_SOFT_TOUCH:
				{
					acheivementSoftTouchLabel.setStyle("fontWeight","bold");
					break;
				}
				default:
					break;
			}
			_acheivement.acheivementAwarded(event.type);
			event.target.removeEventListener(event.type, arguments.callee);
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
			_acheivement.reset();
		}
	}
}