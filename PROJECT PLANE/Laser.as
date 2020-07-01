package {
	import flash.events.Event;
	
	public class Laser extends Weapon {
		public static const PLAYER:String = "Player";
		public static const ENEMY:String = "Enemy";
		
		public var isStartHit:Boolean = false;
		public var _owner:String;
		private var hitArray:Array = new Array();
		
		public function Laser(dam:Number, owner:String) {
			damage = dam;
			
			_owner = owner;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			switch (currentFrame) {
			case 20:
				isStartHit = true;
				
				if (_owner == PLAYER) {
					if (Main.player.laserNum > 0)
						Main.player.laserNum--;
				}
				
				shakeCamera();
				Main.soundManager.laserSound.playSound();
				break;
			case 60:
				isStartHit = false;
				if (_owner == PLAYER)
					Main.player.isLaser = false;
				
				Main.removeMainChild(this);
				removeEventListener(Event.ENTER_FRAME, update);
				break;
			}
		}
		
		override public function move(target:Plane = null):void {
			if (target != null) {
				rotation = target.rotation;
				x = target.x;
				y = target.y;
			}
		}
	}

}
