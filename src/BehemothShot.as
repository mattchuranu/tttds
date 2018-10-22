package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class BehemothShot extends Entity
	{
		[Embed(source = '/img/behemothshot2.png')] private const BEHEMOTHSHOT:Class;
		private var alX:int;
		private var alY:int;
		private var plaX:int;
		private var plaY:int;
		private var shotAngle:int;
		private var velocity:int = 3;
		
		public function BehemothShot(_x:Number, _y:Number, _dx:Number, _dy:Number):void
		{
			graphic = new Image(BEHEMOTHSHOT);
			x = _x;
			y = _y;
			layer = 4;
			type = "beshot";
			width = 4;
			height = 4;
			alX = _x - 4;
			alY = _y - 4;
			plaX = _dx;
			plaY = _dy;
		}
		
		override public function update():void
		{
			var dir:Point = new Point(plaX - alX, plaY - alY);
			dir.normalize(velocity);
			
			x += dir.x;
			y += dir.y;
			collision();
			goneTooFarThisTime();
		}
		
		private function collision():void
		{
			var pla:Player = collide("player", x, y) as Player;
			var ai:PlayerAI = collide("playerai", x, y) as PlayerAI;
			var block:Block = collide("block", x, y) as Block;
			var tu:Turret = collide("turret", x, y) as Turret;
			
			if (pla)
			{
				shotAngle = FP.angle(alX, alY, Player.xx, Player.yy);
				(world as Level).add(new Blood(x, y, shotAngle));
				FP.world.remove(this);
			}
			if (ai)
			{
				shotAngle = FP.angle(alX, alY, x, y);
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
			if (distanceToPoint(alX, alY) > 80)
			{
				FP.world.remove(this);
			}
		}
		
	}

}