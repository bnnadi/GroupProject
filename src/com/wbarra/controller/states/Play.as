package com.wbarra.controller.states
{
	import com.wbarra.controller.EnemyShips.EnemyOne;
	import com.wbarra.controller.EnemyShips.EnemyThree;
	import com.wbarra.controller.EnemyShips.EnemyTwo;
	import com.wbarra.controller.objects.Bullet;
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.hero.Hero;
	import com.wbarra.controller.interfaces.IState;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Play extends Sprite implements IState
	{
		/***************************/
		// This variable will take us back to the Play State
		// so we can switch back to Menu or Over states
		private var _game:Game;
		/***************************/
		private var _background:Image;
		
		private var _hero:Hero;
		private var _damage:int = 1;
		private var _enemyOne:EnemyOne;
		private var _enemyTwo:EnemyTwo;
		private var _enemyThree:EnemyThree;
		private var _enemyOneHolder:Array = [];
		private var _enemyTwoHolder:Array = [];
		private var _enemyThreeHolder:Array = [];
		
		// getting the hero's X/Y position to pass into the Enemy One for Targeting.
		private var _heroX:Number; 
		private var _heroY:Number;
		
		//getting the distance between our moving circles
		private var _distX:Number;
		private var _distY:Number;
		private var _distanceEnemyOne:Number;
		private var _distanceEnemyTwo:Number;
		private var _distanceEnemyThree:Number;
		private var _distanceBullet:Number;
		
		// collision detection 
		private var _pHero:Point;
		private var _pEnemyOne:Point;
		private var _pEnemyTwo:Point;
		private var _pEnemyThree:Point;
		private var _radHero:Number;
		private var _radEnemyOne:Number;
		private var _radEnemyTwo:Number;
		private var _radEnemyThree:Number;
		private var _radBullet:Number;
		private var _mx:Number;
		private var _my:Number;
		private var _pBullet:Point;
		
		// bullet realted
		private var _bulletHolder:Array = [];
		private var _firing:Boolean = false;
		private var _bulletCounter:uint = 0;
		
		public function Play(game:Game)
		{
			this._game = game;
			trace("ran");
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					_firing = true;
					bulletFire();
					_mx = touch.globalX;
					_my = touch.globalY;
				}
					
				else if(touch.phase == TouchPhase.ENDED)
				{
					_firing = false;
					
				}
					
				else if(touch.phase == TouchPhase.MOVED)
				{
					
				}
			}
		}		
		
		private function bulletFire():void{
		{
			
			_bulletHolder[_bulletCounter].x = _hero.x;
			_bulletHolder[_bulletCounter].y = _hero.y;
			// calculate the firing angle 
			_bulletHolder[_bulletCounter].targetY = _my;
			_bulletHolder[_bulletCounter].targetX = _mx;
			_bulletHolder[_bulletCounter].alive = true;
			stage.addChild(_bulletHolder[_bulletCounter]);
			_bulletCounter ++;
			if (_bulletCounter >= 100)
			{
				_bulletCounter = 0;
			}
		}			
		}
		private function onAdded():void
		{
			// adding the event listener to the stage
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			
			_background = Image.fromBitmap(new AllMyImages.Background());
			addChild(_background);
			
			_hero = new Hero();
			_hero.x = stage.stageWidth/2
			_hero.y = stage.stageHeight/2;
			addChild( _hero);
			
			//building a bunch of test enemies of class Enemy one
			var spacer:Number = 10;
			// ENEMY 1 
			for (var e1:int = 0; e1 < 10; e1++)
			{
				// spawning enemy One
				_enemyOne = new EnemyOne();
				_enemyOne.scaleX = _enemyOne.scaleY = .5;
				addChild( _enemyOne );
				
				// pushing into enemy array 
				_enemyOneHolder.push(_enemyOne);
//				trace(_enemyOneHolder.length);
			}
			// ENEMY 2 
			for (var e2:int = 0; e2 < 10; e2++)
			{
				// spawning enemy two
				_enemyTwo = new EnemyTwo();
				_enemyTwo.scaleX = _enemyTwo.scaleY = .5;
				addChild( _enemyTwo);
				
				// pushing into enemy array 
				_enemyTwoHolder.push(_enemyTwo);
//				trace(_enemyTwoHolder.length);
			}
			// ENEMY 3 
			for (var e3:int = 0; e3 < 30; e3 ++ )
			{
				// spawning enemy three
				_enemyThree = new EnemyThree();
				_enemyThree.scaleX = _enemyThree.scaleY = .5;
				_enemyThree.x = spacer;
				addChild( _enemyThree);
				
				// pushing into enemy array 
				_enemyThreeHolder.push(_enemyThree);
				spacer += _enemyThree.width + 10;
//				trace(_enemyThreeHolder.length);
			}
			
			// building the bullets 
			for (var f:int = 0; f < 100; f++)
			{
				var bullet:Bullet = new Bullet(false);
				_bulletHolder.push( bullet );
			}
		}
		
		private function onEnterFrame():void
		{
			// moving the bullet 
			for each (var bullet:Bullet in _bulletHolder) 
			{
				bullet.bulletTargetingSystem()
				_pBullet = new Point(bullet.x, bullet.y);
				_radBullet = bullet.width/2;
				
				if (_distanceBullet < _radBullet + _radEnemyOne)
				{
					trace("enemy one hit");
				}
				if (_distanceBullet < _radBullet + _radEnemyTwo)
				{
					trace("enemy two hit");
				}
				if (_distanceBullet < _radBullet + _radEnemyThree)
				{
					trace("enemy three hit");
				}
			}
			
			// moving the Hero
			//=======================================================
			_hero.update();
			//=======================================================
			
			// testing the collisions
			_pHero = new Point( (_hero.x) , (_hero.y) );// breaking when we add the height and the width 
			_radHero= _hero.width / 2;
			
			//Moving EnemyOne on the stage. 
			//=======================================================
			for each (var e:EnemyOne in _enemyOneHolder) 
			{
				e.enemyMove( (_hero.x  ), (_hero.y ));// breaks when i account for the height and the width 
				// somethingto do with the mouse coming onto the stage. 
				// collision detection for enemy One
				_radEnemyOne = e.width / 2;
				_pEnemyOne = new Point(e.x, e.y);
				_distanceEnemyOne = Point.distance(_pHero, _pEnemyOne);
				if (_distanceEnemyOne < _radHero + _radEnemyOne)
				{
					shipHit();
				}
			}
			//=======================================================
			
			//Moving EnemyTwo on the stage. 
			//=======================================================
			for each (var d:EnemyTwo in _enemyTwoHolder)
			{
				d.enemyMove();
				_radEnemyTwo = d.width/2;
				_pEnemyTwo = new Point(d.x, d.y);
				_distanceEnemyTwo = Point.distance(_pHero, _pEnemyTwo);
				
				if (_distanceEnemyTwo < _radHero + _radEnemyTwo)
				{
					shipHit();
				}
			}
			
			
			//Moving EnemyThree on the stage. 
			//=======================================================
			for each (var f:EnemyThree in _enemyThreeHolder)
			{
				f.enemyMove();	
				_radEnemyThree = f.width/2;
				_pEnemyThree = new Point(f.x, f.y);
				
				_distanceEnemyThree = Point.distance(_pHero, _pEnemyThree);
				if (_distanceEnemyThree < _radHero + _radEnemyThree)
				{
					shipHit();
				}
			}
		}
		
		private function shipHit():void
		{
			// Trying to get the _hero.health to break us
			// out of the Play State ---- The changeState(), is 
			// the last method in this class.
//			trace("hit");
//			trace('hero health: '+_hero.health);
			
			if(_hero.health <= 0)
			{
				_hero.alive = false;
//				_hero.isAlive(_hero.alive);
//				destroy();
//				killGame();
				// If the destroy() and the killGame() are running,
				// this is the error code we get:
				// Error #3691: Resource limit for this resource type exceeded.
				//WTF!?!!
			}
			else if(_hero.health > 5)
			{
				_hero.health = 5;
			}
			else
			{
				_hero.health -= _damage;
				_hero.alive = true;
			}
		}
		
		public function update():void
		{
			if(!_hero.alive)
			{
//				trace('running the update()');
				destroy();
			}
		}
		
		public function destroy():void
		{
			// Removing all children from the screen, yet somehow there
			// is still colision happening. It is breaking the game 
			// if either the changeState() is called.
//			if(this.numChildren > 0)
//			{
//				trace('testing the destroy()');
//				this.removeChildAt(0);				
//				trace(this.numChildren);
//			}
//			else
//			{
//				trace('times');
//				killGame();
//			}
		}
		
		private function killGame():void
		{
			trace('testing the killGame()');
			_game.changeState(Game.GAME_OVER_STATE);
		}
	}
}