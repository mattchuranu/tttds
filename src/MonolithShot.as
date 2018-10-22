package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class MonolithShot extends Entity
	{
		[Embed(source = '/img/monolithshot.png')] private const MONOLITHSHOT:Class;
		private var moX:int;
		private var moY:int;
		private var plaX:int;
		private var plaY:int;
		private var shotAngle:int;
		private var velocity:int = 2;
		
		public function MonolithShot(_x:Number, _y:Number, _dx:Number, _dy:Number):void 
		{
			graphic = new Image(MONOLITHSHOT);
			x = _x;
			y = _y;
			height = 8;
			width = 8;
			layer = 4;
			type = "moshot";
			moX = _x;
			moY = _y;
			plaX = _dx;
			plaY = _dy;
		}
		
		override public function update():void
		{
			var dir:Point = new Point(plaX - moX, plaY - moY);
			dir.normalize(velocity);
			
			x += dir.x;
			y += dir.y;
			collision();
			goneTooFarThisTime();
		}
		
		private function collision():void
		{
			var pla:Player = collide("player", x, y) as Player;
			var block:Block = collide("block", x, y) as Block;
			var tu:Turret = collide("turret", x, y) as Turret;
			
			if (pla)
			{
				shotAngle = FP.angle(moX, moY, Player.xx, Player.yy);
				(world as Level).add(new Blood(x, y, shotAngle));
				FP.world.remove(this);
			}
			
			if (block || tu || x < 0 || y < 0 || x > 636 || y > 476)
			{
				FP.world.remove(this);
			}
		}
		
		private function goneTooFarThisTime():void
		{
			if (distanceToPoint(moX, moY) > 150)
			{
				FP.world.remove(this);
			}
		}
	}

}