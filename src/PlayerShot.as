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
	public class PlayerShot extends Entity
	{
		[Embed(source = '/img/playershot2.png')] private const PLAYERSHOT:Class;
		private var sprPlayershot:Spritemap = new Spritemap(PLAYERSHOT, 2, 2);
		private var plaX:int;
		private var plaY:int;
		private var crossX:int = FP.world.mouseX;
		private var crossY:int = FP.world.mouseY;
		private var shotAngle:int;
		private var velocity:int = 4;
		
		public function PlayerShot(_x:Number, _y:Number):void
		{
			//sprPlayershot.add("move", [0, 1, 2, 3], 30, true);
			//graphic = sprPlayershot;
			graphic = new Image(PLAYERSHOT);
			x = _x;
			y = _y;
			layer = 2;
			type = "plashot";
			width = 4;
			height = 4;
			//sprPlayershot.play("move", true);
			plaX = _x;
			plaY = _y;
		}
		
		override public function update():void
		{
			var dir:Point = new Point(crossX - plaX, crossY - plaY);
			dir.normalize(velocity);
			
			x += dir.x;
			y += dir.y;
			collision();
			goneTooFarThisTime();
		}
		
		private function collision():void
		{
			var al:Alien = collide("alien", x, y) as Alien;
			var block:Block = collide("block", x, y) as Block;
			var tu:Turret = collide("turret", x, y) as Turret;
			var be:Behemoth = collide("behemoth", x, y) as Behemoth;
			var mo:Monolith = collide("monolith", x, y) as Monolith;
			var pural:PurpleAlien = collide("puralien", x, y) as PurpleAlien;
			
			if (al || be || mo || pural)
			{
				shotAngle = FP.angle(plaX, plaY, x, y);
				(world as Level).add(new AlienBlood(x, y, shotAngle));
				FP.world.remove(this);
			}
			
			if (al || block || tu || be || mo || x < 0 || y < 0 || x > 636 || y > 476)
			{
				FP.world.remove(this);
			}
		}
		
		private function goneTooFarThisTime():void
		{
			if (distanceToPoint(plaX, plaY) > 120)
			{
				FP.world.remove(this);
			}
		}
	}

}