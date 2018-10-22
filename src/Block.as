package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Block extends Entity
	{
		[Embed(source = '/img/testblock2.png')] private const BLOCK:Class;
		private var health:int = 5;
		
		public function Block(_x:Number, _y:Number):void 
		{
			graphic = new Image(BLOCK);
			x = _x;
			y = _y;
			width = 16;
			height = 16;
			layer = 8;
			type = "block";
		}
		
		override public function update():void
		{
			collision();
			healthCheck();
		}
		
		private function collision():void
		{
			var alshot:AlienShot = collide("alshot", x, y) as AlienShot;
			var beshot:BehemothShot = collide("beshot", x, y) as BehemothShot;
			
			if (alshot || beshot)
			{
				health -= 1;
			}
		}
		
		private function healthCheck():void
		{
			if (health == 0)
			{
				FP.world.remove(this);
			} else { }
		}
	}

}