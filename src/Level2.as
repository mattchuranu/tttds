package  
{
	import flash.geom.Rectangle;
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
	public class Level extends World
	{
		public static var playerID:int = 0;
		public static var score:int = 0;
		public var formation:int = 0;
		private var alienTimer:int = randomRange(70, 30);
		private var purAlienTimer:int = randomRange(210, 90);
		private var rand:int;
		private var rand2:int;
		public var alienCounter:int = 0;
		public var behemothCounter:int = 0;
		private var posTimer:int = 900;
		private var playerArray:Array = [];
		private var playerXArray:Array = [];
		private var playerYArray:Array = [];
		private var aiArray:Array = [];
		private var aiXArray:Array = [];
		private var aiYArray:Array = [];
		private var alienArray:Array = [];
		private var alienXArray:Array = [];
		private var alienYArray:Array = [];
		private var behemothArray:Array = [];
		private var behemothXArray:Array = [];
		private var behemothYArray:Array = [];
		private var timeCool:int = 900;
		public var maxEnemies:int = 10;
		public var activeEnemies:int = 0;
		private var pause:int = 0;
		public var aiSpawnArray:Array = [];
		
		public function Level() 
		{
			add(new Background);
			//add(new Alien(120, 120));
			add(new Player(0, 0));
			add(new PlayerAI(120, 120, playerID));
			//add(new PlayerAI(120, 100, playerID));
			add(new Crosshair);
			add(new Healthbar);
			add(new Score);
		}
		
		override public function update():void
		{
			if (pause == 0)
			{
				super.update();
			
				/*if (score < 250)
				{
					maxEnemies = 5;
				} else {
					maxEnemies = score / 25;
				}*/
			
				if (activeEnemies < maxEnemies)
				{
					alienSpawn();
					purAlienSpawn();
					behemothSpawn();
				}
			
				monolithSpawn();
				savPos();
				checkZ();
				checkSpace();
			}
			playerCheck();
			//trace(activeEnemies);
		}
		
		public function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		private function alienSpawn():void
		{
			var time:int
			
			time = randomRange(140, 60);
			
			/*if (score == 0) { time = randomRange(280, 120); }
			else
			{
				time = randomRange(score / 0.1, score / 0.05);
			}*/
			
			rand = randomRange(4, 1);
			
			if (alienTimer == 0)
			{
				if (rand == 1)
				{
					add(new Alien(randomRange(0, 640), 0));
					alienTimer = time;
					activeEnemies += 1;
				}
				if (rand == 2)
				{
					add(new Alien(640, randomRange(0, 480)));
					alienTimer = time;
					activeEnemies += 1;
				}
				if (rand == 3)
				{
					add(new Alien(randomRange(0, 640), 480));
					alienTimer = time;
					activeEnemies += 1;
				}
				if (rand == 4)
				{
					add(new Alien(0, randomRange(0, 480)));
					alienTimer = time;
					activeEnemies += 1;
				}
			} else {alienTimer -= 1}
		}
		
		private function purAlienSpawn():void
		{
			var time2:int;
			
			time2 = randomRange(240, 90); 
			
			/*if (score == 0) { time2 = randomRange(420, 180); }
			else
			{
				time2 = randomRange(score / 0.18, score / 0.09);
			}*/
			
			rand = randomRange(4, 1);
			
			if (purAlienTimer == 0)
			{
				if (rand == 1)
				{
					add(new PurpleAlien(randomRange(0, 640), 0));
					purAlienTimer = time2;
					activeEnemies += 1;
				}
				if (rand == 2)
				{
					add(new PurpleAlien(640, randomRange(0, 480)));
					purAlienTimer = time2;
					activeEnemies += 1;
				}
				if (rand == 3)
				{
					add(new PurpleAlien(randomRange(0, 640), 480));
					purAlienTimer = time2;
					activeEnemies += 1;
				}
				if (rand == 4)
				{
					add(new PurpleAlien(0, randomRange(0, 480)));
					purAlienTimer = time2;
					activeEnemies += 1;
				}
			} else {purAlienTimer -= 1}
		}
		
		private function behemothSpawn():void
		{
			rand2 = randomRange(4, 1);
			if (alienCounter == 10)
			{
				if (rand2 == 1)
				{
					add(new Behemoth(randomRange(0, 640), 0));
					alienCounter = 0;
					activeEnemies += 1;
				}
				if (rand2 == 2)
				{
					add(new Behemoth(640, randomRange(0, 480)));
					alienCounter = 0;
					activeEnemies += 1;
				}
				if (rand2 == 3)
				{
					add(new Behemoth(randomRange(0, 640), 480));
					alienCounter = 0;
					activeEnemies += 1;
				}
				if (rand2 == 4)
				{
					add(new Behemoth(0, randomRange(0, 480)));
					alienCounter = 0;
					activeEnemies += 1;
				}
			} else { }
		}
		
		private function monolithSpawn():void
		{
			if (behemothCounter == 10)
			{
				add(new Monolith(randomRange(0, 608), randomRange(0, 448)));
				behemothCounter = 0;
			} else { }
		}
		
		private function savPos():void
		{
			if (posTimer == 0)
			{
				playerArray = [];
				alienArray = [];
				behemothArray = [];
				aiArray = [];
					
				FP.world.getClass(Player, playerArray);
				FP.world.getClass(Alien, alienArray);
				FP.world.getClass(Behemoth, behemothArray);
				FP.world.getClass(PlayerAI, aiArray);
			
				var p:int = 0;
				var a:int = 0;
				var b:int = 0;
				var l:int = 0;
			
				for each (var e:Player in playerArray)
				{
					playerXArray[p] = e.x;
					playerYArray[p] = e.y;
					p += 1;
				}
			
				for each (var f:Alien in alienArray)
				{
					alienXArray[a] = f.x;
					alienYArray[a] = f.y;
					a += 1;
				}
			
				for each (var g:Behemoth in behemothArray)
				{
					behemothXArray[b] = g.x;
					behemothYArray[b] = g.y;
					b += 1;
				}
				
				for each (var h:PlayerAI in aiArray)
				{
					aiXArray[l] = h.x;
					aiYArray[l] = h.y;
					l += 1;
				}
				
				posTimer = 300;
			} else { posTimer -= 1; }
		}
		
		private function checkSpace():void
		{
			if (timeCool == 0)
			{
				if (classCount(Player) > 0)
				{
					if (Input.pressed(Key.SPACE))
					{
						/*for (var i:Number = 0; i < playerArray.length; i += 1)
						{
							add(new Player(playerXArray[i], playerYArray[i]));
						}*/
						
						for (var i:Number = 0; i < playerArray.length; i += 1)
						{
							add(new PlayerAI(playerXArray[i], playerYArray[i], playerID));
						}
				
						for (var j:Number = 0; j < alienArray.length; j += 1)
						{
							add(new Alien(alienXArray[j], alienYArray[j]));
						}
					
						for (var k:Number = 0; k < behemothArray.length; k += 1)
						{
						add(new Behemoth(behemothXArray[k], behemothYArray[k]));
						}
						
						for (var m:Number = 0; m < aiArray.length; m += 1)
						{
							add(new PlayerAI(aiXArray[m], aiYArray[m], playerID));
						}
						
						add(new Flare);
						score += 500;
						timeCool = 1800;
					}
				}
			} else { timeCool -= 1 }
		}
		
		private function checkZ():void
		{
			if (Input.pressed(Key.Z))
			{
					if (formation == 0)
					{
						formation = 1;
						//trace(formation);
					}
					else if (formation == 1)
					{
						formation = 0;
						//trace(formation);
					}
			}
		}
		
		private function playerCheck():void
		{
			if (classCount(Player) == 0)
			{
				add(new EndBackground);
				add(new RestartText);
				pause = 1;
				
				if (Input.check(Key.R))
				{
					FP.world = new Level;
					score = 0;
					pause = 0;
				}
			}
		}
	}

}