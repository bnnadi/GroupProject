package com.wbarra.controller.allMyImages
{
	public class AllMyImages
	{
		[Embed(source="images/ball.png")]
		public static const ball:Class;
		[Embed(source="images/EnemyShip.png")]
		public static const EnemyShip:Class;
		[Embed(source="images/EnemyTwo.png")]
		public static const EnemyTwo:Class;
		[Embed(source="images/Ship.png")]
		public static var Ship:Class;
		[Embed(source="images/Turret.png")]
		public static var Turret:Class;
		[Embed(source="images/Bullet.png")]
		public static var BulletImg:Class;
		
		
		public function AllMyImages()
		{
		}
	}
}