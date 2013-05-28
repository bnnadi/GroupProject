package com.wbarra.controller.hero
{
	import com.wbarra.controller.CustomStuff.KeyClass;
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.objects.PowerUp;
	
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	public class Hero extends Sprite
	{
		private var _ship:Image;
		private var _turret:Image;
		private var _maxSpeed:int = 5;
		// Instance of the Power Up class to access all of the stats
		private var _powerUp:PowerUp;
		
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
		
		
		// hugo messing with stuff 
		private var _ps:PDParticleSystem;
		
		public function Hero()
		{
			// I'm a ship 
			_ship = Image.fromBitmap(new AllMyImages.Ship());
			// setting the particle effect
			// =====
			_turret = Image.fromBitmap(new AllMyImages.Turret());
			_ship.x = this.width/2;
			_ship.y = this.height/2;
			_ship.scaleX = _ship.scaleY = .5; // just change this to get ship to original size. 
			addChild(_ship);
			_turret.width = _turret.width;
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
		}

		
		// Function used to increase the speed of the Hero based
		// on the speed up power up
		private function speedBoostCheck():void
		{
			
		}
		
		// This function is to check if the Hero is Alive
		// if not, then break out of the Play State
		public function isAlive(alive:Boolean):void
		{
			if(!alive)
			{
				trace('Gotta take the ship off the stage');
				trace('set the state to Over');
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

		public function get health():int
		{
			return _health;
		}

		public function set health(value:int):void
		{
			_health = value;
		}

		public function get alive():Boolean
		{
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}


	}
}
