package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Blood extends Entity
	{
		[Embed(source = '/img/bloodsplatter.png')] private const BLOODSPR:Class;
		private var sprBlood:Spritemap = new Spritemap(BLOODSPR, 12, 8);
		
		public function Blood(_x:Number, _y:Number, _a:Number):void 
		{
			sprBlood.add("anim", [0, 1, 2, 3, 4, 5, 6, 7], 10, true);
			graphic = sprBlood;
			sprBlood.angle = _a - 180;
			x = _x;
			y = _y;
			width = 12;
			height = 12;
			type = "blood";
			layer = 0;
			sprBlood.play("anim", false);
		}
		
		override public function update():void
		{
			if (sprBlood.frame == 7)
			{
				FP.world.remove(this);
			}
		}
	}

}