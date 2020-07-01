package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class Plane extends MovieClip {
		public var isInvincible:Boolean = false;
		
		public var health:Number = 100;
		public var speed:Number = 3;
		public var angle:Number;
		
		public var bullets:Array = new Array();
		public var timer:Timer = new Timer(500, 0);
		
		public var isDeath:Boolean = false;
		public var isMove:Boolean = false;
		
		public var normalEndAnim:Number = 60;
		public var deathAnimStart:Number = 61;
		public var deathAnimEnd:Number = 70;
		
		public var distance:Number;
		
		//闪避
		public var isDuck:Boolean = false;
		
		//激光
		public var isLaser:Boolean = false;
		public var laser:Laser;
		
		public var isFollow:Boolean = false;
		public var isShoot:Boolean = true;
		
		//随机爆物品
		private var _randomItem;
		private var _randomNum:Number;
		public var isPlayer:Boolean = false;
		public var currentStage:Number;
		
		public var targetHealth:Number = 100;
		public var bulletDamage:Number = 10;
		public var laserDamage:Number = 30;
		
		public var isHitLaser:Boolean = false;
		
		public function move(target:Plane = null):void {
			if (target != null)
				distance = Math.sqrt((target.x - x) * (target.x - x) + (target.y - y) * (target.y - y));
			
			if (distance < 400) {
				isFollow = true;
				isShoot = true;
			}
			
			if (distance > 400) {
				isShoot = false;
				isFollow = false;
			}
			
			if (isFollow) {
				x += (target.x - x) * 0.01;
				y += (target.y - y) * 0.01;
			}
		}
		
		public function shoot():void {
		
		}
		
		public function rotate():void {
			
			angle = Math.atan2(Main.player.y - y, Main.player.x - x);
			rotation = angle * 180 / Math.PI + 90;
		
		}
		
		//创建子弹
		public function createBullet():void {
			if (!isDeath) {
				if (parent == null) {
					return;
				}
				
				var bullet:Bullet = new Bullet(bulletDamage);
				bullet.x = x;
				bullet.y = y;
				
				bullet.vx = Math.cos(angle);
				bullet.vy = Math.sin(angle);
				Main.addChildInMain(bullet);
				bullets.push(bullet);
				Main.soundManager.bulletSound.playSound();
			}
		}
		
		//移动子弹
		public function moveBullet():void {
			for each (var bullet:Bullet in bullets) {
				bullet.move(this);
			}
		}
		
		//创建激光
		public function createLaser(owner:String = null):void {
			if (!isDeath && !Main.player.isDeath) {
				if (parent == null) {
					return;
				}
				
				var _laser:Laser = new Laser(laserDamage, owner);
				_laser.x = x;
				_laser.y = y;
				_laser.rotation = rotation;
				
				parent.addChild(_laser);
				laser = _laser;
			}
		}
		
		//移动激光
		public function moveLaser():void {
			if (laser != null) {
				if (!laser.isStartHit) {
					laser.move(this);
				}
			}
		}
		
		//受伤
		public function hurt(damage:Number):void {
			if (!isInvincible && !isDuck) {
				targetHealth -= damage;
				
			}
		}
		
		public function die():void {
			isDeath = true;
			gotoAndPlay(deathAnimStart);
			Main.cam.isShake = true;
			
			if (Main.currentStage != 6)
				Main.soundManager.destorySound.playSound();
		}
		
		public function remove():void {
			if (!Main.player.isDeath)
				dropItem();
			clear();
		
		}
		
		public function clear():void {
			isDeath = true;
			
			if (bullets.length > 0) {
				for each (var bullet:Bullet in bullets) {
					bullet.parent.removeChild(bullet);
				}
				
			}
			bullets.splice(0, bullets.length);
			
			if (parent != null) {
				parent.removeChild(this);
			}
		
		}
		
		public function switchAnim():void {
			health += (targetHealth - health) * 0.1;
			if (health < 0.1 && !isDeath) {
				health = 0;
				if (health <= 0) {
					die();
				}
			}
			
			switch (currentFrame) {
			case normalEndAnim:
				gotoAndPlay(1);
				break;
			case deathAnimEnd:
				stop();
				isDeath = true;
				remove();
				break;
			}
		}
		
		public function dropItem():void {
			if (isDeath && !isPlayer) {
				var randomNum:Number = Math.round(Math.random() * 10);
				_randomNum = 20 + Math.round(Math.random() * 20);
				_randomItem = randomNum < 5 ? new BulletItem(_randomNum) : randomNum > 6 ? new HealthItem(50) : new LaserItem(_randomNum);
				
				/*var itemName:String = (_randomItem is BulletItem) ? "子弹" : "激光";
				   trace("掉落了" + _randomNum + "个" + itemName);*/
				
				_randomItem.x = x;
				_randomItem.y = y;
				
				Main.addChildInMain(_randomItem);
			}
		}
		
		public function hitLaser(laser:Laser):void {
			if (!isInvincible && !isDuck) {
				if (!laser.isStartHit && !laser.isHit) {
					isHitLaser = false;
				}
				if (laser.isStartHit) {
					if (!isHitLaser) {
						isHitLaser = true;
						laser.isHit = true;
						targetHealth -= laser.damage;
					}
				}
			}
		}
	}
}
