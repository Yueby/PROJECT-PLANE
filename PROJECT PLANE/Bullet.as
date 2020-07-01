package {
	import flash.display.MovieClip;
	
	public class Bullet extends Weapon {
		public var vx:Number = 1;
		public var vy:Number = 1;
		public var speed:Number = 10;
		
		private var _bulletTime:Number = 0;
		
		public function Bullet(dam:Number) {
			damage = dam;
		}
		
		override public function move(target:Plane = null):void {
			collision();
			
			_bulletTime += 0.1;
			if (_bulletTime > 9) {
				remove(target);
			}
			
			if (!isHit) {
				x += vx * speed;
				y += vy * speed;
			}
			
			switch (currentFrame) {
			case 7:
				stop();
				break;
			case 15:
				stop();
				remove(target);
				break;
			}
		
		}
		
		private function collision():void {
			if (Main.cam != null) {
				if (y < (Main.cam.y - Main.cam.height / 2 + height / 2) || y > (Main.cam.y + Main.cam.height - Main.cam.height / 2 - height / 2) || x < (Main.cam.x - Main.cam.width / 2 + width / 2) || x > (Main.cam.x + Main.cam.width - Main.cam.width / 2 - width / 2)) {
					hit();
				}
			}
		}
		
		private function remove(target:Plane):void {
			if (parent == null){
				return;
			}
			parent.removeChild(this);
			target.bullets.splice(target.bullets.indexOf(this), 1);
		}
		
		override public function hit(target:Plane = null):void {
			if (!isHit) {
				isHit = true;
				gotoAndPlay(8);
				
				Main.soundManager.bulletHitSound.playSound();
				
				if (target != null) {
					target.hurt(damage);
				}
			}
		}
	}

}
