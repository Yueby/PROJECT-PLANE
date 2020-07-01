package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Item extends MovieClip {
		public var distance:Number;
		public var number:Number;
		
		public function Item() {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(evt:Event):void {
			if (stage)
				move();
		}
		
		public function move():void {
			if (!Main.player.isDeath) {
				distance = Math.sqrt((Main.player.x - x) * (Main.player.x - x) + (Main.player.y - y) * (Main.player.y - y));
				if (distance < width + 20) {
					if (!hitTestObject(Main.player)) {
						x += (Main.player.x - x) * 0.2;
						y += (Main.player.y - y) * 0.2;
						scaleX -= 0.1;
						scaleY -= 0.1;
					} else {
						Main.soundManager.pickupSound.playSound();
						
						add(Main.player);
						parent.removeChild(this);
						removeEventListener(Event.ENTER_FRAME, update);
					}
				}
			}else{
				parent.removeChild(this);
			}
			
			
		}
		
		public function add(player:Player):void {
		
		}
	
	}

}
