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
	public class PurpleAlien extends Entity
	{
		
		[Embed(source = '/img/purplealien2.png')] private const PURPLEALIEN:Class;
		private var sprAlien:Spritemap = new Spritemap(PURPLEALIEN, 16, 16);
		private var shootTimer:int;
		private var velocity:int = 2;
		private var health:int = 3;
		private var lastx:int;
		private var lasty:int;
		public static var xx:int;
		public static var yy:int;
		
		public function PurpleAlien(_x:Number, _y:Number):void
		{
			sprAlien.add("idle1", [0], 10, false);
			sprAlien.add("idle2", [4], 10, false);
			sprAlien.add("left", [0, 1, 2, 3], 10, true);
			sprAlien.add("right", [4, 5, 6, 7], 10, true);
			graphic = sprAlien;
			x = _x;
			y = _y;
			height = 16;
			width = 16;
			type = "puralien";
			layer = 3;
		}
		
		override public function update():void
		{
			move();
			collision();
			updatePublic();
			checkHealth();
		}
		
		public function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		private function move():void
		{
			if (FP.distance(Player.xx, Player.yy, x, y) > 1)
			{
				var xDiff:int = Player.xx - x;
				
				if (xDiff < 0)
				{
					sprAlien.play("right", false);
				} else { sprAlien.play("left", false); }
				
				var dir:Point = new Point(Player.xx - x, Player.yy - y);
				dir.normalize(velocity);
				
				var block:Block = collide("block", x, y) as Block;
				
				lastx = x;
				x += dir.x;
				if (block)
				{
					x = lastx;
				}
				
				lasty = y;
				y += dir.y;
				if (block)
				{
					y = lasty;
				}
			} else { 
				if (Player.xx + 4 < x < Player.xx + 8 || Player.yy + 4 < y < Player.yy + 8)
				{
					sprAlien.play("idle1", true);
				} else { sprAlien.play("idle2", true); }
			}
		}
		
		private function collision():void
		{
			var plashot:PlayerShot = collide("plashot", x, y) as PlayerShot;
			var tushot:TurretShot = collide("tushot", x, y) as TurretShot;
			
			if (plashot || tushot)
			{
				//(world as Level).add(new HitRect(x, y, width, height));
				health -= 1;
			}
		}
		
		private function updatePublic():void
		{
			xx = x;
			yy = y;
		}
		
		private function checkHealth():void
		{
			var rand:int = randomRange(20, 0);
			
			if (health == 0)
			{
				if (rand == 1 || rand == 2)
				{
					(world as Level).add(new BlockPickup(x, y));
				}
				if (rand == 0)
				{
					(world as Level).add(new TurretPickup(x, y));
				}
				FP.world.remove(this);
				(world as Level).alienCounter += 1;
				(world as Level).activeEnemies -= 1;
				Level.score += 5;
			} else { }
		}
		
	}

}