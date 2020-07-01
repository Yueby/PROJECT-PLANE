package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Spike extends MovieClip {
		
		public function Spike() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			if (stage) {
				if (stage.contains(Main.player)) {
					if (Main.player.hitTestObject(this) && !Main.player.isDeath && !Main.player.isDuck) {
						Main.player.die();
						
						if (Main.isTutorial){
							Tutorial.isTouchSpike = true;
						}
					}
					
				}
				
				for each (var bullet:Bullet in Main.player.bullets) {
					if (stage.contains(bullet)) {
						if (bullet.hitTestObject(this)) {
							bullet.hit();
						}
					}
				}
			}
		}
	}

}
