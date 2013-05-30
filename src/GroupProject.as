package
{
	import com.wbarra.chrome.TopBar;
	import com.wbarra.controller.CustomStuff.KeyClass;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.hero.Hero;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
	
	public class GroupProject extends Sprite
	{
		private var _starling:Starling;
		
		public function GroupProject()
		{
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var top:TopBar = new TopBar();
			addChild(top);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);			
			// Create a Starling instance that will run the "Game" class
			// If we need to change the navigation to the old way
			// change the variable Game into GameController 
			// AND MAKE SURE THE CODE ON THE GAMECONTROLLER AND GAMESCREEN IS UN-COMMENTED
			_starling = new Starling(Game, stage);
			_starling.showStats = true;
			_starling.start();
			
			KeyClass.init(stage);
		}
		
		private function onMove(e:MouseEvent):void
		{
			Hero.mouseX = stage.mouseX;
			Hero.mouseY = stage.mouseY;
		}
	}
}