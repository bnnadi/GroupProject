package com.wbarra.controller.allMyStuff
{
	public class AllMyTexturePackerTextures
	{
		
		[Embed(source="animations/EnemiesAnimated.xml", mimeType="application/octet-stream")]
		public static const enemiesXML:Class;
		
		[Embed(source="animations/EnemiesAnimated.png")]
		public static const enemiesImage:Class;
		
		public function AllMyTexturePackerTextures()
		{
		}
	}
}