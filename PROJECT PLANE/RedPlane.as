package {
	import flash.events.Event;
	
	public class RedPlane extends Plane {
		
		public function RedPlane() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			switchAnim();
			if (!isDeath) {
				
				collision();
				rotate();
				createLaser();
				moveLaser();
				move(Main.player);
			}
			
			if (Main.player.isDeath) {
				remove();
			}
		}
		
		override public function remove():void {
			super.remove();
			laser = null;
			removeEventListener(Event.ENTER_FRAME, update);
			Main.uiManager.enemyHealthBar.visible = false;
		}
		
		override public function createLaser(owner:String = null):void {
			if (isShoot) {
				if (GameManager.gameTime % 100 == 0) {
					super.createLaser(Laser.ENEMY);
				}
				
			}
		}
		
		public function collision():void {
			if (stage) {
				if (!isDeath && !Main.player.isDuck && !Main.player.isDeath) {
					for each (var bullet:Bullet in Main.player.bullets) {
						if (hitTestObject(bullet)) {
							bullet.hit(this);
							Main.uiManager.enemyHealthBar.changeTarget(Math.round(health));
						}
					}
					
					if (Main.player.laser != null) {
						if (hitTestObject(Main.player.laser)) {
							hitLaser(Main.player.laser);
							Main.uiManager.enemyHealthBar.changeTarget(Math.round(health));
						}
					}
					
					if (laser != null) {
						if (laser.hitTestObject(Main.player)&& !Main.player.isDuck) {
							Main.player.hitLaser(laser);
						}
					}
					
					if (hitTestObject(Main.player)) {
						Main.player.die();
						die();
					}
				}
			}
		}
	}

}
