package com.wbarra.chrome
{
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import libs.Bar;
	import libs.closeBtn;
	import libs.fullscreen;
	import libs.minBtn;
	
	public class TopBar extends Sprite
	{

		private var _bar:Bar;

		private var _min:minBtn;

		private var _full:fullscreen;

		private var _close:closeBtn;

		private var _tbg:Sprite;
		private var _rbg:Sprite;
		private var _bbg:Sprite;
		private var _lbg:Sprite;
		
		public function TopBar()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		protected function onAdd(event:Event):void
		{
			_tbg = new Sprite();
			_rbg = new Sprite();
			_bbg = new Sprite();
			_lbg = new Sprite();
			
			addChild(_tbg);
			addChild(_rbg);
			addChild(_bbg);
			addChild(_lbg);
			
			// adding the creation of the top bar to the stage
			createTopBar();
		}
		
		private function createTopBar():void
		{
			// We no have the new top bar and it's functionality
			
			_bar = new Bar();	
			addChild(_bar);
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, onMove);
			
			_close = new closeBtn();
			_close.x = _close.width/2;
			_close.y = _close.height/2;
			_close.scaleX = _close.scaleY = .8;
			_bar.addChild(_close);
			_close.addEventListener(MouseEvent.CLICK, onCloseClick);
			
			_min = new minBtn();
			_min.x = _close.width + _min.width;
			_min.y = _min.height/2;
			_min.scaleX = _min.scaleY = .8;
			_bar.addChild(_min);
			_min.addEventListener(MouseEvent.CLICK, onMinClick);
			
			_full = new fullscreen();
			_full.scaleX = _full.scaleY = .5;
			_full.x = _bar.width - (_full.width + (_full.width/2));
			_full.y = 5;
			_bar.addChild(_full);
			_full.addEventListener(MouseEvent.CLICK, onFullBtn);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullClick);
		}
		
		protected function onMove(event:MouseEvent):void
		{
			// When you use the mouse is down on the stage will move
			stage.nativeWindow.startMove();
		}
		
		protected function onCloseClick(event:MouseEvent):void
		{
			// Event that will exit the game on mouse click
			stage.nativeWindow.close();
		}
		
		protected function onMinClick(event:MouseEvent):void
		{
			// Event that will just minimize the game
			stage.nativeWindow.minimize();
		}
		
		protected function onFullBtn(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("With the Power of GreySkull");
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
		}
		
		protected function onFullClick(event:FullScreenEvent):void
		{
			// Well put the game in full screen mode
			trace("I am He-man!!!!!");
			
			if(event.fullScreen)
			{
				// Draw top
				_tbg.graphics.beginFill(0);
				_tbg.graphics.drawRect(0,0,stage.nativeWindow.width, stage.nativeWindow.y);
				_tbg.graphics.endFill();
				
				// Draw right
				_rbg.graphics.beginFill(0);
				_rbg.graphics.drawRect(1024,0,stage.nativeWindow.width - 1024 , stage.nativeWindow.height);
				_rbg.graphics.endFill();
				
				// Draw bottom
				_bbg.graphics.beginFill(0);
				_bbg.graphics.drawRect(0,768,stage.nativeWindow.width, stage.nativeWindow.height - 768);
				_bbg.graphics.endFill();
				
				// Draw left
				_lbg.graphics.beginFill(0);
				_rbg.graphics.drawRect(0,0,0 , stage.nativeWindow.height);
				_lbg.graphics.endFill();
				
				// Move bar
				_bar.x = 0;
				_bar.width = stage.nativeWindow.width;
				trace(_bar.x);
				
				_min.visible = false;
				_close.visible = false;
				
				_full.addEventListener(MouseEvent.CLICK, onResize);
			}
			else
			{
				_bbg.graphics.clear();
			}
		}
		
		protected function onResize(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("I smaller");
			stage.nativeWindow.restore();
			_min.visible = true;
			_close.visible = true;
			_bar.width = stage.nativeWindow.width;
			_full.removeEventListener(MouseEvent.CLICK, onResize);
		}
	}
}