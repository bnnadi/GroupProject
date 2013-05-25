package com.wbarra.controller.managers
{
	import com.wbarra.controller.objects.Bullet;

	public class BulletManager
	{
		private var _bulletsArr:Array = [];
		private var _bullet:Bullet;
		private var _maxBullets = 1000;
		private var _index:int = 0;
		
		public function BulletManager()
		{
			initBullets();
		}
		
		private function initBullets():void
		{
			// Setup the bullets
			for(var i:int; i < _maxBullets; i++)
			{
				_bullet = new Bullet();
				_bulletsArr.push(_bullet);
			}
		}
		
		
	}
}