package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class RestartText extends Entity
	{
		private var restartText:Text = new Text(String("Score: " + Level.score + "\r" + "R to" + "\r" + "restart"), FP.camera.x + 30, FP.camera.y + 20);
		
		public function RestartText() 
		{
			restartText.color = 0xFFAFBF;
			graphic = restartText;
			layer = 0;
		}
		
	}

}