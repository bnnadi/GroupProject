package com.wbarra.controller.states
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.interfaces.IState;
	
	import feathers.data.XMLListListCollectionDataDescriptor;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class Menu extends Sprite implements IState
	{
		private var _game:Game;
		private var _background:Image;
		private var _play:Button;
		private var _options:Button;
		private var _optionsR:Button;
		private var _titleImg:Image;
		private const _psConfig:XML =  XML(new AllMyParticles.titleEffect());
		private const _psTexture:Texture = Texture.fromBitmap(new AllMyParticles.titlEffectImg());
		private const _titlePS:PDParticleSystem = new PDParticleSystem(_psConfig, _psTexture);
		private const _instructions:Image = Image.fromBitmap(new  AllMyImages.instructions());
		
		public function Menu(game:Game)
		{
			this._game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			_background = Image.fromBitmap(new AllMyImages.Background());
			_background.y = 50;
			addChild(_background);
			
			// adding the particle effects
			_titlePS.y = 225;
			
			_titlePS.emitterX = 0;
			_titlePS.emitterY = 0;
			addChild( _titlePS );
			Starling.juggler.add( _titlePS );
			_titlePS.start();
			
			
			_titleImg = Image.fromBitmap (new AllMyImages.titleImg());
			_titleImg.x = 220;
			_titleImg.y = 200;
			addChild( _titleImg );
			
			
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
			_titlePS.stop();
			
			addChild( _instructions );
			_optionsR = new Button(Texture.fromBitmap(new AllMyImages.OptionsButton()));
			_optionsR.addEventListener(Event.TRIGGERED, onClickOptionsR);
			_optionsR.x = stage.stageWidth*.5;
			_optionsR.y = 600;
			addChild(_optionsR);
			
			
		}
		
		private function onClickOptionsR():void
		{
			removeChild( _instructions);
			removeChild( _optionsR);
			_titlePS.start();
		}
		
		private function onClickPlay(event:Event):void
		{
			_titlePS.stop();
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
				
				removeEventListeners(Event.TRIGGERED);
				removeEventListener(Event.ADDED_TO_STAGE, init);

			}
		}
	}
}