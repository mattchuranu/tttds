package  
{
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class TestClass 
	{
		private function move():void
		{
			var nearesttu:Entity = (world as Level).nearestToEntity("turret", this, true);
			var nearestai:Entity = (world as Level).nearestToEntity("playerai", this, true);
			
			if (FP.distance(Player.xx, Player.yy, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y) && FP.distance(Player.xx, Player.yy, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
			{
				if (FP.distance(Player.xx, Player.yy, x, y) > 40)
				{
					var xDiff:int = Player.xx - x;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					var dir:Point = new Point(Player.xx - x, Player.yy - y);
					dir.normalize(velocity);
				
					var block:Block = collide("block", x, y) as Block;
					var nearest:Entity = (world as Level).nearestToEntity("turret", this, true);
				
					if (nearest != null)
					{	
						if (FP.distance(nearest.x, nearest.y, x, y) < 80)
						{
							x = x;
							y = y;
							if (shootTimer == 0)
							{
								(world as Level).add(new AlienShot(x, y, nearest.x, nearest.y));
								shootTimer = 40;
							}
						}
					}
				
					lastx = x;
					x += dir.x;
					if (block)
					{
						x = lastx;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 40;
						}
					}
				
					lasty = y;
					y += dir.y;
					if (block)
					{
						y = lasty;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 60;
						}
					}
				} else { 
					if (Player.xx > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
			}
			
			else if (FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(Player.xx, Player.yy, x, y) && FP.distance(nearesttu.x, nearesttu.y, x, y) < FP.distance(nearestai.x, nearestai.y, x, y))
			{
				if (FP.distance(nearesttu.x, nearesttu.y, x, y) > 40)
				{
					var xDiff:int = nearesttu.x - x;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					var dir:Point = new Point(nearesttu.x - x, nearesttu.y - y);
					dir.normalize(velocity);
				
					var block:Block = collide("block", x, y) as Block;
					var nearest:Entity = (world as Level).nearestToEntity("turret", this, true);
				
					if (nearest != null)
					{	
						if (FP.distance(nearest.x, nearest.y, x, y) < 80)
						{
							x = x;
							y = y;
							if (shootTimer == 0)
							{
								(world as Level).add(new AlienShot(x, y, nearest.x, nearest.y));
								shootTimer = 40;
							}
						}
					}
				
					lastx = x;
					x += dir.x;
					if (block)
					{
						x = lastx;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 40;
						}
					}
				
					lasty = y;
					y += dir.y;
					if (block)
					{
						y = lasty;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 60;
						}
					}
				} else { 
					if (nearesttu.x > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
			}
			
			else if (FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(Player.xx, Player.yy, x, y) && FP.distance(nearestai.x, nearestai.y, x, y) < FP.distance(nearesttu.x, nearesttu.y, x, y))
			{
				if (FP.distance(nearestai.x, nearestai.y, x, y) > 40)
				{
					var xDiff:int = nearestai.x - x;
				
					if (xDiff < 0)
					{
						sprAlien.play("right", false);
					} else { sprAlien.play("left", false); }
				
					var dir:Point = new Point(nearestai.x - x, nearestai.y - y);
					dir.normalize(velocity);
				
					var block:Block = collide("block", x, y) as Block;
					var nearest:Entity = (world as Level).nearestToEntity("turret", this, true);
				
					if (nearest != null)
					{	
						if (FP.distance(nearest.x, nearest.y, x, y) < 80)
						{
							x = x;
							y = y;
							if (shootTimer == 0)
							{
								(world as Level).add(new AlienShot(x, y, nearest.x, nearest.y));
								shootTimer = 40;
							}
						}
					}
				
					lastx = x;
					x += dir.x;
					if (block)
					{
						x = lastx;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 40;
						}
					}
				
					lasty = y;
					y += dir.y;
					if (block)
					{
						y = lasty;
						if (shootTimer == 0)
						{
							(world as Level).add(new AlienShot(x, y, block.x, block.y));
							shootTimer = 60;
						}
					}
				} else { 
					if (nearesttu.x > x)
					{
						sprAlien.play("idle1", true);
					} else { sprAlien.play("idle2", true); }
				}
			}
		}
		
	}

}