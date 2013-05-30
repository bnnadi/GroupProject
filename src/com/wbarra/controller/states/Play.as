package com.wbarra.controller.states
{
	import com.wbarra.controller.EnemyShips.EnemyOne;
	import com.wbarra.controller.EnemyShips.EnemyThree;
	import com.wbarra.controller.EnemyShips.EnemyTwo;
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.hero.Hero;
	import com.wbarra.controller.interfaces.IState;
	import com.wbarra.controller.objects.Bullet;
	import com.wbarra.controller.objects.PowerUp;
	
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		private var _battleField:Sprite;
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
		private var _distanceBulletEnemyOne:Number;
		private var _distanceBulletEnemyTwo:Number;
		private var _distanceBulletEnemyThree:Number;
		
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
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;
		private var _pBullet:Point;
		private var _shootTimer:Timer;
		
		
		private var _shipDistanceX:Number;
		private var _shipDistanceY:Number;
		private var _bullDistanceX:Number;
		private var _bullDistanceY:Number;
		
		private var _e1Distance:Number;
		// Power Up Distance and Collision Detection
		private var _pSpeedUp:Point;
		private var _pSlowDown :Point;
		private var _pHealthUp:Point;
		private var _pDoubleShot:Point;
		private var _distanceSpeedUp:Number;
		private var _distanceSlowDown:Number;
		private var _distanceHealthDrop:Number;
		private var _distanceDoubleShot:Number;
		private var _powerUp:PowerUp;
		private var _totalScore:uint = 0;
		
		// bullet realted
		private var _bulletHolder:Array = [];
		private var _canFire:Boolean = true; // Tracks whether enough time has elapsed since last bullet.
		private var _firing:Boolean = false; // Tracks whether the mouse is currently down, for machine-gun.
		private var _bulletCounter:uint = 0;
		
		private var _killGame:Boolean = true;
		
		// WAVE COUNTER & ENEMY COUNTER
		private var _waveCounter:uint = 1;
		private var _e1BaseSpawn:uint = 3;
		private var _e2BaseSpawn:uint = 5;
		private var _e3BaseSpawn:uint = 10;
		
		public function Play(game:Game)
		{
			this._game = game;
			//***************EVENT LISTENER******************
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			
			if(touch)
			{
				_lastMouseX = touch.globalX;
				_lastMouseY = touch.globalY;
				
				if(_canFire && touch.phase == TouchPhase.BEGAN)
				{
					_firing = true;
					fireBullet(touch.globalX,touch.globalY);
				}
				
				if(touch.phase == TouchPhase.ENDED)
				{
					_firing = false;
				}
			}
		}
		
		private function resetFiring():void
		{
			_canFire = true;
		}
		
		private function fireBullet(xParam:Number,yParam:Number):void
		{
			_canFire = false;
			setTimeout(resetFiring,100);
			
			
			_bulletHolder[_bulletCounter].x = _hero.x;
			_bulletHolder[_bulletCounter].y = _hero.y;
			// calculate the firing angle 
			_bulletHolder[_bulletCounter].targetY = yParam;
			_bulletHolder[_bulletCounter].targetX = xParam;
			_bulletHolder[_bulletCounter].alive = true
			stage.addChild(_bulletHolder[_bulletCounter]);
			_bulletCounter ++;
			if (_bulletCounter >= 100)
			{
				_bulletCounter = 0;
			}
		}
		
		private function onAdded():void
		{
			// adding the event listener to the stage
			//***************EVENT LISTENER******************
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// creating a enw canvas. 
			_battleField = new Sprite();
			stage.addChild( _battleField );
			
			_background = Image.fromBitmap(new AllMyImages.Background());
			_battleField.addChild(_background);
			
			_hero = new Hero();
			_hero.x = stage.stageWidth/2
			_hero.y = stage.stageHeight/2;
			_battleField.addChild( _hero);
			
			//building a bunch of test enemies of class Enemy one
			var spacer:Number = 10;
			// ENEMY 1 
			for (var e1:int = 0; e1 < (_e1BaseSpawn*_waveCounter); e1++)
			{
				// spawning enemy One
				_enemyOne = new EnemyOne();
				_enemyOne.scaleX = _enemyOne.scaleY = .5;
				_battleField.addChild( _enemyOne );
				
				// pushing into enemy array 
				_enemyOneHolder.push(_enemyOne);
				//				trace(_enemyOneHolder.length);
			}
			// ENEMY 2 

			for (var e2:int = 0; e2 < (_e2BaseSpawn*_waveCounter); e2++)

			{
				// spawning enemy two
				_enemyTwo = new EnemyTwo();
				_enemyTwo.scaleX = _enemyTwo.scaleY = .5;
				_battleField.addChild( _enemyTwo);
				
				// pushing into enemy array 
				_enemyTwoHolder.push(_enemyTwo);
				//				trace(_enemyTwoHolder.length);
			}
			// ENEMY 3 
			for (var e3:int = 0; e3 < (_e3BaseSpawn*_waveCounter); e3 ++ )
			{
				// spawning enemy three
				_enemyThree = new EnemyThree();
				_enemyThree.scaleX = _enemyThree.scaleY = .5;
				_enemyThree.x = spacer;
				_battleField.addChild( _enemyThree);
				
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
			if(_firing && _canFire){
				fireBullet(_lastMouseX,_lastMouseY);
			}
			// moving the bullet 
			for each (var bullet:Bullet in _bulletHolder) 
			{
				bullet.bulletTargetingSystem()
				_pBullet = new Point(bullet.x, bullet.y);
				_radBullet = bullet.width/2;
				
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
			for each (var e1:EnemyOne in _enemyOneHolder) 
			{
				
				if(e1.alive)
				{
					e1.enemyMove( (_hero.x  ), (_hero.y ));
					// collision detection for enemy One
					// this is the working model for collision detection. 
					// use this model to build the rest of the collision detection system
					if(_hero.x > e1.x){
						_shipDistanceX = _hero.x - e1.x;
					}else{
						_shipDistanceX =  e1.x - _hero.x;
					}
					if(_hero.y > e1.y){
						_shipDistanceY = _hero.y - e1.y;
					}else{
						_shipDistanceY = e1.y - _hero.y;
					}
					if (_shipDistanceX <= 25 && _shipDistanceY <= 25)
					{
						shipHit();
						_battleField.removeChild( e1 );
						e1.alive = false;
					}
					// BULLET SHOT TEST
					// Bullet collisioin with the enemy ships
					for each (var b:Bullet in _bulletHolder) 
					{
						if (b.alive)
						{
							if (b.x > e1.x)
							{
								_bullDistanceX = b.x - e1.x;
							}
							else
							{
								_bullDistanceX = e1.x - b.x;
							}
							if (b.y > e1.y)
							{
								_bullDistanceY = b.y - e1.y;
							}
							else
							{
								_bullDistanceY = e1.y - b.y;
							}
							if (_bullDistanceX <= 24 && _bullDistanceY <= 25)
							{
								_battleField.removeChild( e1 );
								_battleField.removeChild( b );
								e1.alive = false;
							}
						}
					}
				}
			}
			//=======================================================
			
			//Moving EnemyTwo on the stage. 
			//=======================================================
			for each (var e2:EnemyTwo in _enemyTwoHolder)
			{
				if(e2.alive)
				{
					e2.enemyMove();
					
					if(_hero.x > e2.x)
					{
						_shipDistanceX = _hero.x - e2.x;
					}else{
						_shipDistanceX =  e2.x - _hero.x;
					}
					if(_hero.y > e2.y)
					{
						_shipDistanceY = _hero.y - e2.y;
					}else
					{
						_shipDistanceY = e2.y - _hero.y;
					}
					if (_shipDistanceX <= 25 && _shipDistanceY <= 25)
					{
						shipHit();
						_battleField.removeChild( e2 );
						e2.alive = false;
					}
					// BULLET SHOT TEST
					for each (var bull:Bullet in _bulletHolder) 
					{
						if (bull.alive)
						{
							if (bull.x > e2.x)
							{
								_bullDistanceX = bull.x - e2.x;
							}
							else
							{
								_bullDistanceX = e2.x - bull.x;
							}
							if (bull.y > e2.y)
							{
								_bullDistanceY = bull.y - e2.y;
							}
							else
							{
								_bullDistanceY = e2.y - bull.y;
							}
							if (_bullDistanceX <= 24 && _bullDistanceY <= 25)
							{
								_battleField.removeChild( e2 );
								_battleField.removeChild( bull );
								e2.alive = false;
							}
						}
					}
				}
			}

			//Moving EnemyThree on the stage. 
			//=======================================================
			for each (var e3:EnemyThree in _enemyThreeHolder)
			{
				if(e3.alive)
				{
					e3.enemyMove();	
					if(_hero.x > e3.x){
						_shipDistanceX = _hero.x - e3.x;
					}else{
						_shipDistanceX =  e3.x - _hero.x;
					}
					if(_hero.y > e3.y){
						_shipDistanceY = _hero.y - e3.y;
					}else{
						_shipDistanceY = e3.y - _hero.y;
					}
					if (_shipDistanceX <= 25 && _shipDistanceY <= 25)
					{
						shipHit();
						_battleField.removeChild( e3 );
						e3.alive = false;
					}
				}
				// BULLET SHOT TEST
				for each (var bulls:Bullet in _bulletHolder) 
				{
					if (bulls.alive)
					{
						if (bulls.x > e3.x)
						{
							_bullDistanceX = bulls.x - e3.x;
						}
						else
						{
							_bullDistanceX = e3.x - bulls.x;
						}
						if (bulls.y > e3.y)
						{
							_bullDistanceY = bulls.y - e3.y;
						}
						else
						{
							_bullDistanceY = e3.y - bulls.y;
						}
						if (_bullDistanceX <= 24 && _bullDistanceY <= 25)
						{
							_battleField.removeChild(e3);
							_battleField.removeChild( bulls );
							e3.alive = false;
						}
					}
				}
			}
			// =======================================================
			// DO NOT MESS WITH THIS CRAP----- WILL BE IMPLEMENTED IF TIME 
			// ALLOWS FOR IT
			// Setting the points for the power ups
			//========================================================
			/*_pHealthUp = new Point(_powerUp.x, _powerUp.y);
			_distanceHealthDrop = Point.distance(_pHero, _pHealthUp);
			
			_pSpeedUp = new Point(_powerUp.x, _powerUp.y)
			_distanceSpeedUp = Point.distance(_pHero, _pSpeedUp);
			
			_pSlowDown = new Point(_powerUp.x, _powerUp.y);
			_distanceSlowDown = Point.distance(_pHero, _pSlowDown);
			
			_pDoubleShot = new Point(_powerUp.x, _powerUp.y);
			_distanceDoubleShot = Point.distance(_pHero, _pDoubleShot);
			
			*/
			//========================================================sgit 
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
				destroy();
				killGame();
			}
			else if(_hero.health > 5)
			{
				_hero.health = 5;
			}
			else
			{
				_hero.health -= _damage;
				trace(_hero.health);
				_hero.alive = true;
			}
		}
		
		public function update():void
		{
			if(!_hero.alive)
			{
				trace('running the update()');
				destroy();
			}
		}
		
		public function destroy():void
		{
			//			if either the changeState() is called.
			while(_battleField.numChildren > 0)
			{
				_battleField.removeChildAt(0);				
				
				for each (var i:Bullet in _bulletHolder) 
				{
					_battleField.removeChild(i);
				}
				_enemyOneHolder 	= null;
				_enemyTwoHolder 	= null;
				_enemyThreeHolder 	= null;
				_bulletHolder 		= null;
				
			}
			
			if(_battleField.numChildren == 0)
			{
				trace('should not be running multiple times');
				killGame();
			}
		}
		
		private function killGame():void
		{
			trace('WTF!!!!');
			if(_killGame)
			{
				trace('testing the killGame()');
				_killGame = false;
				// REMOVING ALL THE EVENT HANDLERS ON THE STAGE
				_battleField.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
				_battleField.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_battleField.removeEventListener(TouchEvent.TOUCH, onTouch);
//				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);

				_game.changeState(Game.GAME_OVER_STATE);
			}
		}
	}
}