package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Score extends Entity
	{
		private var scoreText:Text = new Text(String("Score: " + Level.score), 240, 210);
		
		public function Score() 
		{
			scoreText.color = 0xFFFFFF;
			graphic = scoreText;
			layer = 8;
		}
		
		override public function update():void
		{
			scoreText.text = String("Score: " + Level.score);
		}
		
	}

}