package {
	
	import flash.display.MovieClip;
	
	public class Tutorial extends MovieClip {
		public static var isTouchSpike:Boolean = false;
		public static var isAllEnd:Function;
		
		private var isUp:Boolean = false;
		private var isDown:Boolean = false;
		private var isLeft:Boolean = false;
		private var isRight:Boolean = false;
		
		private var isDirectionTutorial:Boolean = true;
		private var isRotatePlayer:Boolean;
		private var isShoot:Boolean;
		private var isChangeWeapon:Boolean;
		private var isDuck:Boolean;
		private var isSpike:Boolean;
		private var isDrop:Boolean;
		private var isEnd:Boolean;
		
		private var enemy:BluePlane;
		private var isCreateEnemy:Boolean = false;
		
		private var angle:Number = 0;
		private var time:Number = 0;
		
		public function Tutorial() {
			isAllEnd = checkEnd;
		}
		
		public function fixedPosition(xPos:Number,yPos:Number):void {
			if (stage.contains(Main.player)) {
				x = xPos + 130;
				y = yPos+460;
			}
			
			checkFinished();
		}
		
		private function checkEnd():Boolean {
			if (!isDirectionTutorial && !isRotatePlayer && !isShoot && !isChangeWeapon && !isDuck && !isSpike && !isDrop && !isEnd)
				return true;
			
			return false;
		}
		
		public function checkFinished():void {
			//移动教程
			if (isDirectionTutorial) {
				if (Input.W && !isUp) {
					isUp = true;
				}
				if (Input.S && !isDown) {
					isDown = true;
				}
				
				if (Input.A && !isLeft) {
					isLeft = true;
				}
				
				if (Input.D && !isRight) {
					isRight = true;
				}
				
				if (isUp && isDown && isLeft && isRight) {
					isDirectionTutorial = false;
					isRotatePlayer = true;
					gotoAndPlay(2);
				}
			}
			
			//旋转玩家教程
			if (isRotatePlayer) {
				angle = Main.player.angle;
				
				if (angle > 3) {
					isRotatePlayer = false;
					isShoot = true;
					gotoAndPlay(3);
				}
			}
			
			//射击教程
			if (isShoot) {
				
				if (Input.MouseDown) {
					isShoot = false;
					isChangeWeapon = true;
					gotoAndPlay(4);
				}
			}
			
			if (isChangeWeapon) {
				if (Input.Q) {
					isChangeWeapon = false;
					isDrop = true;
					
					gotoAndPlay(5);
					if (!isCreateEnemy) {
						isCreateEnemy = true;
						
						enemy = new BluePlane();
						enemy.x = Main.player.x;
						enemy.y = Main.player.y - 200;
						parent.addChild(enemy);
					}
				}
			}
			
			if (isDrop) {
				if (!parent.contains(enemy)) {
					isDrop = false;
					isDuck = true;
					gotoAndPlay(6);
				}
				
			}
			
			if (isDuck) {
				if (Input.Space && (Input.vertical > 0.3 || Input.horizontal > 0.3)) {
					isDuck = false;
					isSpike = true;
					gotoAndPlay(7);
				}
			}
			
			if (isSpike) {
				if (Input.Space && isTouchSpike) {
					isSpike = false;
					isEnd = true;
					gotoAndPlay(8);
				}
			}
			
			if (isEnd) {
				time++;
				if (time > 200) {
					parent.removeChild(this);
					isEnd = false;
				}
			}
		}
	}

}
