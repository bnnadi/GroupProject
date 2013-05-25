package com.wbarra.controller.Screens
{
	import com.wbarra.controller.EnemyShips.EnemyOne;
	import com.wbarra.controller.EnemyShips.EnemyTwo;
	import com.wbarra.controller.hero.Hero;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public class GameScreen extends Sprite
	{
		
		private var _hero:Hero;
		private var _enemyOne:EnemyOne;
		private var _enemyTwo:EnemyTwo;
		private var _enemyOneHolder:Array = [];
		private var _enemyTwoHolder:Array = [];
		
		// getting the hero's X/Y position to pass into the Enemy One for Targeting.
		private var _heroX:Number; 
		private var _heroY:Number;
		
		//getting the distance between our moving circles
		private var _distX:Number;
		private var _distY:Number;
		
		// collision detection 
		private var _p1:Point;
		private var _p2:Point;
		private var _p3:Point;
		private var _distance1:Number;
		private var _distance2:Number;
		private var _rad1:Number;
		private var _rad2:Number;
		private var _rad3:Number;
		
		public function GameScreen()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		private function onEnterFrame():void
		{
			
			// moving the Hero
			//=======================================================
			_hero.update();
			//=======================================================
			
			// testing the collisions
			_p1 = new Point( (_hero.x) , (_hero.y) );// breaking when we add the height and the width 
			_rad1= _hero.width / 2;
			
			
			//Moving EnemyOne on the stage. 
			//=======================================================
			for each (var e:EnemyOne in _enemyOneHolder) 
			{
				e.enemyMove( (_hero.x ), (_hero.y));// breaks when i account for the height and the width 
				// somethingto do with the mouse coming onto the stage. 
				// collision detection for enemy One
				_rad2 = e.width / 2;
				_p2 = new Point(e.x, e.y);
				_distance1 = Point.distance(_p1, _p2);
				if (_distance1 < _rad1 + _rad2)
				{
					trace("Collision 1")
				}
			}
			//=======================================================
			//^^^^^^^^^^^^^^ unfreeez this 	
			
			//Moving EnemyTwo on the stage. 
			//=======================================================
			for each (var d:EnemyTwo in _enemyTwoHolder)
			{
				d.enemyMove();
				_rad3 = d.width/2;
				_p3 = new Point(d.x, d.y);
				
				
				_distance2 = Point.distance(_p1, _p3);
				
				if (_distance2 < _rad1 + _rad3)
				{
					trace("Collision 2")
				}
			}
		
			
			
				
			
				
			
			
		}
		private function onAdded():void
		{
			_hero = new Hero();
			_hero.x = stage.stageWidth/2;
			_hero.y = stage.stageHeight/2;
			addChild( _hero);
			
			//building a bunch of test enemies of class Enemy one
			
			// FOR SOME REASON THIS IS BREAKING THE TRAJECTORIES
			for (var i:int = 0; i < 3; i++) 
			{
				// spawning enemy One
				_enemyOne = new EnemyOne();
				_enemyOne.scaleX = _enemyOne.scaleY = .5;
				addChild( _enemyOne );
				
				// spawning enemy two
				_enemyTwo = new EnemyTwo();
				_enemyTwo.scaleX = _enemyTwo.scaleY = .5;
				addChild( _enemyTwo);
				
				// pushing all enemy ones into an array
				_enemyOneHolder.push(_enemyOne);
				_enemyTwoHolder.push(_enemyTwo);
			}// end enemy Builder loop
			
			for each (var j:EnemyTwo in _enemyTwoHolder) 
			{
				for each(var k:EnemyTwo in _enemyTwoHolder)
				{
					_distX = j.x - k.x;
					_distY = j.y - k.y;
					if (!j)
					{
						if (_distX < 50 || _distY < 50)
						{
//								j.x += 1;
//								k.x -= 1;
						}
					}
					
				}
			}
			
		
		}
	}	
}