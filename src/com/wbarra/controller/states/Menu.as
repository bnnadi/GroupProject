package com.wbarra.controller.states
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.interfaces.IState;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Menu extends Sprite implements IState
	{
		private var _game:Game;
		private var _background:Image;
		private var _play:Button;
		private var _options:Button;
		
		public function Menu(game:Game)
		{
			this._game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			_background = Image.fromBitmap(new AllMyImages.Background());
			addChild(_background);
			
			_play = new Button(Texture.fromBitmap(new AllMyImages.PlayButton()));
			_play.addEventListener(Event.TRIGGERED, onClickPlay);
			_play.x = stage.stageWidth*.5 - _play.width - 50;
			_play.y = 400;
			addChild(_play);
			
			_options = new Button(Texture.fromBitmap(new AllMyImages.OptionsButton()));
			_options.addEventListener(Event.TRIGGERED, onClickOptions);
			_options.x = stage.stageWidth*.5 + 50;
			_options.y = 400;
			addChild(_options);
		}
		
		private function onClickOptions(event:Event):void
		{
			trace('options');
		}
		
		private function onClickPlay(event:Event):void
		{
			_game.changeState(Game.PLAY_STATE);
			destroy()
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
			while(this.numChildren > 0)
			{
				removeChildAt(0);
			}
		}
	}
}