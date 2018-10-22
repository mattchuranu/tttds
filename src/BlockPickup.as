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
	public class BlockPickup extends Entity
	{
		[Embed(source = '/img/testblockup2.png')] private const BLOCKPICKUP:Class;
		
		public function BlockPickup(_x:Number, _y:Number):void 
		{
			graphic = new Image(BLOCKPICKUP);
			x = _x;
			y = _y;
			width = 16;
			height = 16;
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