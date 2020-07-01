package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Main extends MovieClip {
		public static var soundManager:SoundManager = new SoundManager();
		public static var uiManager:UIManager = new UIManager();
		public static var player:Player = new Player();
		public static var background:MovieClip;//背景
		public static var cam:VitrulCamera;//相机

		public static var gameState:String;

		public static var isGameStart:Boolean = false;
		public static var isMenuAnim:Boolean = false;

		//给外部类调用方法
		public static var gotoScene:Function;
		public static var gotoFrame:Function;
		public static var swtichStage:Function;
		public static var endGame:Function;
		public static var InitStart:Function;
		public static var removeMainChild:Function;
		public static var addChildInMain:Function;

		public static var isStartButton:Boolean = false;
		public static var isAboutButton:Boolean = false;
		public static var isTutorial:Boolean = false;

		public static var currentStage:Number = 0;

		public static var enemys:Array = new Array();

		public var cursor:Cursor = new Cursor();//光标
		public var tutorial:Tutorial = new Tutorial();

		private var _input:Input = new Input();
		private var _gameManager = new GameManager();
		private var _isPressed:Boolean = false;
		private var _isPlayMenuBgm:Boolean = false;

		//隐藏按键
		private var _isInvinciblePressed:Boolean = false;
		private var _isSwitchStagePressed:Boolean = false;

		public function Main() {
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			gotoScene = gotoTheScene;
			gotoFrame = gotoTheFrame;
			swtichStage = switchTheStage;
			endGame = endGameToClear;
			InitStart = stageInit;
			removeMainChild = removeTheChild;
			addChildInMain = addTheChild;

			player.isInvincible = true;

			addChild(_input);
			stage.addChild(cursor);
			addChild(soundManager);

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(evt:Event):void {
			cursor.move();

			switch (gameState) {
				case GameState.MENU :
					if (stage && !_isPlayMenuBgm) {
						_isPlayMenuBgm = true;
						soundManager.menuBgm.playSound();
					}
					break;
				case GameState.TUTORIAL :
					if (! isTutorial) {
						isTutorial = true;
						stage.removeChild(cursor);
						stageInit();
						player.gotoAndPlay(1);
						addChild(tutorial);
					}
					if (contains(tutorial)) {
						tutorial.fixedPosition(uiManager.x, uiManager.y);
					}
				case GameState.GAME :
					GameManager.gameTime++;

					//鼠标
					cursor.rotate(player);
					testKey();
					break;
				case GameState.END :
					break;
			}

		}

		private function switchTheStage(str:String):void {
			clearStage();
			gotoTheScene(1, str);

			if (! player.isDeath) {
				stageInit();

			}
		}

		private function clearStage():void {
			background = null;
			cam = null;

			removeChild(uiManager);
			removeChild(_gameManager);
			removeChild(player);

			if (enemys.length > 0) {
				for (var i:Number = enemys.length; i > 0; i--) {
					if (enemys[i] is BluePlane || enemys[i] is RedPlane) {
						enemys[i].clear();
					}
				}
			}

			enemys.splice(0, enemys.length);
			player.bullets.splice(0, player.bullets.length);
		}

		private function stageInit():void {
			background = bkg;
			cam = v_cam;

			player.isDeath = false;
			player.x = stage.stageWidth / 2;
			player.y = stage.stageHeight / 2;
			player.currentStage = currentStage;

			addChild(cursor);
			addChild(_gameManager);
			addChild(player);
			addChild(uiManager);
		}

		private function endGameToClear():void {
			background = null;
			cam = null;

			removeChild(_gameManager);
			removeChild(uiManager);
			removeChild(cursor);
			stage.addChild(cursor);

			enemys.splice(0, enemys.length);
		}

		private function gotoTheScene(frame:Number, scene:String):void {
			gotoAndPlay(frame, scene);
		}

		private function gotoTheFrame(frame:Number):void {
			gotoAndPlay(frame);
		}

		private function removeTheChild(child:MovieClip):void {
			removeChild(child);
		}

		private function addTheChild(child:MovieClip):void {
			addChild(child);
		}

		private function testKey():void {
			//无敌
			if (Input.Space) {
				if (Input.Up) {
					if (Input.Down && ! _isInvinciblePressed) {
						_isInvinciblePressed = true;
						player.isInvincible = ! player.isInvincible;
						player.targetHealth = 100;
						player.laserNum = player.isInvincible ? 999:player.startLaserNum;
						player.bulletNum = player.isInvincible ? 999:player.startBulletNum;
						trace(player.isInvincible ? "无敌开启" : "无敌取消");
					}
				}
			} else {
				if (_isInvinciblePressed) {
					_isInvinciblePressed = false;
				}
			}

			//切换关卡
			if (Input.Space) {
				if (Input.NumPad_1 && ! _isSwitchStagePressed) {
					_isSwitchStagePressed = true;
					currentStage = 1;
					swtichStage("Stage" + currentStage);
					player.resetValue();
				}

				if (Input.NumPad_2 && ! _isSwitchStagePressed) {
					_isSwitchStagePressed = true;
					currentStage = 2;
					swtichStage("Stage" + currentStage);
					player.resetValue();
				}

				if (Input.NumPad_3 && ! _isSwitchStagePressed) {
					_isSwitchStagePressed = true;
					currentStage = 3;
					swtichStage("Stage" + currentStage);
					player.resetValue();
				}

				if (Input.NumPad_4 && ! _isSwitchStagePressed) {
					_isSwitchStagePressed = true;
					currentStage = 4;
					swtichStage("Stage" + currentStage);
					player.resetValue();
				}

				if (Input.NumPad_5 && ! _isSwitchStagePressed) {
					_isSwitchStagePressed = true;
					currentStage = 5;
					swtichStage("Stage" + currentStage);
					player.resetValue();
				}
			} else {
				_isSwitchStagePressed = false;
			}
		}
	}

}