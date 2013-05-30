package com.wbarra.controller.states
{
	import com.wbarra.controller.EnemyShips.EnemyOne;
	import com.wbarra.controller.EnemyShips.EnemyThree;
	import com.wbarra.controller.EnemyShips.EnemyTwo;
	import com.wbarra.controller.allMyStuff.AllMyImages;
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.hero.Hero;
	import com.wbarra.controller.interfaces.IState;
	import com.wbarra.controller.objects.Bullet;
	import com.wbarra.controller.objects.PowerUp;
	
	import flash.geom.Point;
	import flash.system.System;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	
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
		
		// BOOLS to check on game states
		private var _killGame:Boolean = true;
		private var _relaunchGame:Boolean = true;
		
		// WAVE COUNTER & ENEMY COUNTER
		private var _waveCounter:uint = 1;
		private var _e1BaseSpawn:uint = 3;
		private var _e2BaseSpawn:uint = 5;
		private var _e3BaseSpawn:uint = 10;
		
		// SCORE STUFF
		private var _score:uint = 0;
		private var _scoreTextfied:TextField;
		
		// LIVES DISPLAY
		private var _livesDisplay:TextField;
		
		// WAVES TEXTFIELD
		private var _wavesTextfield:TextField;
		
		// particle effects 
		// p1
		private const _psE1PopCon:XML = XML(new AllMyParticles.e1Pop());
		private const _psE1PopImg:Texture = Texture.fromBitmap(new AllMyParticles.e1PopImg());
		private var _psE1:PDParticleSystem = new PDParticleSystem(_psE1PopCon, _psE1PopImg);
		// p2
		private const _psE2PopCon:XML = XML(new AllMyParticles.e2Pop());
		private const _psE2PopImg:Texture = Texture.fromBitmap(new AllMyParticles.e2PopImg());
		private var _psE2:PDParticleSystem = new PDParticleSystem(_psE2PopCon, _psE2PopImg);
		// p3
		private const _psE3PopCon:XML = XML(new AllMyParticles.e3Pop());
		private const _psE3PopImg:Texture = Texture.fromBitmap(new AllMyParticles.e3PopImg());
		private var _psE3:PDParticleSystem;
		
		private var _psE1Holder:Array = [];
		private var _psE2Holder:Array = [];
		private var _psE3Holder:Array = [];
		
		private var _spacer:uint;
		
		private var _enemyAmount:uint = 0;
		
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
			
			_bulletHolder[_bulletCounter].x = (_hero.x) + (_hero.width/2);
			_bulletHolder[_bulletCounter].y = (_hero.y) + (_hero.height/2);
			
			trace(_bulletHolder[_bulletCounter].x, _bulletHolder[_bulletCounter].y);
			
			// calculate the firing angle 
			_bulletHolder[_bulletCounter].targetY = yParam;
			_bulletHolder[_bulletCounter].targetX = xParam;
			_bulletHolder[_bulletCounter].alive = true
			stage.addChild(_bulletHolder[_bulletCounter]);
			_bulletCounter++;
			
			if (_bulletCounter >= 100)
			{
				_bulletCounter = 0;
			}
		}
		
		private function onAdded():void
		{
			// adding the particle effects 
			// adding the event listener to the stage
			//***************EVENT LISTENER******************
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// creating a enw canvas. 
			_battleField = new Sprite();
			stage.addChild( _battleField );
			
			_background = Image.fromBitmap(new AllMyImages.Background());
			_background.y = 50;
			_battleField.addChild(_background);
			
			_scoreTextfied = new TextField(200, 30, "Score: ", "Verdana", 16, 0xffffff);
			_scoreTextfied.x = 200;
			_scoreTextfied.y = 22;
			_scoreTextfied.text = String("Score: "+_score);
			_battleField.addChild(_scoreTextfied);
			
			_hero = new Hero();
			_hero.x = stage.stageWidth/2
			_hero.y = stage.stageHeight/2;
			_battleField.addChild(_hero);
			
			_livesDisplay = new TextField(200, 30, "HP: ", "Verdana", 16, 0xffffff);
			_livesDisplay.x = 10;
			_livesDisplay.y = 22;
			_livesDisplay.text = String("HP: "+_hero.health);
			_battleField.addChild(_livesDisplay);
			
			_wavesTextfield = new TextField(200, 30, "Wave: ", "Verdana", 16, 0xffffff);
			_wavesTextfield.x = 390;
			_wavesTextfield.y = 22;
			_battleField.addChild(_wavesTextfield);
			
			// Creating enemies
			createEnemies();
			
			createBullets();
		}
		
		private function createBullets():void
		{
			// building the bullets 
			for (var f:int = 0; f < 100; f++)
			{
				var bullet:Bullet = new Bullet(false);
				_bulletHolder.push( bullet );
			}
		}
		
		private function createEnemies():void
		{
			_relaunchGame = true;
			//building a bunch of test enemies of class Enemy one
			// ENEMY 1 
			for (var e1:int = 0; e1 < (_e1BaseSpawn*_waveCounter); e1++)
			{
				// spawning enemy One
				_enemyOne = new EnemyOne();
				_enemyOne.scaleX = _enemyOne.scaleY = .5;
				_battleField.addChild( _enemyOne );
				
				// pushing into enemy array 
				_enemyOneHolder.push(_enemyOne);
				
				_enemyAmount++;
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
				_enemyAmount++;
			}
			// ENEMY 3 
			// Creating space between enemies based on the amount of enemies
			_spacer = (_battleField.width / (_e3BaseSpawn*_waveCounter));
			for (var e3:int = 0; e3 < (_e3BaseSpawn*_waveCounter); e3 ++ )
			{
				
				// spawning enemy three
				_enemyThree = new EnemyThree();
				_enemyThree.scaleX = _enemyThree.scaleY = .5;
				_enemyThree.x = _spacer * e3 + (_spacer / 2);
				_battleField.addChild( _enemyThree);
				
				// pushing into enemy array 
				_enemyThreeHolder.push(_enemyThree);
				_enemyAmount++;
			}
		}
		
		private function onEnterFrame():void
		{
			// removing the particle effects
			if (_psE1Holder.length >= 10)
			{
				for (var i:int = 0; i < 10; i++) 
				{
					_psE1Holder.splice(i, 1);
					
				}
			}
			if (_psE2Holder.length >= 10)
			{
				for (var j:int = 0; i < _psE2Holder.length; i++) 
				{
					_psE2Holder.splice(i, 1);
					
				}
			}
			if (_psE3Holder.length >= 10)
			{
				for (var k:int = 0; i < _psE3Holder.length; i++) 
				{
					_psE3Holder.splice(i, 1);
					
				}
			}
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
						e1.dispose();
						_enemyAmount--;
						checkWin();
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
								_psE1 = new PDParticleSystem(_psE1PopCon, _psE1PopImg);
								_battleField.addChild(_psE1);
								_psE1.x = b.x;
								_psE1.y = b.y;
								Starling.juggler.add(_psE1);
								_psE1.start(.4);
								
								_psE1Holder.push(_psE1);
								_battleField.removeChild( e1 );
								_battleField.removeChild( b );
								e1.alive = false;
								e1.dispose();
								_score += 10;
								_enemyAmount--;
								checkWin();
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
						e2.dispose();
						_enemyAmount--;
						checkWin();
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
								_psE2 = new PDParticleSystem(_psE2PopCon, _psE2PopImg);
								_battleField.addChild(_psE2);
								_psE2.x = bull.x;
								_psE2.y = bull.y;
								Starling.juggler.add(_psE2);
								_psE2.start(.4);
								_psE2Holder.push(_psE2);
								_battleField.removeChild( e2 );
								_battleField.removeChild( bull );
								e2.alive = false;
								_score += 10;
								_enemyAmount--;
								checkWin();
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
						e3.dispose();

						
						((_score++) * 10);
						_enemyAmount--;
						checkWin();
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
								_psE3= new PDParticleSystem(_psE3PopCon, _psE3PopImg);
								
								_psE3.x = bulls.x;
								_psE3.y = bulls.y;
								Starling.juggler.add(_psE3);
								_battleField.addChild(_psE3);
								_psE3.start(.4);
								_psE3Holder.push(_psE3);
								
								_battleField.removeChild(e3);
								_battleField.removeChild( bulls );
								e3.alive = false;
								e3.dispose();
								_score += 10;
								_enemyAmount--;
								checkWin();
							}
						}
					}
				}
			}
			_wavesTextfield.text = String("Wave: "+_waveCounter);
			_scoreTextfied.text = String("Score: "+_score);
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
			if(_hero.health < 1)
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
			_livesDisplay.text = String("HP: "+_hero.health);
		}
		
		public function update():void
		{
			if(!_hero.alive)
			{
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
				
				_enemyOneHolder		=  [];
				_enemyTwoHolder 	=  [];
				_enemyThreeHolder 	=  [];
				_bulletHolder 		=  [];
				_psE1Holder 		=  [];
				_psE2Holder 		=  [];
				_psE3Holder 		=  [];
				
			}
			
			if(_battleField.numChildren == 0)
			{
				killGame();
			}
			
			System.gc();
		}
		
		private function killGame():void
		{
			if(_killGame)
			{
				_killGame = false;
				// REMOVING ALL THE EVENT HANDLERS ON THE STAGE
				_battleField.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
				_battleField.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.removeEventListener(TouchEvent.TOUCH, onTouch);
				//				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
				_battleField.dispose();
				
				_game.changeState(Game.GAME_OVER_STATE);
			}
		}
		
		private function checkWin():void
		{
			// We a re checking to see if the Hero is alive and there are
			// no more enemies on the _battleField.
			
			// WE ARE USING 2 BECAUSE THERE WILL ALWAYS BE A SHIP AND A TURRET 
			if(_hero.alive && _enemyAmount == 0)
			{
				if(_relaunchGame)
				{
					_relaunchGame = false;	
					_waveCounter++;
					createEnemies();
					createBullets();
					
				}
			}
		}
	}
}