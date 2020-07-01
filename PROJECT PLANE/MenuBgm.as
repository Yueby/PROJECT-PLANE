package {
	
	import flash.events.Event;
	import flash.media.Sound;
	
	public class MenuBgm extends GameSound {
		public var position:Number = 0;
		
		public function MenuBgm() {
			soundTransform.volume = 0.5;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandle);
		}
		
		private function soundCompleteHandle(evt:Event):void {
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandle);
			playSound(position);
		}
		
		override public function stopSound():void {
			position = soundChannel.position;
			super.stopSound();
		}
	}

}
