package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Crosshair extends Entity
	{
		[Embed(source = '/img/crosshair2.png')] private const CROSSHAIR:Class;
		public static var xx:int;
		public static var yy:int;
		
		public function Crosshair() 
		{
			graphic = new Image(CROSSHAIR);
			x = Player.xx;
			y = Player.yy;
			layer = 0;
		}
		
		override public function update():void
		{
			updatePos();
			//updatePublic();
		}
		
		private function updatePos():void
		{
			xx = x;
			yy = y;
			x = FP.world.mouseX - 5;
			y = FP.world.mouseY - 5;
		}
	}

}