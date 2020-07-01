package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Button extends MovieClip {
		
		public function Button() {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		public function onMouseOver(evt:MouseEvent):void {
			if (!Main.isMenuAnim) {
				gotoAndPlay(2);
				Main.soundManager.selectSound.playSound();
			}
		}
		
		public function onMouseOut(evt:MouseEvent):void {
			if (!Main.isMenuAnim)
				gotoAndPlay(11);
		}
		
		public function onMouseDown(evt:MouseEvent):void {
			if (!Main.isMenuAnim)
				gotoAndPlay(21);
		}
		
		public function onMouseUp(evt:MouseEvent):void {
			if (!Main.isMenuAnim)
				gotoAndPlay(10);
		}
		
		public function onMouseClick(evt:MouseEvent = null):void {
			if (!Main.isMenuAnim) {
				removeEventListener(MouseEvent.CLICK, onMouseClick);
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
	
	}

}
