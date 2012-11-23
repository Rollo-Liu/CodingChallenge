package uk.co.dubit.whackamole.views
{
	import flash.events.Event;
	
	import mx.effects.Parallel;
	
	import spark.components.supportClasses.ItemRenderer;
	import spark.primitives.BitmapImage;
	
	import uk.co.dubit.whackamole.models.MoleHole;
	import uk.co.dubit.whackamole.models.moles.Mole;

	/**
	 * This item renderer is effectively the view for the MoleHole model
	 * 
	 **/
	public class MoleHoleItemRendererBase extends ItemRenderer
	{
		[Bindable]
		protected var moleHole:MoleHole;
		
		// animations
		public var moleHitAnimation:Parallel;
		public var moleDeathAnimation:Parallel;
		
		// images
		[Bindable]
		public var moleSkull:BitmapImage;
		public var moleNormalIdle:BitmapImage;
		public var moleNormalDie:BitmapImage;
		public var moleFireIdle:BitmapImage;
		public var moleFireHurt:BitmapImage;
		public var moleFireDie:BitmapImage;
		public var moleZombieIdle:BitmapImage;
		public var moleZombieHurt1:BitmapImage;
		public var moleZombieHurt2:BitmapImage;
		public var moleZombieDie:BitmapImage;
		
		public function MoleHoleItemRendererBase()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		override public function set data(value:Object) : void
		{
			moleHole = value as MoleHole;
		}
		
		protected function onClick() : void
		{
			var mole:Mole = moleHole.mole;
			
			// the player successfully hit
			if (moleHole.hit())
			{
				// play hit animation
				moleHitAnimation.play();
				// if mole dead, play death animation
				if (mole.dead)
				{
					switch (mole.type)
					{
						case Mole.TYPE_NORMAL:
							moleDeathAnimation.play([moleNormalDie]);
							break;
						case Mole.TYPE_FIRE:
							moleDeathAnimation.play([moleFireDie]);
							break;
						case Mole.TYPE_ZOMBIE:
							moleDeathAnimation.play([moleZombieDie]);
							break;
						default:
							break;
						
					}
				}
			}
		}
		
		protected function update(event:Event) : void
		{
			// clear everything if no moles in the hole
			if (moleHole.mole == null)
			{
				moleNormalDie.visible = false;
				moleNormalIdle.visible = false;
				moleFireDie.visible = false;
				moleFireHurt.visible = false;
				moleFireIdle.visible = false;
				moleZombieDie.visible = false;
				moleZombieHurt1.visible = false;
				moleZombieHurt2.visible = false;
				moleZombieIdle.visible = false;
				
				// also hide the skull
				moleSkull.visible = false;
				
				// reset the position y of the images
				// because those value might be changed by the death animation
				moleNormalDie.y = 0;
				moleFireDie.y = 0;
				moleZombieDie.y = 0;
			}
			else
			{
				// update images for the current situation
				var mole:Mole = moleHole.mole;
				
				switch (mole.type)
				{
					case Mole.TYPE_NORMAL:
					{
						if (mole.dead)
						{
							moleNormalDie.visible = true;
							moleNormalIdle.visible = false;
						}
						else // idle
						{
							moleNormalDie.visible = false;
							moleNormalIdle.visible = true;
						}
						break;
					}
					case Mole.TYPE_FIRE:
					{
						if (mole.dead)
						{
							moleFireDie.visible = true;
							moleFireHurt.visible = false;
							moleFireIdle.visible = false;
						}
						else if (mole.hitPoints == 1)
						{
							moleFireDie.visible = false;
							moleFireHurt.visible = true;
							moleFireIdle.visible = false;
						}
						else // idle
						{
							moleFireDie.visible = false;
							moleFireHurt.visible = false;
							moleFireIdle.visible = true;
						}
						break;
					}
					case Mole.TYPE_ZOMBIE:
					{
						if (mole.dead)
						{
							moleZombieDie.visible = true;
							moleZombieHurt2.visible = false;
							moleZombieHurt1.visible = false;
							moleZombieIdle.visible = false;
						}
						else if (mole.hitPoints == 2)
						{
							moleZombieDie.visible = false;
							moleZombieHurt1.visible = true;
							moleZombieHurt2.visible = false;
							moleZombieIdle.visible = false;
						}
						else if (mole.hitPoints == 1)
						{
							moleZombieDie.visible = false;
							moleZombieHurt1.visible = false;
							moleZombieHurt2.visible = true;
							moleZombieIdle.visible = false;
						}
						else // idle
						{
							moleZombieDie.visible = false;
							moleZombieHurt2.visible = false;
							moleZombieHurt1.visible = false;
							moleZombieIdle.visible = true;
						}
						break;
					}
					default:
						break;
				}
			}
		}
	}
}