package {
	
	import flash.events.MouseEvent;
	
	public class BackButton extends Button {
		
		public function BackButton() {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		override public function onMouseClick(evt:MouseEvent = null):void {
			if (!Main.isMenuAnim) {
				super.onMouseClick();
				
				Main.gotoFrame(FrameManager.aboutFadeOut);
				Main.isAboutButton = false;
				Main.isStartButton = false;
			}
		}
	}

}
