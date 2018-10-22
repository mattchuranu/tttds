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
	public class Behemoth extends Entity
	{
		[Embed(source = '/img/behemoth.png')] private const BEHEMOTH:Class;
		[Embed(source = '/snd/shot3.mp3')] private const SHOT:Class;
		[Embed(source = '/snd/hit1.mp3')] private const HIT:Class;
		private var shot:Sfx = new Sfx(SHOT);
		private var hit:Sfx = new Sfx(HIT);
		private var sprBehemoth:Spritemap = new Spritemap(BEHEMOTH, 28, 32);
		private var shootTimer:int;
		private var movWait:int = 5;
		private var movTimer:int = 3;
		private var velocity:int = 1;
		private var health:int = 25;
		public static var xx:int;
		public static var yy:int;
		
		public function Behemoth(_x:Number, _y:Number):void 
		{
			sprBehemoth.add("idle1", [0], 10, false);
			sprBehemoth.add("idle2", [4], 10, false);
			sprBehemoth.add("left", [0, 1, 2, 3], 10, true);
			sprBehemoth.add("right", [4, 5, 6, 7], 10, true);
			graphic = sprBehemoth;
			x = _x;
			y = _y;
			height = 32;
			width = 32;
			type = "behemoth"
			layer = 3;
			//trace("new Behemoth spawned");
		}
		
		override public function update():void
		{
			if (FP.distance(Player.xx, Player.yy, x, y) > 40)
			{
				
				var xDiff:int = Player.xx - x;
				
				if (xDiff < 0)
				{
					sprBehemoth.play("right", false);
				} else { sprBehemoth.play("left", false); }
				
				var dir:Point = new Point(Player.xx - x, Player.yy - y);
				
				dir.normalize(velocity);
				if (movTimer > 0)
				{
					x += dir.x;
					y += dir.y;
					movTimer -= 1;
				} else {
					if (movWait > 0)
					{
						movWait -= 1;
					} else { movWait = 5; movTimer = 3; }
				}
			} else {
				if (Player.xx > x)
				{
					sprBehemoth.play("idle1", true);
				} else { sprBehemoth.play("idle2", true); } 
				}
			shoot();
			collision();
			updatePublic();
			checkHealth();
		}
		
		public function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		private function shoot():void
		{
			if (FP.distance(Player.xx, Player.yy, x, y) < 80)
			{
				if (shootTimer == 0)
				{
					(world as Level).add(new BehemothShot(x + 16, y + 16, Player.xx, Player.yy));
					(world as Level).add(new BehemothShot(x + 16, y + 16, Player.xx + 4, Player.yy + 8));
					(world as Level).add(new BehemothShot(x + 16, y + 16, Player.xx - 4, Player.yy - 8));
					shot.play();
					shootTimer = 80;
				} else { shootTimer -= 1 }
			} else { }
		}
		
		private function collision():void
		{
			var plashot:PlayerShot = collide("plashot", x, y) as PlayerShot;
			var tushot:TurretShot = collide("tushot", x, y) as TurretShot;
			
			if (plashot || tushot)
			{
				//(world as Level).add(new HitRect(x, y, width, height));
				hit.play();
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
			var rand:int = randomRange(5, 0);
			
			if (health == 0)
			{
				if (rand == 0 || rand == 1)
				{
					(world as Level).add(new HealthPack(x, y));
				}
				FP.world.remove(this);
				Level.score += 15;
				(world as Level).behemothCounter += 1;
				(world as Level).activeEnemies -= 1;
			} else { }
		}
	}

}