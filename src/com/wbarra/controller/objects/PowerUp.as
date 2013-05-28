package com.wbarra.controller.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PowerUp extends Sprite
	{
		private var _speedUp:int = 2;
		private var _speedImg:Image;
	
		private var _slowDown:int = 2;
		private var _slowImg:Image;
		
		private var _doubleShot:int;
		private var _doubleImg:Image;
		
		private var _healthDrop:int = 1;
		private var _healthImg:Image;
		
		public function PowerUp()
		{
			super();
		}

		public function set speedUp(value:int):void
		{
			_speedUp = value;
		}

		public function set slowDown(value:int):void
		{
			_slowDown = value;
		}

		public function set healthDrop(value:int):void
		{
			_healthDrop = value;
		}


	}
}