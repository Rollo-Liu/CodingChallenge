package uk.co.dubit.whackamole.models.events
{
	import flash.events.Event;
	
	public class MoleAchievementEvent extends Event
	{
		public static const ACHIEVEMENT_APPRENTICE:String = "achievementApprentice";
		public static const ACHIEVEMENT_MASTER:String = "achievementMaster";
		public static const ACHIEVEMENT_MOLE_MASSACRE:String = "achievementMoleMassacre";
		public static const ACHIEVEMENT_FIREMAN:String = "achievementFireman";
		public static const ACHIEVEMENT_APOCOLYPTICA:String = "achievementApocolyptica";
		public static const ACHIEVEMENT_SOFT_TOUCH:String = "achievementSoftTouch";
		public static const ACHIEVEMENT_PERFECT:String = "achievementPerfect";
		
		public function MoleAchievementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}