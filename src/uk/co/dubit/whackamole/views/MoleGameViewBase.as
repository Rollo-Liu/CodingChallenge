package uk.co.dubit.whackamole.views
{
	import mx.collections.ArrayCollection;
	import mx.controls.Label;
	import mx.effects.Sequence;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Label;
	
	import uk.co.dubit.whackamole.models.MoleAchievements;
	import uk.co.dubit.whackamole.models.MoleGame;
	import uk.co.dubit.whackamole.models.events.MoleAchievementEvent;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	import uk.co.dubit.whackamole.views.events.MoleGameViewEvent;
	
	[Event(name="moleGameContinue", type="uk.co.dubit.whackamole.views.events.MoleGameViewEvent")]
	public class MoleGameViewBase extends Group
	{	
		public var startAnimation:Sequence;
		public var endAnimation:Sequence;
		public var restartAnimation:Sequence;
		public var achievementAwardedAnimation:Sequence;
		public var playAgainButton:Button;
		public var continueButton:Button;
		public var achievementApprenticeLabel:spark.components.Label;
		public var achievementMasterLabel:spark.components.Label;
		public var achievementMoleMassacreLabel:spark.components.Label;
		public var achievementFiremanLabel:spark.components.Label;
		public var achievementApocolypticaLabel:spark.components.Label;
		public var achievementSoftTouchLabel:spark.components.Label;
		public var achievementPerfectLabel:spark.components.Label;
		
		[Bindable]
		protected var moleHoles:ArrayCollection;
		
		[Bindable]
		protected var _moleGame:MoleGame;
		
		// final score send from mole game event
		[Bindable]
		protected var finalScore:int;
		
		protected var _achievement:MoleAchievements;
		
		public function MoleGameViewBase() 
		{
			addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		public function set moleGame(value:MoleGame) : void
		{
			_moleGame = value;
			moleHoles = value.moleHoles;
		}
		
		public function set achievement(value:MoleAchievements) : void
		{
			_achievement = value;
		}
		
		public function get achievement() : MoleAchievements
		{
			return _achievement;
		}
		
		protected function onCreationComplete(event:FlexEvent) : void
		{
			startAnimation.play();
		}
		
		protected function startAnimationEnd() : void
		{
			// add achievement event listener
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_APPRENTICE, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_MASTER, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_MOLE_MASSACRE, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_FIREMAN, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_APOCOLYPTICA, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_SOFT_TOUCH, awardAheivement);
			_achievement.addEventListener(MoleAchievementEvent.ACHIEVEMENT_PERFECT, awardAheivement);
			
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
		
		protected function awardAheivement(event:MoleAchievementEvent) :  void
		{
			switch (event.type)
			{
				case MoleAchievementEvent.ACHIEVEMENT_APPRENTICE:
				{
					achievementApprenticeLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementApprenticeLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_MASTER:
				{
					achievementMasterLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementMasterLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_MOLE_MASSACRE:
				{
					achievementMoleMassacreLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementMoleMassacreLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_FIREMAN:
				{
					achievementFiremanLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementFiremanLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_APOCOLYPTICA:
				{
					achievementApocolypticaLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementApocolypticaLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_SOFT_TOUCH:
				{
					achievementSoftTouchLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementSoftTouchLabel]);
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_PERFECT:
				{
					achievementSoftTouchLabel.setStyle("fontWeight","bold");
					achievementAwardedAnimation.play([achievementPerfectLabel]);
					break;
				}
				default:
					break;
			}
			_achievement.achievementAwarded(event.type);
			event.target.removeEventListener(event.type, arguments.callee);
		}
		
		protected function endAnimationEnd() : void
		{
			playAgainButton.visible = true;
			continueButton.visible = true;
		}
		
		protected function onPlayAgainButtonClick() : void
		{
			playAgainButton.visible = false;
			continueButton.visible = false;
			restartAnimation.play();
		}
		
		protected function onContinueButtonClick() : void
		{
			dispatchEvent(new MoleGameViewEvent(MoleGameViewEvent.CONTINUE));
		}
		
		protected function restartAnimationEnd() : void
		{
			_moleGame.addEventListener(MoleGameEvent.GAME_OVER, onGameOver);
			_moleGame.restart();
			_achievement.reset();
		}
	}
}