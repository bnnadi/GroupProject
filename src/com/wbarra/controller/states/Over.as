package com.wbarra.controller.states
{
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.interfaces.IState;
	
	import starling.display.Sprite;
	
	public class Over extends Sprite implements IState
	{
		public function Over(game:Game)
		{
			super();
		}
		
		public function update():void
		{
		}
		
		public function destroy():void
		{
		}
	}
}