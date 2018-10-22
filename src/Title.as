package  
{
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Matt Chelen
	 */
	public class Title extends World
	{
		
		public function Title() 
		{
			add(new Titlebg);
		}
		
		override public function update():void
		{
			if (Input.check(Key.SPACE))
			{
				if (checkDomain(["anotherdayanotherga.me", "endaron.com"]))
				{
					FP.world = new Level;
					trace("returned true!")
				}
			}
		}
		
		public function checkDomain (allowed:*):Boolean
		{
			var url:String = FP.stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;
	
			if (url.substr(0, startCheck) == 'file://') return true;
	
			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);
	
			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed)
			{
				if (host.substr(-d.length, d.length) == d) return true;
			}
	
			return false;
		}
		
	}

}