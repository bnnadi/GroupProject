package com.wbarra.controller.objects
{
	import com.wbarra.controller.hero.Hero;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Bullet extends Sprite
	{
		private var _bullet:Image;
		public var vx:Number = 0;
		public var vy:Number = 0;
		private var _pcos:Number;
		private var _psin:Number;
		private var _startX:Number;
		private var _startY:Number;
		private var _bulletSpread:int;
		private var _bulletSpeed:Number;
		private var _endX:int;
		private var _endY:int;
		private var _turret:Hero;
		private var _maxDistance:Number;
		private var _bullets:Array = [];
		
		
		public function Bullet()
		{
			super();
			// precalculate the cos & sine
			_pcos = Math.cos(_turret.rotation * Math.PI / 180);
			_psin = Math.sin(_turret.rotation * Math.PI / 180);
			
			// start X & Y
			// calculate the tip of the barrel
			_startX = _turret.x * _pcos;
			_startY = _turret.y * _psin;
			
			// end X & Y
			// calculate where the bullet needs to go
			// aim 50 pixels in front of the gun
			_endX = _turret.x - 50 * _pcos + Math.random() * _bulletSpread - _bulletSpread * .5;
			_endY = _turret.y - 50 * _psin + Math.random() * _bulletSpread - _bulletSpread * .5;
			setup();
		}
		
		private function setup():void
		{
			// Creating the bullet using the image
			_bullet = Image.fromBitmap(new AllMyImages.BulletImg());
				
				// calculate velocity
			this.vx = (_endX - _startX) / _bulletSpeed;
			this.vy = (_endY - _startY) / _bulletSpeed;
			
			// set position
			_bullet.x = _startX;
			_bullet.y = _startY;
			
			// save starting location
			_bullet.startX = _startX;
			_bullet.startY = _startY;
			
			// set maximum allowed travel distance
			_bullet.maxDistance = _maxDistance;
			
			// add bullet to bullets array
			_bullets.push(_bullet);
			
			// add to display list
			stage.addChild(_bullet);
		}
		
		public function update():void
		{
			this.x += vx;
			this.y += vy;
		}
	}
}
