package uk.co.dubit.whackamole.models
{
	import flash.events.EventDispatcher;
	
	import uk.co.dubit.whackamole.models.events.MoleAcheivementEvent;
	
	public class MoleAcheivements extends EventDispatcher
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
		
		public function MoleAcheivements()
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
		
		public function acheivementAwarded(acheivement:String) : void
		{
			switch (acheivement)
			{
				case MoleAcheivementEvent.ACHEIVEMENT_APPRENTICE:
				{
					isApprenticeAwarded = true;
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_MASTER:
				{
					isMasterAwarded = true;
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_MOLE_MASSACRE:
				{
					isMoleMassacreAwarded = true;
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_FIREMAN:
				{
					isFiremanAwarded = true;
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_APOCOLYPTICA:
				{
					isApocolypticaAwarded = true;
					break;
				}
				case MoleAcheivementEvent.ACHEIVEMENT_SOFT_TOUCH:
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
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_APPRENTICE));
			
			if (moleHits >= 40 && !isMasterAwarded)
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_MASTER));
			
			if (moleHits >= 55 && !isMoleMassacreAwarded)
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_MOLE_MASSACRE));
			
			if (fireMoleHits >= 10 && !isFiremanAwarded)
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_FIREMAN));
			
			if (zombieMoleHits >= 5 && !isApocolypticaAwarded)
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_APOCOLYPTICA));
			
			if (missHits >= 30 && !isSoftTouchAwarded)
				dispatchEvent(new MoleAcheivementEvent(MoleAcheivementEvent.ACHEIVEMENT_SOFT_TOUCH));
		}
	}
}