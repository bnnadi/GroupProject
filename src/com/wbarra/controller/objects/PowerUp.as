package com.wbarra.controller.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PowerUp extends Sprite
	{
		public static const SPEED_UP:int = 2;
		private var _speedImg:Image;
	
		public static const SLOW_DOWN:int = 2;
		private var _slowImg:Image;
		
		public static const DOUBLE_SHOT:int;
		private var _doubleImg:Image;
		
		public static const HEALTH_DROP:int = 1;
		private var _healthImg:Image;
		
		private var _powerUpHolder:Array = [];
		private var _index:int = 10;
		
		public function PowerUp()
		{
			super();
			init();
		}
		
		private function init():void
		{
			for(var i:int = 1; i < _index; i++)
			{
				
			}
		}
	}
}