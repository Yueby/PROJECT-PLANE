package {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class GameSound extends Sound {
		public var soundTransform:SoundTransform = new SoundTransform();
		public var soundChannel:SoundChannel = new SoundChannel();
		
		public function playSound(position:Number = 0):void {
			soundChannel = play(position);
			soundChannel.soundTransform = soundTransform;
		}
		
		public function stopSound():void {
			soundChannel.stop();
		}
	
	}

}
