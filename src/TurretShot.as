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
	public class TurretShot extends Entity
	{
		[Embed(source = '/img/TurretShot2.png')] private const TURRETSHOT:Class;
		private var tuX:int;
		private var tuY:int;
		private var alX:int;
		private var alY:int;
		private var shotAngle:int;
		private var velocity:int = 3;
		
		public function TurretShot(_x:Number, _y:Number, _dx:Number, _dy:Number):void
		{
			graphic = new Image(TURRETSHOT);
			x = _x;
			y = _y;
			layer = 2;
			type = "tushot";
			tuX = _x - 4;
			tuY = _y - 4;
			alX = _dx;
			alY = _dy;
		}
		
		override public function update():void
		{
			var dir:Point = new Point(alX - tuX, alY - tuY);
			dir.normalize(velocity);
			
			x += dir.x;
			y += dir.y;
			collision();
			goneTooFarThisTime();
		}
		
		private function collision():void
		{
			var al:Alien = collide("alien", x, y) as Alien;
			var be:Behemoth = collide("behemoth", x, y) as Behemoth;
			var mo:Monolith = collide("monolith", x, y) as Monolith;
			var pural:PurpleAlien = collide("puralien", x, y) as PurpleAlien;
			var block:Block = collide("block", x, y) as Block;
			
			if (al || be || mo || pural)
			{
				shotAngle = FP.angle(x, y, tuX, tuY);
				(world as Level).add(new AlienBlood(x, y, shotAngle));
				FP.world.remove(this);
			}
			
			if (block || x < 0 || y < 0 || x > 636 || y > 476)
			{
				FP.world.remove(this);
			}
		}
		
		private function goneTooFarThisTime():void
		{
			if (distanceToPoint(alX, alY) > 120)
			{
				FP.world.remove(this);
			}
		}
		
	}

}