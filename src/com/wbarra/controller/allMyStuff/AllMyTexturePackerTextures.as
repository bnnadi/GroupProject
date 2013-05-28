package com.wbarra.controller.allMyStuff
{
	public class AllMyTexturePackerTextures
	{
		
		[Embed(source="tpAnimations/tpAnimations.xml", mimeType="application/octet-stream")]
		public static const enemiesXML:Class;
		
		[Embed(source="tpAnimations/tpAnimations.png")]
		public static const enemiesImage:Class;
		
		public function AllMyTexturePackerTextures()
		{
		}
	}
}