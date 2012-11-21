package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	
	import uk.co.dubit.whackamole.models.events.MoleAchievementEvent;
	
	public class MoleAchievements extends EventDispatcher
	{
		private var moleHits:int = 0;
		private var fireMoleHits:int = 0;
		private var zombieMoleHits:int = 0;
		private var missHits:int = 0;
		
		private var isApprenticeAwarded:Boolean = false;
		private var isMasterAwarded:Boolean = false;
		private var isMoleMassacreAwarded:Boolean = false;
		private var isFiremanAwarded:Boolean = false;
		private var isApocolypticaAwarded:Boolean = false;
		private var isSoftTouchAwarded:Boolean = false;
		
		public function MoleAchievements()
		{
		}
		
		public function reset() : void
		{
			moleHits = 0;
			fireMoleHits = 0;
			zombieMoleHits = 0;
			missHits = 0;
		}
		
		public function addMoleHit() : void
		{
			++moleHits;
			this.update();
		}
		
		public function addFireMoleHits() : void
		{
			++moleHits;
			++fireMoleHits;
			this.update();
		}
		
		public function addZombieMoleHits() : void
		{
			++moleHits;
			++zombieMoleHits;
			this.update();
		}
		
		public function addMissHits() : void
		{
			++missHits;
			this.update();
		}
		
		public function achievementAwarded(achievement:String) : void
		{
			switch (achievement)
			{
				case MoleAchievementEvent.ACHIEVEMENT_APPRENTICE:
				{
					isApprenticeAwarded = true;
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_MASTER:
				{
					isMasterAwarded = true;
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_MOLE_MASSACRE:
				{
					isMoleMassacreAwarded = true;
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_FIREMAN:
				{
					isFiremanAwarded = true;
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_APOCOLYPTICA:
				{
					isApocolypticaAwarded = true;
					break;
				}
				case MoleAchievementEvent.ACHIEVEMENT_SOFT_TOUCH:
				{
					isSoftTouchAwarded = true;
					break;
				}
				default:
					break;
			}
		}
		
		private function update() : void
		{
			if (moleHits >= 15 && !isApprenticeAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_APPRENTICE));
			
			if (moleHits >= 40 && !isMasterAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_MASTER));
			
			if (moleHits >= 55 && !isMoleMassacreAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_MOLE_MASSACRE));
			
			if (fireMoleHits >= 10 && !isFiremanAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_FIREMAN));
			
			if (zombieMoleHits >= 5 && !isApocolypticaAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_APOCOLYPTICA));
			
			if (missHits >= 30 && !isSoftTouchAwarded)
				dispatchEvent(new MoleAchievementEvent(MoleAchievementEvent.ACHIEVEMENT_SOFT_TOUCH));
		}
	}
}