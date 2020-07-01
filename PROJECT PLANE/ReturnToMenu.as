package  {
	
	import flash.events.MouseEvent;
	
	
	public class ReturnToMenu extends Button {
		
		
		public function ReturnToMenu() {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		override public function onMouseClick(evt:MouseEvent = null):void {
			super.onMouseClick();
			removeEventListener(MouseEvent.CLICK, onMouseClick);
			
			Main.gotoScene(1, GameState.MENU);
			Main.soundManager.menuBgm.playSound();
		}
	}
	
}
