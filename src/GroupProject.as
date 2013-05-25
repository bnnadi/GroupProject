package
{
	import com.wbarra.controller.CustomStuff.KeyClass;
	import com.wbarra.controller.hero.Hero;
	import com.wbarra.controller.navigator.GameController;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import starling.core.Starling;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#FFFFFF")]
	
	public class GroupProject extends Sprite
	{
		private var _starling:Starling;
		
		public function GroupProject()
		{
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);			
			// Create a Starling instance that will run the "Game" class
			_starling = new Starling(GameController, stage);
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