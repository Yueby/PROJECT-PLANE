package {
	import flash.events.Event;
	
	public class Boss extends Plane {
		public var bossState:Number = 0;
		public var laserArray:Array = new Array();
		public var laserRate:Number = 40;
		
		public function Boss() {
			health = 1000;
			targetHealth = 1000;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			if (!Main.player.isDeath) {
				switchAnim();
				
				if (!isDeath) {
					if (bossState != 2)
						rotate();
					collision();
					
					switchState();
					moveBullet();
					moveLaser();
					move(Main.player);
				}
			} else {
				removeLaser();
				remove();
			}
			
			if (!isDeath) {
				if (Main.currentStage == 5) {
					Main.uiManager.bossHealthBar.visible = true;
				} else {
					Main.uiManager.bossHealthBar.visible = false;
				}
			}
			
			if (laserArray.length > 0){
				for each (var laser:Laser in laserArray) {
					if (laser.isHit){
						laserArray.splice(laserArray.indexOf(laser), 1);
					}
				}
				
			}
		}
		
		override public function move(target:Plane = null):void {
			if (target != null)
				distance = Math.sqrt((target.x - x) * (target.x - x) + (target.y - y) * (target.y - y));
			
			if (distance < 1000) {
				//Main.uiManager.bossHealthBar.visible = true;
				Main.uiManager.bossHealthBar.changeTarget(Math.round(health * 0.1));
				isFollow = true;
				isShoot = true;
				bossState = 0;
			}
			
			if (distance < 300 && health > 500) {
				laserRate = 40;
				isFollow = false;
				bossState = 1;
			} else if (distance < 300 && health < 500) {
				isFollow = false;
				laserRate = 10;
				bossState = 2;
			}
			
			if (distance > 500) {
				isFollow = true;
				bossState = 0;
			}
			
			if (distance > 1000) {
				isShoot = false;
			}
			
			if (isFollow) {
				x += (target.x - x) * 0.01;
				y += (target.y - y) * 0.01;
			}
		
		}
		
		public function switchState():void {
			switch (bossState) {
			case 0:
				createBullet();
				break;
			case 1:
				createLaser(Laser.ENEMY);
				break;
			case 2:
				rotation += 10;
				createLaser(Laser.ENEMY);
				break;
			}
		}
		
		override public function createBullet():void {
			if (isShoot) {
				if (GameManager.gameTime % 30 == 0) {
					if (!isDeath) {
						if (parent == null) {
							return;
						}
						
						var bullet1:Bullet = new Bullet(bulletDamage);
						var bullet2:Bullet = new Bullet(bulletDamage);
						var bullet3:Bullet = new Bullet(bulletDamage);
						bullet1.speed = 20;
						bullet2.speed = 20;
						bullet3.speed = 20;
						
						bullet1.x = x;
						bullet1.y = y;
						
						bullet2.x = x;
						bullet2.y = y;
						
						bullet3.x = x;
						bullet3.y = y;
						
						bullet1.vx = Math.cos(angle);
						bullet1.vy = Math.sin(angle);
						
						bullet2.vx = Math.cos(angle) - 0.1;
						bullet2.vy = Math.sin(angle);
						
						bullet3.vx = Math.cos(angle) + 0.1;
						bullet3.vy = Math.sin(angle);
						
						parent.addChild(bullet1);
						parent.addChild(bullet2);
						parent.addChild(bullet3);
						
						bullets.push(bullet1);
						bullets.push(bullet2);
						bullets.push(bullet3);
						
						Main.soundManager.bulletSound.playSound();
					}
				}
			}
		}
		
		override public function createLaser(owner:String = null):void {
			if (isShoot) {
				if (GameManager.gameTime % laserRate == 0) {
					if (!isDeath && !Main.player.isDeath) {
						
						var _laser:Laser = new Laser(laserDamage, owner);
						_laser.x = x;
						_laser.y = y;
						_laser.rotation = rotation;
						
						Main.addChildInMain(_laser);
						laserArray.push(_laser);
					}
				}
				
			}
		
		}
		
		override public function moveLaser():void {
			if (laserArray.length > 0) {
				for each (var laser:Laser in laserArray) {
					if (!laser.isStartHit) {
						laser.move(this);
					}
				}
			}
		}
		
		override public function remove():void {
			removeEventListener(Event.ENTER_FRAME, update);
			
			super.remove();
			Main.uiManager.bossHealthBar.visible = false;
		}
		
		private function removeLaser():void {
			laserArray.splice(0, laserArray.length);
		}
		
		private function collision():void {
			if (stage) {
				if (stage.contains(Main.player)) {
					if (!isDeath && !Main.player.isDuck) {
						for each (var bullet:Bullet in Main.player.bullets) {
							if (hitTestObject(bullet)) {
								bullet.hit(this);
							}
						}
						
						if (bullets.length > 0) {
							for each (var mBullet:Bullet in bullets) {
								if (mBullet.hitTestObject(Main.player)) {
									mBullet.hit(Main.player);
								}
							}
						}
						
						if (laserArray.length > 0) {
							for each (var laser:Laser in laserArray) {
								if (laser.hitTestObject(Main.player)) {
									Main.player.hitLaser(laser);
								}
							}
						}
						
						if (Main.player.laser != null) {
							if (hitTestObject(Main.player.laser)) {
								hitLaser(Main.player.laser);
							}
						}
						
						if (hitTestObject(Main.player) && !Main.player.isDeath) {
							Main.player.die();
						}
					}
					
				}
			}
		}
		
		override public function dropItem():void {
			var portal:Portal = new Portal();
			portal.x = x;
			portal.y = y;
			parent.addChild(portal);
		}
	
	}

}
