package {
	
	import flash.events.MouseEvent;
	
	public class RestartButton extends Button {
		
		public function RestartButton() {
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		override public function onMouseClick(evt:MouseEvent = null):void {
			super.onMouseClick();
			removeEventListener(MouseEvent.CLICK, onMouseClick);
			
			Main.player = new Player();
			Main.gameState = GameState.GAME;
			Main.gotoScene(1, "Stage" + Main.currentStage);
			Main.InitStart();
			Main.soundManager.menuBgm.playSound(Main.soundManager.menuBgm.position);
			Main.uiManager.fadeEffect.play();
		}
	}

}
