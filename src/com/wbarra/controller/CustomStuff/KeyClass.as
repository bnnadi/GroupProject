package com.wbarra.controller.CustomStuff
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	public class KeyClass
	{
		public static var Keys:Array = [];
		
		public function KeyClass()
		{
		}
		public static function init(st:Stage):void
		{
			// st = stage is so because the keyboard event has to involved the stage to work
			st.addEventListener(KeyboardEvent.KEY_DOWN, onDown);	
			st.addEventListener(KeyboardEvent.KEY_UP, onUp);
			for( var i:int; i<100; i++)
			{
				Keys[i] = 0;
			}
		}
		
		protected static function onUp(event:KeyboardEvent):void
		{
			// You want to remove the keyCode that was pressed by user in the Array when the release the key
			// 90means that the  array is false or if the array is off
			Keys[event.keyCode] = 0;
		}
		
		protected static function onDown(event:KeyboardEvent):void
		{
			// You want to store the keyCode that was pressed by user in the Array
			// 1 means that the  array is true or if the array is on
			Keys[event.keyCode] = 1;
		}
	}
}