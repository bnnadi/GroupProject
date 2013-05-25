package com.wbarra.controller.hero
{
	import com.wbarra.controller.CustomStuff.KeyClass;
	import com.wbarra.controller.allMyImages.AllMyImages;
	
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	
	public class Hero extends Sprite
	{
		private var ship:Image;
		private var turret:Image;
		private var _maxSpeed:int = 5;
		private var changeX:Number;
		private var changeY:Number;
		public static var mouseX:Number;
		public static var mouseY:Number;
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private static const ACCEL:Number = 0.5;
		private static const FRICTION:Number = 0.98;
		
		public function Hero()
		{
			super();
			// I'm a ship 
			ship = Image.fromBitmap(new AllMyImages.Ship());
			turret = Image.fromBitmap(new AllMyImages.Turret());
			ship.x = this.width/2;
			ship.y = this.height/2;
			addChild(ship);
			turret.pivotX = turret.width/2;
			turret.pivotY = turret.height/2;
			turret.x = this.width/2 - turret.x;
			turret.y = this.height/2 - turret.y;
			addChild(turret);
			
			update();
		}
		public function update():void
		{
			updateSpeed();
			updateX();
			updateY();
			updateRotation();
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
			}else{
				_speedY *= FRICTION;
			}
		}
		private function updateRotation():void
		{
			changeX = mouseX - (this.x + 50);
			changeY = mouseY - (this.y + 50);
			this.turret.rotation = deg2rad(90) + Math.atan2(changeY, changeX);
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