package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class EndBackground extends Entity
	{
		[Embed(source = '/img/bgend.png')] private const ENDBG:Class;
		
		public function EndBackground() 
		{
			graphic = new Image(ENDBG);
			x = FP.camera.x;
			y = FP.camera.y;
		}
		
	}

}