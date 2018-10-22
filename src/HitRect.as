package  
{
	import net.flashpunk.Entity;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class HitRect extends Entity
	{
		private var hitTimer:int = 1;
		private var hitRect:Rectangle = new Rectangle(x, y, width, height);
		
		public function HitRect(_x:Number, _y:Number, _w:Number, _h:Number):void 
		{
			x = _x;
			y = _y;
			width = _w;
			height = _h;
			graphic = hitRect;
			hitRect.alpha = 0.5;
		}
		
		override public function update():void
		{
			if (hitTimer == 0)
			{
				FP.world.remove(this);
			} else { hitTimer -= 1 }
		}
		
	}

}