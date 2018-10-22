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
	public class Turret extends Entity
	{
		[Embed(source = '/img/turret2.png')] private const TURRET:Class;
		private var health:int = 20;
		private var shootTimer:int;
		public static var xx:int;
		public static var yy:int;
		private var lastHeal:int = 0;
		
		public function Turret(_x:Number, _y:Number) 
		{
			graphic = new Image(TURRET);
			x = _x;
			y = _y;
			width = 16;
			height = 16;
			layer = 8;
			type = "turret";
		}
		
		override public function update():void
		{
			collision();
			shoot();
			healthCheck();
		}
		
		private function collision():void
		{
			var alshot:AlienShot = collide("alshot", x, y) as AlienShot;
			var beshot:BehemothShot = collide("beshot", x, y) as BehemothShot;
			var pla:Player = collide("player", x, y) as Player;
			var ai:PlayerAI = collide("playerai", x, y) as PlayerAI;
			
			if (pla || ai)
			{
				if (lastHeal == 0)
				{
					if (health < 20)
					{
						health += 1;
						lastHeal = 30;
					}
				}
			}
			
			if (alshot || beshot)
			{
				health -= 1;
			}
		}
		
		private function updatePublic():void
		{
			xx = x;
			yy = y;
		}
			
		private function shoot():void
		{
			var nearestal:Entity = (world as Level).nearestToEntity("alien", this, true);
			var nearestpural:Entity = (world as Level).nearestToEntity("puralien", this, true);
			var nearestbe:Entity = (world as Level).nearestToEntity("behemoth", this, true);
			var nearestmo:Entity = (world as Level).nearestToEntity("monolith", this, true);
			
			if (nearestal == null && nearestbe == null && nearestmo == null && nearestpural == null)
			{
				
			}
			else if (nearestbe == null && nearestmo == null && nearestpural == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
			}
			else if (nearestbe == null && nearestmo == null && nearestal == null)
			{
				if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
			}
			else if (nearestal == null && nearestpural == null && nearestmo == null)
			{
					if (FP.distance(nearestbe.x, nearestbe.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestbe.x, nearestbe.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
			}
			else if (nearestbe == null && nearestmo == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y))
				{
					if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
			else if (nearestpural == null && nearestmo == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y))
				{
					if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y))
				{
					if (FP.distance(nearestbe.x, nearestbe.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestbe.x, nearestbe.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
			else if (nearestal == null && nearestmo == null)
			{
				if (FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y))
				{
					if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestbe.x, nearestbe.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestbe.x, nearestbe.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
			else if (nearestbe == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestmo.x, nearestmo.y, x, y) && FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestmo.x, nearestmo.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestmo.x, nearestmo.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestmo.x, nearestmo.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestmo.x, nearestmo.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestmo.x, nearestmo.y, x, y))
				{
					if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
			
			else if (nearestmo == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y) && FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y))
				{
					if (FP.distance(nearestbe.x, nearestbe.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestbe.x, nearestbe.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				else if (FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y))
				{
					if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
			else if (nearestal != null && nearestbe != null && nearestmo != null && nearestpural != null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y) && FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y) && FP.distance(nearestal.x, nearestal.y, x, y) < FP.distance(nearestmo.x, nearestmo.y, x, y))
				{
					if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
				
				else if (FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) || FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y) && FP.distance(nearestpural.x, nearestpural.y, x, y) < FP.distance(nearestmo.x, nearestmo.y, x, y))
				{
					if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			
				else if (FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y) && FP.distance(nearestbe.x, nearestbe.y, x, y) < FP.distance(nearestmo.x, nearestmo.y, x, y))
				{
					if (FP.distance(nearestbe.x, nearestbe.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestbe.x, nearestbe.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			
				else if (FP.distance(nearestmo.x, nearestmo.y, x, y) < FP.distance(nearestal.x, nearestal.y, x, y) && FP.distance(nearestmo.x, nearestmo.y, x, y) < FP.distance(nearestpural.x, nearestpural.y, x, y) && FP.distance(nearestmo.x, nearestmo.y, x, y) < FP.distance(nearestbe.x, nearestbe.y, x, y))
				{
					if (FP.distance(nearestmo.x, nearestmo.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestmo.x, nearestmo.y));
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
		}
		
		private function healthCheck():void
		{
			if (health == 0)
			{
				FP.world.remove(this);
			} else { }
		}
	}

}