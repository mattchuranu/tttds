package  
{
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class DummyAlien 
	{
		[Embed(source = '/img/aliensprite2.png')] private const ALIEN:Class;
		private var sprAlien:Spritemap = new Spritemap(ALIEN, 16, 16);
		
		public function DummyAlien() 
		{
			
		}
		
	}

}