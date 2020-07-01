package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Portal extends MovieClip {
		
		public function Portal() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			playerInThePortal();
		}
		
		private function playerInThePortal():void {
			if (hitTestObject(Main.player) && !Main.player.isDeath) {
				switch (Main.gameState) {
				case GameState.TUTORIAL:
					if (Tutorial.isAllEnd()) {
						Main.currentStage++;
						Main.swtichStage("Stage" + Main.currentStage);
						Main.gameState = GameState.GAME;
						Main.player.isInvincible = false;
						Main.player.resetValue();
						Main.player.laserNum = Main.player.startLaserNum;
						Main.player.bulletNum = Main.player.startBulletNum;
						Main.uiManager.enemyHealthBar.visible = false;
						Main.uiManager.fadeEffect.play();
						Main.soundManager.portalSound.playSound();
					}
					break;
				case GameState.GAME:
					Main.currentStage++;
					if (Main.currentStage == 6) {
						Main.currentStage = 1;
						Main.soundManager.flayOutSound.playSound();
						Main.player.remove();
						parent.removeChild(this);
					} else {
						Main.uiManager.enemyHealthBar.visible = false;
						Main.swtichStage("Stage" + Main.currentStage);
						Main.player.resetValue();
						Main.uiManager.fadeEffect.play();
					}
					Main.soundManager.portalSound.playSound();
					break;
				}
				
			}
		}
	}

}
