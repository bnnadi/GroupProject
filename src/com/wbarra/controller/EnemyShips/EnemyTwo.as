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
	
	public class EnemyTwo extends Sprite
	{
		private var _speedX:Number = Math.random()*Math.PI;
		private var _speedY:Number = Math.random()*Math.PI;
		private var _alive:Boolean;
		private var _randX:Number;
		private var _randY:Number;
		private var _mc:MovieClip;
		private var _ps:PDParticleSystem;
		public function EnemyTwo()
		{
			// you could call me a bouncy ball
			super();
			var texture:Texture = Texture.fromBitmap(new AllMyTexturePackerTextures.enemiesImage());
			var xml:XML = XML(new AllMyTexturePackerTextures.enemiesXML());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			_mc= new MovieClip(atlas.getTextures("enemy2"), 30);
			addChild(_mc);
			Starling.juggler.add(_mc);
			
			
			_alive = true;
			// calling spawn point function 
			spawnPoint();
		}
		private function spawnPoint():void
		{
			// I set the spawn point of the ship somewhere in the stage. 
			var tempVar:Number;
			x = Math.random()*874+50;
			// randomizing either top or bottom placement of the object
			var placementVar:Boolean;
		
			placementVar = Math.random() < 0.5;
			
			// setting my placement either coming from the top 
			if (placementVar)
			{
				y = Math.random()*50+640;
			}
//				 or from the bottom 
			else 
			{
				y = Math.random()*10+50;
			}
		}
		
		public function enemyMove():void
		{
			if (_alive)
			{

//				_changeX = _randX - x;
//				_changeY = _randY - y;
				
//				_angle =Math.atan2(x, y) * (180/ Math.PI);
//				_rads = _angle * Math.PI/180;
//				x += (Math.cos(_rads) * _speedX);
//				y += (Math.sin(_rads) * _speedY);
				
				x += _speedX;
				y += _speedY;
				
				if (x <= 50 || x >= 874)
				{
					_speedX *= -1;
				}
				if (y <= 50 || y >= 700)
				{
					_speedY *= -1;
				}
			}
		}
	}
}