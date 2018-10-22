package  
{
	import flash.geom.Point;
	import net.flashpunk.World;
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
	public class Alien extends Entity
	{
		[Embed(source = '/img/aliensprite2.png')] private const ALIEN:Class;
		[Embed(source = '/snd/shot2.mp3')] private const SHOT:Class;
		[Embed(source = '/snd/hit1.mp3')] private const HIT:Class;
		private var shot:Sfx = new Sfx(SHOT);
		private var hit:Sfx = new Sfx(HIT);
		private var sprAlien:Spritemap = new Spritemap(ALIEN, 16, 16);
		private var shootTimer:int;
		private var velocity:int = 1;
		private var health:int = 3;
		private var lastx:int;
		private var lasty:int;
		public static var xx:int;
		public static var yy:int;
		private var nearest:int;
		
		public function Alien(_x:Number, _y:Number):void
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
			type = "alien"
			layer = 3;
		}
		
		override public function update():void
		{
			move();
			//shoot();
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
			var nearestpla:Entity = (world as Level).nearestToEntity("player", this, true);
			var nearesttu:Entity = (world as Level).nearestToEntity("turret", this, true);
			var nearestai:Entity = (world as Level).nearestToEntity("playerai", this, true);
			var xDiff:int;
			var dir:Point;
			
			if (nearestpla == null && nearestai == null && nearesttu == null)
			{
				
			}
			
			else if (nearestai == null && nearesttu == null)
			{
				if (FP.distance(nearestpla.x, nearestpla.y, x, y) > 40)
				{
					xDiff = nearestpla.x - x;
					nearest = 0;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					dir = new Point(nearestpla.x - x, nearestpla.y - y);
					dir.normalize(velocity);
					lastx = x;
					x += dir.x;
					lasty = y;
					y += dir.y;
					
				} else { 
					if (nearestpla.x > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
				
				if (FP.distance(nearestpla.x, nearestpla.y, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, nearestpla.x, nearestpla.y));
						shot.play();
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }
			}
			
			else if (nearestpla == null && nearesttu == null)
			{
				if (FP.distance(nearestai.x, nearestai.y, x, y) > 40)
				{
					xDiff = nearestai.x - x;
					nearest = 1;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					dir = new Point(nearestai.x - x, nearestai.y - y);
					dir.normalize(velocity);
					lastx = x;
					x += dir.x;
					lasty = y;
					y += dir.y;
					
				} else { 
					if (nearestai.x > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
				
				if (FP.distance(nearestai.x, nearestai.y, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, nearestai.x, nearestai.y));
						shot.play();
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }	
			}
			
			else if (nearestai == null && nearestpla == null)
			{
				if (FP.distance(nearesttu.x, nearesttu.y, x, y) > 40)
				{
					xDiff = nearesttu.x - x;
					nearest = 2;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					dir = new Point(nearesttu.x - x, nearesttu.y - y);
					dir.normalize(velocity);
					lastx = x;
					x += dir.x;
					lasty = y;
					y += dir.y;
					
				} else { 
					if (nearesttu.x > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
				
				if (FP.distance(nearesttu.x, nearesttu.y, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, nearesttu.x, nearesttu.y));
						shot.play();
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }
			}
			
			else if (nearestpla == null)
			{
				if (FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
				{
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) > 40)
					{
						xDiff = nearesttu.x - x;
						nearest = 2;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearesttu.x - x, nearesttu.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearesttu.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearesttu.x, nearesttu.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			
				else if (FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y))
				{
					if (FP.distance(nearestai.x, nearestai.y, x, y) > 40)
					{
						xDiff = nearestai.x - x;
						nearest = 1;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestai.x - x, nearestai.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
	
					} else { 
						if (nearestai.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestai.x, nearestai.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestai.x, nearestai.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			}
			
			else if (nearestai == null)
			{
				if (FP.distance(nearestpla.x, nearestpla.y, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y))
				{
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) > 40)
					{
						xDiff = nearestpla.x - x;
						nearest = 0;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestpla.x - x, nearestpla.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearestpla.x > x)
						{
						sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestpla.x, nearestpla.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			
				else if (FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(nearestpla.x, nearestpla.y, x, y))
				{
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) > 40)
					{
						xDiff = nearesttu.x - x;
						nearest = 2;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearesttu.x - x, nearesttu.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearesttu.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearesttu.x, nearesttu.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			}
			
			else if (nearesttu == null)
			{
				if (FP.distance(nearestpla.x, nearestpla.y, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
				{
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) > 40)
					{
						xDiff = nearestpla.x - x;
						nearest = 0;
					
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestpla.x - x, nearestpla.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearestpla.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestpla.x, nearestpla.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			
				else if (FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(nearestpla.x, nearestpla.y, x, y))
				{
					if (FP.distance(nearestai.x, nearestai.y, x, y) > 40)
					{
						xDiff = nearestai.x - x;
						nearest = 1;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestai.x - x, nearestai.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;

					} else { 
						if (nearestai.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestai.x, nearestai.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestai.x, nearestai.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			}
			else if (nearestpla != null && nearestai != null && nearesttu != null) {
				if (FP.distance(nearestpla.x, nearestpla.y, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y) && FP.distance(nearestpla.x, nearestpla.y, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
				{
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) > 40)
					{
						xDiff = nearestpla.x - x;
						nearest = 0;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestpla.x - x, nearestpla.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearestpla.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestpla.x, nearestpla.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestpla.x, nearestpla.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			
				else if (FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(nearestpla.x, nearestpla.y, x, y) && FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
				{
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) > 40)
					{
						xDiff = nearesttu.x - x;
						nearest = 2;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearesttu.x - x, nearesttu.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
					
					} else { 
						if (nearesttu.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearesttu.x, nearesttu.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearesttu.x, nearesttu.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			
				else if (FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(nearestpla.x, nearestpla.y, x, y) && FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y))
				{
					if (FP.distance(nearestai.x, nearestai.y, x, y) > 40)
					{
						xDiff = nearestai.x - x;
						nearest = 1;
				
						if (xDiff < 0)
						{
							sprAlien.play("right", false);
						} else { sprAlien.play("left", false); }
				
						dir = new Point(nearestai.x - x, nearestai.y - y);
						dir.normalize(velocity);
						lastx = x;
						x += dir.x;
						lasty = y;
						y += dir.y;
	
					} else { 
						if (nearestai.x > x)
						{
							sprAlien.play("idle1", true);
						} else { sprAlien.play("idle2", true); }
					}
					
					if (FP.distance(nearestai.x, nearestai.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x + 8, y + 8, nearestai.x, nearestai.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					} else { }
				}
			}
		}
		
		/*private function shoot():void
		{
			if (nearest == 0)
			{
				if (FP.distance(Player.xx, Player.yy, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, Player.xx, Player.yy));
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }
			}
			else if (nearest == 1)
			{
				var nturret:Entity = (world as Level).nearestToEntity("turret", this, true);
				
				if (FP.distance(nturret.x, nturret.y, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, nturret.x, nturret.y));
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }
			}
			else if (nearest == 2)
			{
				var nai:Entity = (world as Level).nearestToEntity("playerai", this, true);
				
				if (FP.distance(nai.x, nai.y, x, y) < 80)
				{
					if (shootTimer == 0)
					{
						(world as Level).add(new AlienShot(x + 8, y + 8, nai.x, nai.y));
						shootTimer = 40;
					} else { shootTimer -= 1 }
				} else { }
			}
		}*/
		
		private function collision():void
		{
			var plashot:PlayerShot = collide("plashot", x, y) as PlayerShot;
			var tushot:TurretShot = collide("tushot", x, y) as TurretShot;
			var block:Block = collide("block", x, y) as Block;
			
			if (block)
			{
				velocity = 0;
				if (shootTimer == 0)
				{
					(world as Level).add(new AlienShot(x, y, block.x, block.y));
					shootTimer = 40;
				}
			} else { velocity = 1; }
			
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