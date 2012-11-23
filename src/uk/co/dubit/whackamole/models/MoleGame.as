package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.dubit.whackamole.models.MoleAchievements;
	import uk.co.dubit.whackamole.models.events.MoleGameEvent;
	import uk.co.dubit.whackamole.models.moles.FireMole;
	import uk.co.dubit.whackamole.models.moles.Mole;
	import uk.co.dubit.whackamole.models.moles.ZombieMole;
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
		private var _gameAchievements:MoleAchievements = null;

		private var gameTimer:Timer = null;
		private var timerComplete:Boolean = false;
		
		private var gameTimerDelayMax:int = 450;
		private var gameTimerDelayMin:int = 350;
		private var totalMoles:int = 10;
		private var showTimeDelayMax:int = 200;
		private var showTimeDelayMin:int = -200;
		private var hitBonus:int = 10;
		
		[Embed(source="/../assets/mole_hit.mp3") ]
		private var moleHit:Class;
		
		[Embed(source="/../assets/mole_dead_1.mp3") ]
		private var moleDead1:Class;
		
		[Embed(source="/../assets/mole_dead_2.mp3") ]
		private var moleDead2:Class;
		
		[Embed(source="/../assets/mole_dead_3.mp3") ]
		private var moleDead3:Class;
		
		[Embed(source="/../assets/mole_dead_4.mp3") ]
		private var moleDead4:Class;
		
		public function MoleGame(acheivement:MoleAchievements, difficulty:String = IntroductionViewEvent.DIFFICULTY_MEDIUM)
		{
			_gameAchievements = acheivement;
			this.setDifficulty(difficulty);
			_gameAchievements.totalMoles = this.totalMoles;
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
					totalMoles = 50;
					showTimeDelayMax = 500;
					showTimeDelayMin = 0;
					hitBonus = 0;
					break;
				}
				case IntroductionViewEvent.DIFFICULTY_MEDIUM:
				{
					gameTimerDelayMax = 450;
					gameTimerDelayMin = 350;
					totalMoles = 60;
					showTimeDelayMax = 200;
					showTimeDelayMin = -200;
					hitBonus = 10;
					break;
				}
				case IntroductionViewEvent.DIFFICULTY_HARD:
				{
					gameTimerDelayMax = 350;
					gameTimerDelayMin = 250;
					totalMoles = 70;
					showTimeDelayMax = -100;
					showTimeDelayMin = -400;
					hitBonus = 20;
					break;
				}
				default:
					break;
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
		
		public function hitMole() : void
		{
			var moleHitSound:Sound = new this.moleHit() as Sound;
			moleHitSound.play();
		}
		
		public function killedMole(mole:Mole) : void
		{
			// add the score
			score += mole.points;
			
			// report to the achievement system
			switch (mole.type)
			{
				case Mole.TYPE_NORMAL:
				{
					_gameAchievements.addMoleHit();
					break;
				}
				case Mole.TYPE_FIRE:
				{
					_gameAchievements.addFireMoleHits();
					break;
				}
				case Mole.TYPE_ZOMBIE:
				{
					_gameAchievements.addZombieMoleHits();
					break;
				}
				default:
					break;
			}
			
			// random choose a sound and play it
			var randomSound:int = this.getRandomIntFromRange(1,4);
			var moleDeadSound:Sound = null;
			switch (randomSound)
			{
				case 1:
				{
					moleDeadSound = new this.moleDead1() as Sound;
					moleDeadSound.play();
					break;
				}
				case 2:
				{
					moleDeadSound = new this.moleDead2() as Sound;
					moleDeadSound.play();
					break;
				}
				case 3:
				{
					moleDeadSound = new this.moleDead3() as Sound;
					moleDeadSound.play();
					break;
				}
				case 4:
				{
					moleDeadSound = new this.moleDead4() as Sound;
					moleDeadSound.play();
					break;
				}
				default:
				{
					moleDeadSound = new this.moleDead1() as Sound;
					moleDeadSound.play();
					break;
				}
			}
		}
		
		public function missedMole() : void
		{
			_gameAchievements.addMissHits();
		}
		
		public function restart() : void
		{
			score = 0;
			timerComplete = false;
			gameTimer.reset();
			gameTimer.start();
		}
		
		public function update() : void
		{
			// check the game is end or not
			if (timerComplete)
			{
				// timer complete + no more moles in holes = game over
				for (var i:int = 0; i < moleHoles.length; ++i)
				{
					var moleHole:MoleHole = moleHoles[i];
					if (moleHole.mole != null)
						return;
				}
				// send the event message of game over
				dispatchEvent(new MoleGameEvent(MoleGameEvent.GAME_OVER, score));
			}
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
			return Math.floor(Math.random()*(max - min + 1) + min);
		}
		
		private function onGameTimer(event:TimerEvent) : void
		{
			// random a delay value and set it as the timer's delay
			// make the timer every time firing in a different (hope so) time
			var randomDelay:int = this.getRandomIntFromRange(gameTimerDelayMin,gameTimerDelayMax);
			// random a show time instead of a fixed show time for moles
			var randomShowTime:int = this.getRandomIntFromRange(showTimeDelayMin,showTimeDelayMax);
			// random a number to decide what type of moles need to be created
			var randomMole:Number = Math.random();
			var mole:Mole = null;
			
			if (randomMole < 0.6)
				mole = new Mole(hitBonus,randomShowTime);
			else if (randomMole > 0.85)
				mole = new ZombieMole(hitBonus,randomShowTime);
			else
				mole = new FireMole(hitBonus,randomShowTime);
			
			gameTimer.delay = randomDelay;
			//Every time the timer fires, add a new mole
			var moleHole:MoleHole = getFreeMoleHole();
			moleHole.populate(mole);
		}
		
		private function onGameTimerComplete(event:TimerEvent) : void
		{
			timerComplete = true;
		}
	}
}