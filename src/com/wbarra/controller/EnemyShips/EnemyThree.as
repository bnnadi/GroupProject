package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyStuff.AllMyTexturePackerTextures;
	
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;
	
	public class EnemyThree extends Sprite
	{
		private var _speedX:Number = 3;
		private var _speedY:Number = 3;
		private var _alive:Boolean;
		private var _newX:Number;
		private var _newY:Number;
		private var _changeX:Number;
		private var _changeY:Number;
		private var _angle:Number;
		private var _rads:Number;
		private var _timer:Timer;
		private var _placementVar:Boolean;
		private var _mc:MovieClip;
	
		private static  var texture:Texture = Texture.fromBitmap(new AllMyTexturePackerTextures.enemiesImage());
		private static  var xml:XML = XML(new AllMyTexturePackerTextures.enemiesXML());
		private static var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		
		
		public function EnemyThree()
		{
			// I tracel in a line
			super();
			// test 
			
			_mc= new MovieClip(atlas.getTextures("enemy3"), 30);
			addChild(_mc);
			Starling.juggler.add(_mc);
			_mc.pivotX = _mc.width  / 2.0;
			_mc.pivotY =  _mc.height / 2.0;
			_mc.rotation = deg2rad(180); // -> rotate around center
			
			// adding the particle effects
//			// 1
//			var psConfig:XML = XML(new AllMyParticles.PE3Down());
//			var psTexture:Texture = Texture.fromBitmap(new AllMyParticles.PIE3Down());
//			_psUp = new PDParticleSystem(psConfig, psTexture);
//			_psUp.x = 0;
//			_psUp.y = 0;
//			_psUp.emitterX = 0;
//			_psUp.emitterY = 0;
//			addChild( _psUp );
//			Starling.juggler.add( _psUp );
			
			_alive = true;	
			spawnPoint();
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		public function get alive():Boolean
		{
			return _alive;
		}

		private function spawnPoint():void
		{
			// spawn point on the bottom of the stage 
			var tempVar:Number;
			_placementVar = Math.random() < 0.5;
			y =  740;
		}
		public function enemyMove():void
		{
			y += _speedY;
			if (y >= 750)
			{
				_speedY *= -1;
				_mc.rotation += deg2rad(180); 
			}
			if (y <= 0)
			{
				_speedY *= -1;
				_mc.rotation += deg2rad(180); 
			}
		}
	}
}