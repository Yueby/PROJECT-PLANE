package {
	import flash.events.Event;
	
	public class BluePlane extends Plane {
		
		public function BluePlane() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			switchAnim();
			if (!isDeath && !Main.player.isDeath) {
				rotate();
				collision();
				
				createBullet();
				moveBullet();
				move(Main.player);
			}
			
			if (Main.player.isDeath) {
				remove();
			}
		
		}
		
		override public function remove():void {
			removeEventListener(Event.ENTER_FRAME, update);
			super.remove();
			Main.uiManager.enemyHealthBar.visible = false;
		}
		
		override public function createBullet():void {
			if (isShoot) {
				if (GameManager.gameTime % 30 == 0) {
					super.createBullet();
				}
			}
		}
		
		public function collision():void {
			if (stage) {
				if (stage.contains(Main.player)) {
					if (!isDeath && !Main.player.isDuck) {
						for each (var bullet:Bullet in Main.player.bullets) {
							if (hitTestObject(bullet)) {
								bullet.hit(this);
								Main.uiManager.enemyHealthBar.changeTarget(Math.round(health));
							}
						}
						
						if (bullets.length > 0) {
							for each (var mBullet:Bullet in bullets) {
								if (mBullet.hitTestObject(Main.player)) {
									mBullet.hit(Main.player);
								}
							}
						}
						
						if (Main.player.laser != null) {
							if (hitTestObject(Main.player.laser)) {
								hitLaser(Main.player.laser);
								Main.uiManager.enemyHealthBar.changeTarget(Math.round(health));
							}
						}
						
						if (hitTestObject(Main.player) && !Main.player.isDeath) {
							Main.player.die();
							die();
						}
					}
					
				}
			}
		}
	
	}

}
