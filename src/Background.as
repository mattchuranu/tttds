package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Background extends Entity
	{
		[Embed(source = '/img/background22.png')] private const BACKGROUND:Class;
		
		public function Background() 
		{
			graphic = new Image(BACKGROUND);
			x = 0;
			y = 0;
			layer = 8;
		}
		
	}

}