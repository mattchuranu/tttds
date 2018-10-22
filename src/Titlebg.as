package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Titlebg extends Entity
	{
		[Embed(source = '/img/titleWIP.png')] private const TITLEBG:Class;
		
		public function Titlebg() 
		{
			graphic = new Image(TITLEBG);
			x = 0;
			y = 0;
		}
		
	}

}