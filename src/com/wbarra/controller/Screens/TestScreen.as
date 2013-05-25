package com.wbarra.controller.Screens
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import com.wbarra.controller.EnemyShips.TestBall;
	
	public class TestScreen extends Sprite
	{
		private var _ball:TestBall;
		
		public function TestScreen()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		private function onAdded():void
		{
			initAll();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function initAll():void
		{
			_ball = new TestBall();
			stage.addChild( _ball );
		}
		private function onEnterFrame():void
		{
			_ball.ballMove()
			
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == 40 && event.keyCode == 39)
			{
				trace("down and right");
				_ball.x += 5;
				_ball.y -= 5;
			}
			if (event.keyCode == 37)
			{
				trace("left");
				_ball.x -= 10;
			}
			if (event.keyCode == 38)
			{
				trace("up");
				_ball.y -= 10;
			}
			if (event.keyCode == 39)
			{
				trace("right");
				_ball.x += 10;
			}
			if (event.keyCode == 40)
			{
				trace("Down");
				_ball.y += 10;
			}
		}
	}
}