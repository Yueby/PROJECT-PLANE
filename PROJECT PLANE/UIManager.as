package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class UIManager extends MovieClip {
		public var weaponIcon:WeaponIcon = new WeaponIcon();
		
		public var playerHealthBar:HealthBar = new HealthBar();
		public var enemyHealthBar:HealthBar = new HealthBar();
		public var bossHealthBar:HealthBar = new HealthBar();
		
		public var fadeEffect:FadeEffect = new FadeEffect();
		
		public function UIManager() {
			playerHealthBar.x = x + 130;
			playerHealthBar.y = y + 40;
			playerHealthBar.scaleX = 1.5;
			playerHealthBar.scaleY = 1.5;
			
			enemyHealthBar.x = x + 700;
			enemyHealthBar.y = y + 40;
			enemyHealthBar.scaleX = 1.5;
			enemyHealthBar.scaleY = 1.5;
			enemyHealthBar.visible = false;
			
			bossHealthBar.x = x + 200;
			bossHealthBar.y = y + 450;
			bossHealthBar.scaleX = 4;
			bossHealthBar.scaleY = 1.5;
			bossHealthBar.visible = false;
			
			fadeEffect.x = x;
			fadeEffect.y = y;
			
			addChild(weaponIcon);
			addChild(playerHealthBar);
			addChild(enemyHealthBar);
			addChild(bossHealthBar);
			addChild(fadeEffect);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			if (Main.gameState == GameState.GAME || Main.gameState == GameState.TUTORIAL) {
				fixedPosition();
				weaponIcon.switchIcon();
				playerHealthBar.setHealthValue(Math.round(Main.player.health));
				
			}
		}
		
		private function fixedPosition():void {
			if (Main.cam != null) {
				x = Main.cam.x - Main.cam.width / 2;
				y = Main.cam.y - Main.cam.height / 2;
			}
		}
	}

}
