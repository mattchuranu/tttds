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
	public class Monolith extends Entity
	{
		[Embed(source = '/img/monolith2.png')] private const MONOLITH:Class;
		[Embed(source = '/snd/fireball.mp3')] private const SHOT:Class;
		[Embed(source = '/snd/hit1.mp3')] private const HIT:Class;
		private var shot:Sfx = new Sfx(SHOT);
		private var hit:Sfx = new Sfx(HIT);
		private var health:int = 50;
		private var shootTimer:int = 0;
		
		public function Monolith(_x:Number, _y:Number):void
		{
			graphic = new Image(MONOLITH);
			x = _x;
			y = _y;
			width = 64;
			height = 50;
			type = "monolith";
			layer = 3;
		}
		
		override public function update():void
		{
			shoot();
			collision();
			checkHealth();
		}
		
		private function shoot():void
		{
			if (distanceToPoint(Player.xx, Player.yy, true) < 100)
			{
				if (shootTimer == 0)
				{
					(world as Level).add(new MonolithShot(x, y, Player.xx, Player.yy));
					shot.play();
					shootTimer = 120;
				} else { shootTimer -= 1; }
			} else {}
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
		
		private function checkHealth():void
		{
			if (health == 0)
			{
				FP.world.remove(this)
			} else { }
		}
	}

}