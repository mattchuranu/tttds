package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
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
	public class PlayerAI extends Entity
	{
		[Embed(source = '/img/player2.png')] private const PLAYER:Class;
		[Embed(source = '/snd/shot1.mp3')] private const SHOT:Class;
		[Embed(source = '/snd/hit1.mp3')] private const HIT:Class;
		private var shot:Sfx = new Sfx(SHOT);
		private var hit:Sfx = new Sfx(HIT);
		private var sprPlayer:Spritemap = new Spritemap(PLAYER, 16, 16);
		private var shootTimer:int = 0;
		public static var xx:int;
		public static var yy:int;
		private var crossX:int;
		private var crossY:int;
		private var health:int = 25;
		private var velocity:int = 2;
		private var plaID:int;
		private var purAlTimer:int = 30;
		private var lastHit:int = 0;
		private var lastHeal:int = 0;
		public var position:int;
		private var movTimer:int = 40 + (20 *plaID);
		public static var aiPosVec:Vector.<Point> = new Vector.<Point>;
		public static var someNumber:int = 0;
		private var anotherNumber:int = someNumber - 20;
		private var IDset:int = 0;
		
		public function PlayerAI(_x:Number, _y:Number, _id:Number):void 
		{
			sprPlayer.add("idle1", [0], 10, false);
			sprPlayer.add("idle2", [4], 10, false);
			sprPlayer.add("left", [0, 1, 2, 3], 10, true);
			sprPlayer.add("right", [4, 5, 6, 7], 10, true);
			sprPlayer.add("leftup", [8, 9, 10, 11], 10, true);
			sprPlayer.add("rightup", [12, 13, 14, 15], 10, true);
			graphic = sprPlayer;
			x = _x;
			y = _y;
			crossX = x;
			crossY = y;
			width = 16;
			height = 16;
			type = "playerai";
			layer = 0;
			
			/*for (var n:Number = 0; n < (world as Level).aiSpawnArray.length; n += 1)
			{
				if ((world as Level).aiSpawnArray[n] == null)
				{
					(world as Level).aiSpawnArray[n] = n;
					plaID = n;
				}
			}*/
			//Level.playerID += 1;
			trace("AI spawned");
		}
		
		override public function added():void
		{
			/*for (var n:Number = 0; n < (world as Level).aiSpawnArray.length; n += 1)
			{
				if ((world as Level).aiSpawnArray[n] != n)
				{
					(world as Level).aiSpawnArray[n] = n;
					plaID = n;
				}
			}*/
			if ((world as Level).aiSpawnArray[0] == null)
			{
				(world as Level).aiSpawnArray[0] = 0;
				plaID = 0;
			}
			else if ((world as Level).aiSpawnArray[1] == null)
			{
				(world as Level).aiSpawnArray[1] = 1;
				plaID = 1;
			}
			else if ((world as Level).aiSpawnArray[2] == null)
			{
				(world as Level).aiSpawnArray[2] = 2;
				plaID = 2;
			}
			else if ((world as Level).aiSpawnArray[3] == null)
			{
				(world as Level).aiSpawnArray[3] = 3;
				plaID = 3;
			}
			else if ((world as Level).aiSpawnArray[4] == null)
			{
				(world as Level).aiSpawnArray[4] = 4;
				plaID = 4;
			}
			else if ((world as Level).aiSpawnArray[5] == null)
			{
				(world as Level).aiSpawnArray[5] = 5;
				plaID = 5;
			}
			else if ((world as Level).aiSpawnArray[6] == null)
			{
				(world as Level).aiSpawnArray[6] = 6;
				plaID = 6;
			}
			else if ((world as Level).aiSpawnArray[7] == null)
			{
				(world as Level).aiSpawnArray[7] = 7;
				plaID = 7;
			}
			else if ((world as Level).aiSpawnArray[8] == null)
			{
				(world as Level).aiSpawnArray[8] = 8;
				plaID = 8;
			}
			else if ((world as Level).aiSpawnArray[9] == null)
			{
				(world as Level).aiSpawnArray[9] = 9;
				plaID = 9;
			}
			/*for each (var n:int in (world as Level).aiSpawnArray)
			{
				if ((world as Level).aiSpawnArray[n] == null)
				{
					(world as Level).aiSpawnArray[n] = n;
					plaID = n;
				}
			}*/
			//position = (world as Level).ai.push(this);
		}
		
		override public function update():void
		{
			
			//plaID = position;
			/*if (movTimer == 0)
			{
				move();
			} else { movTimer -= 1; }*/
			move();
			shoot();
			heal();
			collision();
			onScreen();
			checkHealth();
		}
		
		/*private function move():void
		{
			if (Input.pressed(Key.F))
			{
				if ((world as Level).formation == 0)
				{
					crossX = Crosshair.xx + (plaID * 20);
					crossY = Crosshair.yy;
				}
				else if ((world as Level).formation == 1)
				{
					crossX = Crosshair.xx;
					crossY = Crosshair.yy + (plaID * 20);
				}
			}
			if (FP.distance(crossX, crossY, x, y) > 20)
				{
					var dir:Point = new Point(crossX - x, crossY - y);
					dir.normalize(velocity);
			
					x += dir.x;
					y += dir.y;
					if (crossX > x && crossY > y)
					{
						sprPlayer.play("right", false);
					}
					if (crossX > x && crossY < y)
					{
						sprPlayer.play("rightup", false);
					}
					if (crossX < x && crossY > y)
					{
						sprPlayer.play("left", false);
					}
					if (crossX < x && crossY < y)
					{
						sprPlayer.play("leftup", false);
					}
				} else {
					if (crossX >= x)
					{
						sprPlayer.play("idle2", false);
					}
					if (crossX < x)
					{
						sprPlayer.play("idle1", false);
					}
				}
		}*/
		
		private function move():void
		{
			//trace((world as Level).playerPosArray[(world as Level).anotherNumber].x);
			//trace(Player.plaPosArray[Player.aNumber].x);
			//var xNumber:int = Player.plaXArray[someNumber];
			//trace(xNumber);
			//trace(Player.xx);
			//aiPosVec[someNumber] = Player.publicPoint;
			aiPosVec[someNumber] = Player.publicPoint;
			if (aiPosVec[someNumber] != null)
			{
				//trace(aiPosVec[0]);
				//trace("someNumber =" + someNumber)
			}
			if (movTimer == 0)
			{
				//if (FP.distance(Player.xx, Player.yy, x, y) > 20 + (20 * plaID))
				if (FP.distance(Player.xx, Player.yy, x, y) > 20 + (20 * plaID))
				{
					//trace(anotherNumber);
					//var anotherNumber:int = someNumber - 20;
					//var dir:Point = new Point(aiPosVec[anotherNumber].x - x, aiPosVec[anotherNumber].y - y);
					var dir:Point = new Point(aiPosVec[anotherNumber].x - x, aiPosVec[anotherNumber].y - y);
					//var dir:Point = new Point(Player.plaXArray[someNumber] - x, Player.plaYArray[someNumber] - y);
					//trace(dir);
					dir.normalize(velocity);
					
					x += dir.x;
					y += dir.y;
					
					if (Player.xx > x && Player.yy > y)
					{
						sprPlayer.play("right", false);
					}
					if (Player.xx > x && Player.yy < y)
					{
						sprPlayer.play("rightup", false);
					}
					if (Player.xx < x && Player.yy > y)
					{
						sprPlayer.play("left", false);
					}
					if (Player.xx < x && Player.yy < y)
					{
						sprPlayer.play("leftup", false);
					}
				} else {
					if (Player.xx >= x)
					{
						sprPlayer.play("idle2", false);
					}
					if (Player.xx < x)
					{
						sprPlayer.play("idle1", false);
					}
				}
			} else { movTimer -= 1; }
			
			someNumber += 1;
			//anotherNumber = someNumber - 20;
			anotherNumber = someNumber - (20 + (20 * plaID));
			//trace(plaID);
			//anotherNumber = someNumber - 20 * plaID;
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
			else if (nearestbe == null && nearestmo == null && nearestal == null)
			{
				if (FP.distance(nearestpural.x, nearestpural.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestpural.x, nearestpural.y));
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
			}
			else if (nearestbe == null && nearestmo == null && nearestpural == null)
			{
				if (FP.distance(nearestal.x, nearestal.y, x, y) < 80)
					{
						if (shootTimer == 0)
						{
							(world as Level).add(new TurretShot(x + 8, y + 8, nearestal.x, nearestal.y));
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
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
							shot.play();
							shootTimer = 40;
						} else { shootTimer -= 1 }
					}
				}
			}
		}
		
		private function heal():void
		{
			if (lastHit == 0)
			{
				if (lastHeal == 0)
				{
					if (health < 25)
					{
						health += 1;
					}
					lastHeal = 30;
				} else { lastHeal -= 1; }
			} else { lastHit -= 1; }
		}
		
		private function collision():void
		{
			//var plashot:PlayerShot = collide("plashot", x, y) as PlayerShot;
			var alshot:AlienShot = collide("alshot", x, y) as AlienShot;
			var beshot:BehemothShot = collide("beshot", x, y) as BehemothShot;
			var moshot:MonolithShot = collide("moshot", x, y) as MonolithShot;
			var hp:HealthPack = collide("pickup", x, y) as HealthPack;
			var pural:PurpleAlien = collide("puralien", x, y) as PurpleAlien;
			
			if (alshot)
			{
				//(world as Level).add(new HitRect(x, y, width, height));
				health -= 1;
				hit.play();
				lastHit = 180;
			}
			/*if (plashot)
			{
				health -= 25;
			}*/
			if (purAlTimer == 0)
			{
				if (pural)
				{
					health -= 2;
					hit.play();
					purAlTimer = 30;
					lastHit = 180;
				}
			} else { purAlTimer -= 1; }
			if (beshot)
			{
				health -= 3;
				hit.play();
				lastHit = 180;
			}
			if (moshot)
			{
				health -= 10;
				hit.play();
				lastHit = 180;
			}
			if (hp)
			{
				health = 25;
			}
		}
		
		private function onScreen():void
		{
			if (x <= 0)
			{
				x = 0;
			}
			if (y <= 0)
			{
				y = 0;
			}
			if (x >= 624)
			{
				x = 624;
			}
			if (y >= 464)
			{
				y = 464;
			}
		}
		
		private function checkHealth():void
		{
			if (health <= 0)
			{
				FP.world.remove(this);
				(world as Level).aiSpawnArray[plaID] = null;
				//(world as Level).removeAI(position);
			} else { }
		}
	}

}