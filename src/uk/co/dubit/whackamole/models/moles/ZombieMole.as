package uk.co.dubit.whackamole.models.moles
{
	import uk.co.dubit.whackamole.models.moles.Mole;
	
	public class ZombieMole extends Mole
	{
		public function ZombieMole(bonus:int = 10, delay:int = 0)
		{
			this._points = 400 + bonus;
			this._showtime = 1200 + delay;
			this._dead = false;
			this._hitPoints = 3;
			this._type = Mole.TYPE_ZOMBIE;
		}
	}
}