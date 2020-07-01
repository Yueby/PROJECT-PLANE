package {
	
	import flash.display.MovieClip;
	
	public class HealthBar extends MovieClip {
		
		public function HealthBar() {
			// constructor code
		}
		
		public function setHealthValue(health:Number):void {
			gotoAndStop(health);
		}
		
		public function changeTarget(health:Number):void {
			visible = true;
			setHealthValue(health);
		}
	
	}

}
