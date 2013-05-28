package com.wbarra.controller.hero
{
	import com.wbarra.controller.CustomStuff.KeyClass;
	import com.wbarra.controller.allMyStuff.AllMyImages;
<<<<<<< HEAD
=======
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.managers.BulletManager;
>>>>>>> d553a7c17845ed5f51d54b3d9c8968a51387a2a5
	
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
<<<<<<< HEAD
=======
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
>>>>>>> d553a7c17845ed5f51d54b3d9c8968a51387a2a5
	import starling.utils.deg2rad;
	
	public class Hero extends Sprite
	{
		private var _ship:Image;
		private var _turret:Image;
		private var _maxSpeed:int = 5;
		
		private var changeX:Number;
		private var changeY:Number;
		
		private var _changeX:Number;
		private var _changeY:Number;
		
		public static var mouseX:Number;
		public static var mouseY:Number;
		public static var click:TouchEvent;
		
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		
		private var _health:int = 5;
		private var _alive:Boolean = true;
		
		private static const ACCEL:Number = 0.5;
		private static const FRICTION:Number = 0.98;
		
		private var _speedBoost:PowerUp;
		
		// hugo messing with stuff 
		private var _ps:PDParticleSystem;
		
		public function Hero()
		{
			// I'm a ship 
			_ship = Image.fromBitmap(new AllMyImages.Ship());
			// setting the particle effect
			var psConfig:XML = XML(new AllMyParticles.PHero());
			var psTexture:Texture = Texture.fromBitmap(new AllMyParticles.PIHero());
			_ps = new PDParticleSystem(psConfig, psTexture);
			_ps.x = x+width/2;
			_ps.y = y+height/2;
			_ps.emitterX = 50;
			_ps.emitterY = 50;
			addChild( _ps );
			Starling.juggler.add( _ps );
			_ps.start();
			// =====
			_turret = Image.fromBitmap(new AllMyImages.Turret());
			_ship.x = this.width/2;
			_ship.y = this.height/2;
			addChild(_ship);
			_turret.pivotX = _turret.width/2;
			_turret.pivotY = _turret.height/2;
			_turret.x = this.width/2 - _turret.x;
			_turret.y = this.height/2 - _turret.y;
			addChild(_turret);
			
			update();
		}
		public function update():void
		{
			updateSpeed();
			updateX();
			updateY();
			updateRotation();
			isAlive();
			shooting();
		}
		
		private function shooting():void
		{
			if(click)
			{
<<<<<<< HEAD
				
=======
				_bm.Create(mouseX, mouseY);
>>>>>>> d553a7c17845ed5f51d54b3d9c8968a51387a2a5
			}
		}
		
		
		private function isAlive():void
		{
			if(_health < 1)
			{
				_alive = false;
			}
			else if(_health > 5)
			{
				_health = 5;
			}
			else
			{
				_alive = true;
			}
		}
		private function updateSpeed():void
		{
			// Hero X movement, based on AD
			if(KeyClass.Keys[Keyboard.A])
			{
				if(Math.abs(_speedX) < _maxSpeed){
					_speedX -= ACCEL;
				}else{
					_speedX = -_maxSpeed;
				}
				
			}else if(KeyClass.Keys[Keyboard.D])
			{
				if(Math.abs(_speedX) < _maxSpeed){
					_speedX += ACCEL;
				}else{
					_speedX = _maxSpeed;
				}
			}else{
				// creates friction so the hero slowly decreases speed
				//once a key is released
				_speedX *= FRICTION;
			}
			// Hero Y movement, based on WS
			if(KeyClass.Keys[Keyboard.W])
			{
				if(Math.abs(_speedY) < _maxSpeed){
					_speedY -= ACCEL;
				}else{
					_speedY = -_maxSpeed;
				}
			}else if(KeyClass.Keys[Keyboard.S])
			{
				if(Math.abs(_speedY) < _maxSpeed){
					_speedY += ACCEL;
				}else{
					_speedY = _maxSpeed;
				}
			}else
				// creates friction so the hero slowly decreases speed
				//once a key is released{
				_speedY *= FRICTION;
		}
		
		private function updateRotation():void
		{
			_changeX = mouseX - (this.x + 50);
			_changeY = mouseY - (this.y + 50);
			this._turret.rotation = deg2rad(90) + Math.atan2(_changeY, _changeX);
		}
		public function get speed():int
		{
			return _maxSpeed;
		}
		private function updateX():void
		{
			this.x += _speedX;
		}	
		private function updateY():void
		{
			this.y += _speedY;	
		}
	}
}
