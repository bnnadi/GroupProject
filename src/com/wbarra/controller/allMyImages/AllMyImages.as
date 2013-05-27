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
		public static const Ship:Class;
		[Embed(source="images/Turret.png")]
		public static const Turret:Class;
		[Embed(source="images/Bullet.png")]
		public static const BulletImg:Class;
		
		[Embed(source="images/EnemyThree.png")]
		public static const EnemyThreeImage:Class;
		
		
		
		// embed test texure 
		[Embed(source="images/tp/myTexture.xml", mimeType ="application/octet-stream")]
		public static const AtlasXML:Class;
		
		[Embed(source="images/tp/myTexture.png")]
		public static const AtlasTexture:Class; 
		
		public function AllMyImages()
		{
		}
	}
}