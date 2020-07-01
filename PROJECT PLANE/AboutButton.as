package {
	import flash.events.MouseEvent;
	
	public class AboutButton extends Button {
		
		public function AboutButton() {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		override public function onMouseClick(evt:MouseEvent = null):void {
			if (!Main.isMenuAnim) {
				super.onMouseClick();
				
				Main.gotoFrame(FrameManager.menuFadeOut);
				Main.isAboutButton = true;
				Main.isStartButton = false;
			}
		}
	}

}
