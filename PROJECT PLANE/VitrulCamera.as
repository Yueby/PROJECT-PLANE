package {
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class VitrulCamera extends MovieClip {
		//相机晃动
		public var isShake:Boolean = false;
		
		private var _shakeStart:Boolean = false;
		private var _shakeTime:Number = 0;
		private var _shakeDuration:Number = 0.2;
		private var _shakeMagnitude:Number = 20;
		private var _originalX:Number;
		private var _originalY:Number;
		private var _targetX:Number;
		private var _targetY:Number;
		
		//相机变换
		private var _cameraTrans:Transform;
		private var _stageTrans:Transform;
		
		//计时器
		private var _timer:Timer = new Timer(20, 0);
		
		public function VitrulCamera() {
			_cameraTrans = new Transform(this);
			_stageTrans = new Transform(root);
			visible = false;
			
			_targetX = Main.player.x;
			_targetY = Main.player.y;
			
			stage.addEventListener(Event.ENTER_FRAME, update);
			updateStage();
			addEventListener(Event.REMOVED_FROM_STAGE, resetStage);
		}
		
		private function update(evt:Event):void {
			
			if (stage) {
				updateStage();
				
				//相机运动
				cameraControl();
			}
		}
		
		private function updateStage():void {
			
			parent.filters = filters;
			_stageTrans.colorTransform = _cameraTrans.colorTransform;
			var stageMatrix:Matrix = _cameraTrans.matrix;
			stageMatrix.invert();
			stageMatrix.translate(stage.stageWidth * .5, stage.stageHeight * .5);
			_stageTrans.matrix = stageMatrix;
		
		}
		
		private function resetStage(evt:Event):void {
			stage.removeEventListener(Event.ENTER_FRAME, updateStage);
			_stageTrans.matrix = new Matrix();
			_stageTrans.colorTransform = new ColorTransform();
			parent.filters = new Array();
		}
		
		private function cameraControl():void {
			if (isShake && !_shakeStart) {
				isShake = false;
				_shakeStart = true;
				shakeCamera();
			}
			
			if (!_shakeStart) {
				_targetX = Main.player.x;
				_targetY = Main.player.y;
			}
			
			x += (_targetX - x) * 0.1;
			y += (_targetY - y) * 0.1;
			
			if (!isShake) {
				if (x < Main.background.x + width / 2 - 10) {
					x = Main.background.x + width / 2 - 10;
				}
				
				if (x > Main.background.width - (width + width / 2 + 22)) {
					x = Main.background.width - (width + width / 2 + 22);
				}
				
				if (y < Main.background.y + height / 2 - 10) {
					y = Main.background.y + height / 2 - 10;
				}
				
				if (y > Main.background.height - (height + height / 2 + 30)) {
					y = Main.background.height - (height + height / 2 + 30);
				}
			}
		
		}
		
		private function shakeCamera():void {
			_originalX = x;
			_originalY = y;
			_targetX = x;
			_targetY = y;
			
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, updateTimer);
		}
		
		private function updateTimer(evt:TimerEvent):void {
			if (_shakeTime < _shakeDuration) {
				_targetX = _originalX + (-1 + Math.random() * 2 * _shakeMagnitude);
				_targetY = _originalY + (-1 + Math.random() * 2 * _shakeMagnitude);
				
				_shakeTime += 60 / 1000;
			} else {
				_shakeTime = 0;
				
				isShake = false;
				_shakeStart = false;
				
				_timer.reset();
				_timer.removeEventListener(TimerEvent.TIMER, updateTimer);
			}
		}
	}

}
