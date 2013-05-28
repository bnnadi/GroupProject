package com.wbarra.controller.states
{
	import com.wbarra.controller.Screens.GameScreen;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.interfaces.IState;
	
	import starling.display.Sprite;
	
	public class Play extends Sprite implements IState
	{
		public function Play(game:Game)
		{
			var gameScreen:GameScreen = new GameScreen();
			addChild( gameScreen );
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
		}
	}
}