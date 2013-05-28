package com.wbarra.controller.navigator
{
	import com.wbarra.controller.Screens.GameScreen;
	
	import starling.display.Sprite;
	
	public class GameController extends Sprite
	{
		public function GameController()
		{
			super();
			
			var gameScreen:GameScreen = new GameScreen();
			addChild( gameScreen );
		}
		
	}
}