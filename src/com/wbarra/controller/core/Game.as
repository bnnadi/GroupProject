package com.wbarra.controller.core
{
	import com.wbarra.controller.interfaces.IState;
	import com.wbarra.controller.states.Menu;
	import com.wbarra.controller.states.Over;
	import com.wbarra.controller.states.Play;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		public static const MENU_STATE:int 		= 0;
		public static const PLAY_STATE:int 		= 1;
		public static const GAME_OVER_STATE:int = 2;
		
		private var _currentState:IState;
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			trace("added to stage");
			changeState(MENU_STATE);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function changeState(state:int):void
		{
			if(_currentState != null)
			{
				_currentState.destroy();
				_currentState = null;
			}
			
			switch(state)
			{
				case MENU_STATE:
					_currentState = new Menu(this);
					break;
				
				case PLAY_STATE:
					_currentState = new Play(this);
					break;
				
				case GAME_OVER_STATE: 
					_currentState = new Over(this);
					break;
			}
			addChild(Sprite(_currentState));
		}
		
		private function update(event:Event):void	
		{
			_currentState.update();
		}
		
		private function destroy():void
		{
			
		}
	}
}