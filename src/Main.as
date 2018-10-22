package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Main extends Engine
	{
		
		public function Main():void
		{
			super(200, 150, 60, false);
			FP.screen.scale = 4;
			
			FP.world = new Title;
			//FP.world = new Level;
		}
		
	}
	
}