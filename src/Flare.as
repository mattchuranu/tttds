package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Flare extends Entity
	{
		[Embed(source = '/img/Flare.png')] private const FLARE:Class;
		private var xx:int;
		
		public function Flare() 
		{
			graphic = new Image(FLARE);
			x = FP.camera.x - 20;
			y = FP.camera.y;
			
			xx = x;
		}
		
		override public function update():void
		{
			y = FP.camera.y;
			x += 4;
			
			if (x > xx + 180)
			{
				FP.world.remove(this);
			}
		}
	}

}