package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.allMyStuff.AllMyTexturePackerTextures;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class EnemyOne extends Sprite 
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
		private var _mc:MovieClip;
		private var _ps:PDParticleSystem;
		
		public function EnemyOne()
		{
			super();
			// I am  homing ship.
			
			// adding the texture 
			var texture:Texture = Texture.fromBitmap(new AllMyTexturePackerTextures.enemiesImage());
			var xml:XML = XML(new AllMyTexturePackerTextures.enemiesXML());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			_mc= new MovieClip(atlas.getTextures("enemy1"), 30);
			// look for a way to stop a movie clip on a frame 
			addChild(_mc);
			Starling.juggler.add(_mc);
			_alive = true;
			// calling spawn point function 
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
			// I set the spawn point of the ship somewhere in the stage. 
			var tempVar:Number;
			x = Math.random()*874+50;
			
			// randomizing either top or bottom placement of the object
			var placementVar:Boolean;
			for (var i:int = 0; i < 5; i++) 
			{
				placementVar = Math.random() < 0.5;
			}
			// setting my placement either coming from the top 
			if (placementVar)
			{
				y = Math.random()*50+718;
			}
			// or from the bottom 
			else 
			{
				y = Math.random()*50;
			}
		}
		public function enemyMove(heroX:Number, heroY:Number):void
		{
			if (_alive)
			{
				_changeX = heroX - x;
				_changeY = heroY - y;
				_angle = Math.atan2(_changeY, _changeX) * (180/ Math.PI);
				_rads = _angle * Math.PI/180;
				
				x += (Math.cos(_rads) * _speedX);
				y += (Math.sin(_rads) * _speedY);
			}// end alive if 
		}
	}
}