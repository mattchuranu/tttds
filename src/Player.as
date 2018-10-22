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
	public class Player extends Entity
	{
		[Embed(source = '/img/player2.png')] private const PLAYER:Class;
		[Embed(source = '/snd/shot1.mp3')] private const SHOT:Class;
		[Embed(source = '/snd/pickup.mp3')] private const PICKUP:Class;
		[Embed(source = '/snd/place.mp3')] private const PLACE:Class;
		[Embed(source = '/snd/hit1.mp3')] private const HIT:Class;
		[Embed(source = '/snd/health.mp3')] private const HEALTH:Class;
		
		private var shot:Sfx = new Sfx(SHOT);
		private var pickup:Sfx = new Sfx(PICKUP);
		private var place:Sfx = new Sfx(PLACE);
		private var hit:Sfx = new Sfx(HIT);
		private var healthfx:Sfx = new Sfx(HEALTH);
		
		private var sprPlayer:Spritemap = new Spritemap(PLAYER, 16, 16);
		public var fac:int = 1;
		private var shootTimer:int = 0;
		public static var xx:int;
		public static var yy:int;
		public static var health:int = 25;
		private var blockCount:int = 0;
		private var turretCount:int = 0;
		private var lastx:int;
		private var lasty:int;
		private var ID:int;
		private var purAlTimer:int = 30;
		private var lastHit:int = 0;
		private var lastHeal:int = 0;
		public static var aNumber:int = 0;
		//public static var plaXArray:Array = [];
		//public static var plaYArray:Array = [];
		//public static var plaPosArray:Array = [];
		public static var plaPosVec:Vector.<Point> = new Vector.<Point>;
		public static var publicPoint:Point;
		
		public function Player(_x:Number, _y:Number):void 
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
			width = 16;
			height = 16;
			type = "player";
			layer = 0;
			//trace("player spawned at" + x + "," + y);
			//ID = Level.playerID;
			//Level.playerID += 1;
			//sprPlayer.play("idle", true);
			//plaPosVec[0] = new Point(0, 0);
			PlayerAI.aiPosVec[0] = new Point(0, 0);
		}
		
		override public function update():void
		{
			orientation();
			move();
			shoot();
			heal();
			placeTower();
			updatePublic();
			collision();
			checkHealth();
			onScreen();
			
		}
		
		private function findMiddle(X1:Number, Y1:Number, X2:Number, Y2:Number):Object
		{
			return {X:X1 + (X2 - X1)/2, Y:Y1 + (Y2 - Y1)/2};
		}
		
		private function move():void
		{
			var block:Block = collide("block", x, y) as Block;
			
			if (Input.check(Key.A))
			{
				//lastx = x;
				x -= 2;
				/*if (block)
				{
					x = lastx + 2;
				}*/
			}

			if (Input.check(Key.D))
			{
				//lastx = x;
				x += 2;
				/*if (block)
				{
					x = lastx - 2;
				}*/
			}

			if (Input.check(Key.W))
			{
				//lasty = y;
				y -= 2;
				/*if (block)
				{
					y = lasty + 2;
				}*/
			}
			
			if (Input.check(Key.S))
			{
				//lasty = y
				y += 2;
				/*if (block)
				{
					y = lasty - 2;
				}*/
			}
		}
		
		/*private function orientation():void
		{
			if (Crosshair.xx > x)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("right", true);
				} else { sprPlayer.play("idle2", true); }
			} 
			else if (Crosshair.xx < x)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("left", true);
				} else { sprPlayer.play("idle1", true); }
			}
		}*/
		
		private function orientation():void
		{
			if (Crosshair.xx > x && Crosshair.yy > y)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("right", false);
				} else { sprPlayer.play("idle2", false); }
			} 
			else if (Crosshair.xx < x && Crosshair.yy > y)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("left", false);
				} else { sprPlayer.play("idle1", false); }
			}
			else if (Crosshair.xx > x && Crosshair.yy < y)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("rightup", false);
				} else { sprPlayer.play("idle2", false); }
			}
			else if (Crosshair.xx < x && Crosshair.yy < y)
			{
				if (Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.A) || Input.check(Key.D))
				{
					sprPlayer.play("leftup", false);
				} else { sprPlayer.play("idle1", false); }
			}
		}
		
		private function shoot():void
		{
			if (shootTimer == 0)
			{
				if (Input.mouseDown)
				{
					(world as Level).add(new PlayerShot(x + 8, y + 8));
					shot.play();
					shootTimer = 10;
				}
			} else { shootTimer -= 1; }
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
		
		private function placeTower():void
		{
			if (Input.pressed(Key.Q))
			{
				if (blockCount > 0)
				{
					if (FP.world.mouseX >= 0 && FP.world.mouseX <= 624 && FP.world.mouseY >= 0 && FP.world.mouseY <= 464)
					{
						(world as Level).add(new Block(FP.world.mouseX, FP.world.mouseY));
						place.play();
						blockCount -= 1;
					}
				}
			}
			if (Input.pressed(Key.E))
			{
				if (turretCount > 0)
				{
					if (FP.world.mouseX >= 0 && FP.world.mouseX <= 624 && FP.world.mouseY >= 0 && FP.world.mouseY <= 464)
					{
						(world as Level).add(new Turret(FP.world.mouseX, FP.world.mouseY));
						place.play();
						turretCount -= 1;
					}
				}
			}
		}
		
		private function updatePublic():void
		{
			xx = x;
			yy = y;
			//FP.camera.x = x - (40 / findMiddle(FP.world.mouseX, FP.world.mouseY, x, y).X) * 20;
			//FP.camera.y = y - (30 / findMiddle(FP.world.mouseX, FP.world.mouseY, x, y).Y) * 20;
			FP.camera.x = findMiddle(FP.world.mouseX, FP.world.mouseY, x, y).X  - 200 / 2 + 4;
			FP.camera.y = findMiddle(FP.world.mouseX, FP.world.mouseY, x, y).Y  - 150 / 2 + 4;
			//FP.camera.x = x + FP.sign((this.world as Level).mouseX - x) - 80 / 2 + 4;
			//FP.camera.y = y + FP.sign((this.world as Level).mouseY - y) - 60 / 2 + 4;
			//trace(ID + "health: " + health);
			//var point:Point = new Point(x, y);
			//plaPosVec[aNumber] = point;
			//PlayerAI.aiPosVec[aNumber] = point;
			//trace(PlayerAI.aiPosVec[0]);
			//plaPosArray[aNumber] = point;
			//publicPoint = new Point(plaPosArray[aNumber].x, plaPosArray[aNumber].y);
			publicPoint = new Point(x, y);
			//trace(aNumber);
			//trace(plaPosArray[aNumber].x);
			//plaXArray[aNumber] = x;
			//plaYArray[aNumber] = y;
			//trace(plaXArray[aNumber]);
			//aNumber += 1;
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
		
		private function collision():void
		{
			var alshot:AlienShot = collide("alshot", x, y) as AlienShot;
			var beshot:BehemothShot = collide("beshot", x, y) as BehemothShot;
			var moshot:MonolithShot = collide("moshot", x, y) as MonolithShot;
			var blockup:BlockPickup = collide("pickup", x, y) as BlockPickup;
			var turretup:TurretPickup = collide("pickup", x, y) as TurretPickup;
			var hp:HealthPack = collide("pickup", x, y) as HealthPack;
			var pural:PurpleAlien = collide("puralien", x, y) as PurpleAlien;
			
			if (alshot)
			{
				//(world as Level).add(new HitRect(x, y, width, height));
				health -= 1;
				lastHit = 180;
				hit.play();
			}
			
			if (purAlTimer == 0)
			{
				if (pural)
				{
					health -= 2;
					purAlTimer = 30;
					lastHit = 180;
					hit.play();
				}
			} else { purAlTimer -= 1; }
			
			if (beshot)
			{
				health -= 3;
				lastHit = 180;
				hit.play();
			}
			if (moshot)
			{
				health -= 10;
				lastHit = 180;
				hit.play();
			}
			if (blockup)
			{
				blockCount += 1;
				pickup.play();
			}
			if (turretup)
			{
				turretCount += 1;
				pickup.play();
			}
			if (hp)
			{
				health = 25;
				healthfx.play();
			}
		}
		
		private function checkHealth():void
		{
			if (health <= 0)
			{
				FP.world.remove(this);
				health = 25;
				//trace("player died");
			} else { }
		}
	}

}