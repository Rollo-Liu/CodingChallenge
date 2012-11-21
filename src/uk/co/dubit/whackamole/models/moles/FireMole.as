package uk.co.dubit.whackamole.models.moles
{
	import uk.co.dubit.whackamole.models.moles.Mole;

	public class FireMole extends Mole
	{
		public function FireMole(bonus:int = 10, delay:int = 0)
		{
			this._points = 100 + bonus;
			this._showtime = 1800 + delay;
			this._dead = false;
			this._hitPoints = 2;
			this._type = Mole.TYPE_FIRE;
		}
	}
}