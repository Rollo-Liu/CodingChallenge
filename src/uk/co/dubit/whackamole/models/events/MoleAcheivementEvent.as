package uk.co.dubit.whackamole.models.events
{
	import flash.events.Event;
	
	public class MoleAcheivementEvent extends Event
	{
		public static const ACHEIVEMENT_APPRENTICE:String = "acheivementApprentice";
		public static const ACHEIVEMENT_MASTER:String = "acheivementMaster";
		public static const ACHEIVEMENT_MOLE_MASSACRE:String = "acheivementMoleMassacre";
		public static const ACHEIVEMENT_FIREMAN:String = "acheivementFireman";
		public static const ACHEIVEMENT_APOCOLYPTICA:String = "acheivementApocolyptica";
		public static const ACHEIVEMENT_SOFT_TOUCH:String = "acheivementSoftTouch";
		
		public function MoleAcheivementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}