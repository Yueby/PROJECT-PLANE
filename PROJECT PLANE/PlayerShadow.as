package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class PlayerShadow extends MovieClip {
		
		public function PlayerShadow() {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			switch (currentFrame) {
			case 30:
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, update);
				break;
			}
		}
	}

}
