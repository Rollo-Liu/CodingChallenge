package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	import uk.co.dubit.whackamole.models.moles.Mole;
	import uk.co.dubit.whackamole.views.events.IntroductionViewEvent;

	/**
	 * Contains all the logic for the game itself; controls
	 * the addition of moles, keeps track of the player's
	 * score
	 * 
	 **/
	
	[Event(name="gameOver", type="uk.co.dubit.whackamole.models.events.MoleGameEvent")]
	public class MoleGame extends EventDispatcher
	{
		
		private var _score:int = 0;
		private var _moleHoles:ArrayCollection = new ArrayCollection();
		
		private var gameTimer:Timer = null;
		
		private var gameTimerDelayMax:int = 450;
		private var gameTimerDelayMin:int = 350;
		private var totalMoles:int = 10;
		private var showTimeDelayMax:int = 1200;
		private var showTimeDelayMin:int = 800;
		private var hitBonus:int = 10;
		
		public function MoleGame(difficulty:String = IntroductionViewEvent.DIFFICULTY_MEDIUM)
		{
			this.setDifficulty(difficulty);
			//Set up the game timer; when it fires a new
			//mole is added
			gameTimer = new Timer(this.getRandomIntFromRange(gameTimerDelayMin,gameTimerDelayMax), totalMoles);
			gameTimer.addEventListener(TimerEvent.TIMER, onGameTimer);
			gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onGameTimerComplete);
		}

		[Bindable]
		public function get score():int
		{
			return _score;
		}

		public function set score(value:int):void
		{
			_score = value;
		}
		
		[Bindable]
		public function get moleHoles():ArrayCollection
		{
			return _moleHoles;
		}

		public function set moleHoles(value:ArrayCollection):void
		{
			_moleHoles = value;
		}
		
		public function setDifficulty(difficulty:String) : void
		{
			switch (difficulty)
			{
				case IntroductionViewEvent.DIFFICULTY_EASY:
				{
					gameTimerDelayMax = 550;
					gameTimerDelayMin = 450;
					totalMoles = 10;
					showTimeDelayMax = 1500;
					showTimeDelayMin = 1000;
					hitBonus = 0;
					break;
				}
				case IntroductionViewEvent.DIFFICULTY_MEDIUM:
				{
					gameTimerDelayMax = 450;
					gameTimerDelayMin = 350;
					totalMoles = 10;
					hitBonus = 10;
					showTimeDelayMax = 1200;
					showTimeDelayMin = 800;
					break;
				}
				case IntroductionViewEvent.DIFFICULTY_HARD:
				{
					gameTimerDelayMax = 350;
					gameTimerDelayMin = 250;
					totalMoles = 10;
					hitBonus = 20;
					showTimeDelayMax = 900;
					showTimeDelayMin = 600;
					break;
				}
			}
		}

		public function start() : void
		{
			//There are currently nine MoleHoles; create and
			//add them to the moleHoles ArrayCollection
			for(var i:int = 0; i < 9; i++)
			{
				//A moleHole needs a reference to the game
				//so it can react appropriately to clicks
				var moleHole:MoleHole = new MoleHole(this);
				
				moleHoles.addItem(moleHole);
			}
			
			gameTimer.start();
		}
		
		public function addScore(points:int) : void
		{
			score += points;
		}
		
		public function restart() : void
		{
			score = 0;
			gameTimer.reset();
			gameTimer.start();
		}
			
		private function getFreeMoleHole() : MoleHole
		{
			//Pick a random hole until we find one without
			//an mole already in there
			var moleHole:MoleHole = null;
			
			while(moleHole == null || moleHole.mole)
			{
				moleHole = moleHoles[ Math.floor(Math.random() * moleHoles.length) ];
			}
			
			return moleHole;
		}
		
		private function getRandomIntFromRange(min:int, max:int) : int
		{
			return Math.round(Math.random()*(max - min + 1) + min);
		}
		
		private function onGameTimer(event:TimerEvent) : void
		{
			gameTimer.delay = this.getRandomIntFromRange(gameTimerDelayMin,gameTimerDelayMax);
			//Every time the timer fires, add a new mole
			var moleHole:MoleHole = getFreeMoleHole();
			moleHole.populate(new Mole(hitBonus,this.getRandomIntFromRange(showTimeDelayMin,showTimeDelayMax)));
		}
		
		private function onGameTimerComplete(event:TimerEvent) : void
		{
			dispatchEvent(new MoleGameEvent(MoleGameEvent.GAME_OVER, score));
		}
	}
}