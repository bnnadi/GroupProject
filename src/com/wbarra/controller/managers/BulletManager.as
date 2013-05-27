package com.wbarra.controller.managers
{
	import starling.display.Sprite;
	import com.wbarra.controller.objects.Bullet;

	public class BulletManager extends Sprite
	{
		private var _maxBullets:int;
		private var _index:int = 0;
		private var _bulltsLsts:Array = [];
		private var _cllsonLstsLsts:Array = [];
		
		public function BulletManager(n:int = 1000)
		{
			super();
			_maxBullets = n;
		}
		
		public function setup():void
		{
			for(var i:int; i< _maxBullets; i++)
			{
				_bulltsLsts.push(new Bullet());
			}
		}
		
		public function Create(/*who:String, */ vx:Number, vy:Number):Bullet
		{
			var bullets:Bullet = _bulltsLsts[_index];
			bullets.vx = vx;
			bullets.vy = vy;
			bullets.alive = true;
			bullets.id = _index;
			
			_index++;
			if(_index == _maxBullets)
			{
				_index = 0;
			}
			return bullets;
		}
		
		public function updateAll():void
		{
			for each (var b:Bullet in _bulltsLsts) 
			{
				if(b.alive == true)
				{
					b.update();
				}
			}
		}
		
		public function removeBullet(b:Bullet):void
		{
			b.parent.removeChild(b);
			b.alive = false;
		}
		
		public function get cllsonLstsLsts():Array
		{
			return _cllsonLstsLsts;
		}
		
		public function set cllsonLstsLsts(value:Array):void
		{
			_cllsonLstsLsts = value;
		}
		
	}
}