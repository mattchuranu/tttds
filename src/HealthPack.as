package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class HealthPack extends Entity
	{
		[Embed(source = '/img/healthpack2.png')] private const HEALTHPACK:Class;
		
		public function HealthPack(_x:Number, _y:Number):void 
		{
			graphic = new Image(HEALTHPACK);
			x = _x;
			y = _y;
			width = 8;
			height = 8;
			layer = 8;
			type = "pickup";
		}
		
		override public function update():void
		{
			collision();
		}
		
		private function collision():void
		{
			var pla:Player = collide("player", x, y) as Player;
			
			if (pla)
			{
				FP.world.remove(this);
			}
		}
	}

}