package {
	
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	
	public class Cursor extends MovieClip {
		
		public function Cursor() {
			Mouse.hide();
			mouseEnabled = false;
		}
		
		public function move():void {
			if (Main.gameState != GameState.GAME) {
				rotation = -25;
			}
			x = Input.mousePosition.x;
			y = Input.mousePosition.y;
		}
		
		public function rotate(target:Player = null):void {
			if (target != null) {
				if (target.isDeath) {
					rotation = -30;
				} else {
					rotation = target.rotation;
				}
			}
		}
	}

}
