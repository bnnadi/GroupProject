package com.wbarra.controller.objects
{
	import com.wbarra.controller.allMyStuff.AllMyImages;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Bullet extends Sprite
	{
		private var _alive:Boolean = false;
		private var _posX:Number;
		private var _posY:Number;
		private var _speed:Number = 10;
		private var _changeX:Number;
		private var _changeY:Number;
		private var _angle:Number;
		private var _rads:Number;
		private var _distX:Number;
		private var _distY:Number;
		private var _targetX:Number;
		private var _targetY:Number;
		private var _onceOver:Boolean = true;;
		
		public function Bullet(alive:Boolean = false)
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}

		public function get onceOver():Boolean
		{
			return _onceOver;
		}

		public function set onceOver(value:Boolean):void
		{
			_onceOver = value;
		}

		public function get alive():Boolean
		{
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		public function get targetY():Number
		{
			return _targetY;
		}

		public function set targetY(value:Number):void
		{
			_targetY = value;
		}

		public function get targetX():Number
		{
			return _targetX;
		}

		public function set targetX(value:Number):void
		{
			_targetX = value;
		}

		public function onAdded():void
		{
			var bullet:Image = Image.fromBitmap(new AllMyImages.BulletImg());
			scaleX = scaleY = .5;
			addChild(bullet);
			_alive = alive;
		}
		public function bulletTargetingSystem():void
		{
			
			if (_alive == true)
			{
				
				if (_onceOver)
				{
					_changeX  = targetX - x;
					_changeY  = targetY - y;
					_angle    = Math.atan2(_changeY, _changeX) * (180/ Math.PI) ;
					_rads     = _angle * Math.PI /180;
					
					_onceOver = false;
				}
				x += Math.cos(_rads) * _speed;
				y += Math.sin(_rads) * _speed;
				
				if (x > 1024 || x < 0)
				{
					_alive = false;	
					parent.removeChild( this );
					_onceOver = true;
				}
				if (y > 768 || y < 0)
				{
					_alive = false;	
					_onceOver = true;
					parent.removeChild( this );
				}
				
			}// end if 
		}
	}
}