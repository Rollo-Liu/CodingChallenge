package uk.co.dubit.whackamole.views
{
	import spark.components.supportClasses.ItemRenderer;
	
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
		
		override public function set data(value:Object) : void
		{
			moleHole = value as MoleHole;
		}
		
		protected function onClick() : void
		{
			moleHole.hit();
		}
	}
}