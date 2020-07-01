package {
	import flash.display.MovieClip;
	
	public class Weapon extends MovieClip {
		public static var BULLET:String = "Bullet";
		public static var LASER:String = "Laser";
		
		public var damage:Number;
		public var isHit:Boolean = false;
		
		public function Weapon() {
		
		}
		
		public function move(target:Plane = null):void {
		
		}
		
		public function hit(target:Plane = null):void {
		
		}
		
		public function shakeCamera():void {
			if (Main.cam != null)
				Main.cam.isShake = true;
		}
	}

}
