package uk.co.dubit.whackamole.views.events
{
	import flash.events.Event;
	
	public class MoleGameViewEvent extends Event
	{
		public static const CONTINUE:String = "moleGameContinue";
		
		public function MoleGameViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}