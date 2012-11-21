package uk.co.dubit.whackamole.models.moles
{
	/**
	 * The only type of mole at the moment;
	 * one hit kills it
	 * 
	 **/
	public class Mole
	{
		public static const TYPE_NORMAL:String = "typeNormal";
		public static const TYPE_FIRE:String = "typeFire";
		public static const TYPE_ZOMBIE:String = "typeZombie";
		
		protected var _points:int = 50;
		protected var _showtime:int = 1000;
		protected var _dead:Boolean = false;
		protected var _hitPoints:int = 1;
		protected var _type:String = TYPE_NORMAL;

		public function Mole(bonus:int = 10, delay:int = 0)
		{
			_points += bonus;
			_showtime += delay;
		}
		
		public function get points():int
		{
			return _points;
		}

		public function set points(value:int):void
		{
			_points = value;
		}
		
		public function get showtime():int
		{
			return _showtime;
		}

		public function set showtime(value:int):void
		{
			_showtime = value;
		}

		[Bindable]
		public function get dead():Boolean
		{
			return _dead;
		}

		public function set dead(value:Boolean):void
		{
			_dead = value;
		}
		
		[Bindable]
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function hit() : void
		{
			if (--_hitPoints <= 0)
				dead = true;
		}
	}
}