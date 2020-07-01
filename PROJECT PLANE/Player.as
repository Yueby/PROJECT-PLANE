package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Player extends Plane {
		//当前武器类型
		public var currentWeapon:String = Weapon.BULLET;
		public var isChangeWeapon:Boolean = false;
		public var isChangePressed:Boolean = true;
		
		//子弹
		public var createTime:Number = 10;
		public static var bullets:Array = new Array();
		
		//闪避
		private var _duckSpeed:Number = 10;
		private var _duckTime:Number = 0.25;
		private var _currentDuckTime:Number = 0;
		
		//计时器
		private var _timer:Timer = new Timer(60, 0);
		
		//武器数量
		
		public var startBulletNum:Number = 30;
		public var startLaserNum:Number = 15;
		public var laserNum:Number = startLaserNum;
		public var bulletNum:Number = startBulletNum;
		
		public function Player() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			speed = 5;
			isPlayer = true;
			bulletDamage = 20;
			laserDamage = 40;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			
			if (!isDeath) {
				changeWeapon();
				duck();
				rotate();
				move();
				shoot();
			}
			
			moveBullet();
			moveLaser();
			switchAnim();
		}
		
		//移动玩家
		override public function move(target:Plane = null):void {
			if (!isDuck) {
				if (Math.abs(Input.vertical) > 0.5 || Math.abs(Input.horizontal) > 0.5) {
					isMove = true;
				} else {
					isMove = false;
				}
				
				y += speed * Input.vertical;
				x += speed * Input.horizontal;
				
			}
			if (y < (Main.cam.y - Main.cam.height / 2 + height / 2) || y > (Main.cam.y + Main.cam.height - Main.cam.height / 2 - height / 2) || x < (Main.cam.x - Main.cam.width / 2 + width / 2) || x > (Main.cam.x + Main.cam.width - Main.cam.width / 2 - width / 2)) {
				die();
			}
		}
		
		//死亡
		override public function die():void {
			if (!isDuck && !isInvincible) {
				super.die();
				_timer.reset();
				_timer.removeEventListener(TimerEvent.TIMER, timerHandle);
			}
		}
		
		//旋转玩家
		override public function rotate():void {
			angle = Math.atan2(Input.mousePosition.y - y, Input.mousePosition.x - x);
			rotation = angle * 180 / Math.PI + 90;
		}
		
		//发射
		override public function shoot():void {
			if (Input.MouseDown && (GameManager.gameTime % createTime == 0) && !isDuck) {
				switch (currentWeapon) {
				case Weapon.BULLET:
					if (bulletNum > 0) {
						createBullet();
						bulletNum--;
					} else if (bulletNum <= 0) {
						Main.soundManager.errorSound.playSound();
					}
					break;
				case Weapon.LASER:
					if (laserNum > 0 && !isLaser) {
						isLaser = true;
						createLaser(Laser.PLAYER);
					} else if (laserNum <= 0) {
						Main.soundManager.errorSound.playSound();
					}
					break;
				}
			}
		
		}
		
		//移除玩家
		override public function remove():void {
			removeEventListener(Event.ENTER_FRAME, update);
			_timer.reset();
			_timer.removeEventListener(TimerEvent.TIMER, timerHandle);
			
			clear();
			
			Main.endGame();
			Main.soundManager.menuBgm.stopSound();
			Main.gotoScene(1, GameState.END);
		}
		
		override public function clear():void {
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
		
		//闪避
		public function duck():void {
			if ((Input.Space || Input.E) && !isDuck && isMove) {
				Main.soundManager.duckSound.playSound();
				Main.cam.isShake = true;
				
				isDuck = true;
				_timer.start();
				_timer.addEventListener(TimerEvent.TIMER, timerHandle);
			}
			
			if (isDuck) {
				x += Input.horizontal * _duckSpeed;
				y += Input.vertical * _duckSpeed;
			}
		}
		
		private function timerHandle(evt:TimerEvent):void {
			if (!isDeath) {
				//创建残影
				var shadow:PlayerShadow = new PlayerShadow();
				shadow.x = x;
				shadow.y = y;
				shadow.rotation = rotation;
				parent.addChild(shadow);
				
				visible = !visible;
				
				if (_currentDuckTime < _duckTime && isDuck) {
					_currentDuckTime += 60 / 1000;
					
					if (_currentDuckTime > _duckTime) {
						isDuck = false;
						_currentDuckTime = 0;
						
						visible = true;
						
						_timer.reset();
						_timer.removeEventListener(TimerEvent.TIMER, timerHandle);
					}
				}
			}
		}
		
		//切换武器
		private function changeWeapon():void {
			if (Input.Q) {
				if (!isChangeWeapon && isChangePressed) {
					isChangeWeapon = true;
					isChangePressed = false;
				}
			} else {
				isChangePressed = true;
			}
			
			if (isChangeWeapon) {
				switch (currentWeapon) {
				case Weapon.BULLET:
					currentWeapon = Weapon.LASER;
					break;
				case Weapon.LASER:
					currentWeapon = Weapon.BULLET;
					break;
				}
				isChangeWeapon = false;
			}
		
		}
		
		override public function switchAnim():void {
			if (targetHealth > 100) {
				targetHealth = 100;
			}
			super.switchAnim();
		}
		
		public function resetValue():void {
			/*laserNum = startLaserNum;
			   bulletNum = startBulletNum;*/
			targetHealth = 100;
		}
	
	}

}
