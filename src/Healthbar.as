package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Healthbar extends Entity
	{
		[Embed(source = '/img/healthbar2.png')] private const HEALTHBAR:Class;
		private var sprHealthbar:Spritemap = new Spritemap(HEALTHBAR, 25, 2);
		
		public function Healthbar() 
		{
			sprHealthbar.add("HP", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25], 1, true);
			graphic = sprHealthbar;
			//x = FP.screen.width / 2 - 25;
			//y = 2;
			x = Player.xx - 5;
			y = Player.yy - 7;
			layer = 0;
			sprHealthbar.frame = 0;
		}
		
		override public function update():void
		{
				x = Player.xx - 5;
				y = Player.yy - 7;
				//x = FP.camera.x  + ((FP.screen.width / 2) - 25);
				//y = FP.camera.y + 2;
				sprHealthbar.frame = Player.health;
		}
	}

}