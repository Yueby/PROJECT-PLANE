package {
	
	import flash.events.MouseEvent;
	
	public class StartButton extends Button {
		public function StartButton() {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		override public function onMouseClick(evt:MouseEvent = null):void {
			if (!Main.isMenuAnim) {
				super.onMouseClick();
				
				Main.gotoFrame(FrameManager.menuFadeOut);
				Main.isAboutButton = false;
				Main.isStartButton = true;
				Main.isGameStart = true;
			}
		}
	
	}

}
