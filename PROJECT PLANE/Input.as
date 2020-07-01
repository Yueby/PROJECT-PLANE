package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	//输入管理系统
	public class Input extends MovieClip {
		//字母按键
		public static var A:Boolean;
		public static var D:Boolean;
		public static var W:Boolean;
		public static var S:Boolean;
		public static var J:Boolean;
		public static var K:Boolean;
		public static var Q:Boolean;
		public static var E:Boolean;
		
		//功能键
		public static var Space:Boolean;
		
		//方向键
		public static var Left:Boolean;
		public static var Right:Boolean;
		public static var Up:Boolean;
		public static var Down:Boolean;
		
		//数字键盘
		public static var NumPad_0:Boolean;
		public static var NumPad_1:Boolean;
		public static var NumPad_2:Boolean;
		public static var NumPad_3:Boolean;
		public static var NumPad_4:Boolean;
		public static var NumPad_5:Boolean;
		public static var NumPad_6:Boolean;
		public static var NumPad_7:Boolean;
		public static var NumPad_8:Boolean;
		public static var NumPad_9:Boolean;
		
		public static var MouseDown:Boolean;
		public static var MouseUp:Boolean;
		
		//
		public static var horizontal:Number = 0; //水平按键
		public static var vertical:Number = 0;	//垂直按键
		
		public static var mousePosition:Point;
		
		private var _keyMinValue:Number = 0.001;
		private var _smooth:Number = 0.045;
		
		var currentHorizontal:Number = 0 /*= (D ? 1 : 0) - (A ? 1 : 0)*/;
		var currentVertical:Number = 0 /*= (S ? 1 : 0) - (W ? 1 : 0)*/;
		
		public function Input() {
			//将Player脚本添加加到舞台
			if (stage) {
				init();//如果在舞台，执行init()
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, init);//不在就添加进舞台，再执行init()
			}
		}
		
		private function init(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyboardUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseButtonDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseButtonUp);
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void {
			mousePosition = new Point(mouseX, mouseY);
			
			//获取按键后返回的值，在flash中，左上为原点（0，0），所以向上是-，向左是-，其余为正
			
			if (A || D || S || W) {
				currentHorizontal = (D ? 1 : 0) - (A ? 1 : 0);
				currentVertical = (S ? 1 : 0) - (W ? 1 : 0);
			} else if (Left || Right || Up || Down) {
				currentHorizontal = (Right ? 1 : 0) - (Left ? 1 : 0);
				currentVertical = (Down ? 1 : 0) - (Up ? 1 : 0);
			} else {
				currentHorizontal = 0;
				currentVertical = 0;
			}
			//trace(currentVertical + "," + currentHorizontal);
			
			//往中间插值
			horizontal += (currentHorizontal - horizontal) * _smooth;
			vertical += (currentVertical - vertical) * _smooth;
			//trace(vertical + "," + horizontal);
			
			if (!D && !A && (horizontal < _keyMinValue && horizontal > -_keyMinValue)) {
				horizontal = 0;
			}
			
			if (!W && !S && (vertical < _keyMinValue && vertical > -_keyMinValue)) {
				vertical = 0;
			}
		}
		
		private function onKeyboardDown(evt:KeyboardEvent):void {
			//trace(evt.keyCode);
			
			switch (evt.keyCode) {
			//A
			case 65:
				A = true;
				break;
			//W
			case 87:
				W = true;
				break;
			//D
			case 68:
				D = true;
				break;
			//E
			case 69:
				E = true;
				break;
			//S
			case 83:
				S = true;
				break;
			//J
			case 74:
				J = true;
				break;
			//K
			case 75:
				K = true;
				break;
			
			//Q
			case 81:
				Q = true;
				break;
			
			//Space
			case 32:
				Space = true;
				break;
			
			//左箭头
			case 37:
				Left = true;
				break;
			//上箭头
			case 38:
				Up = true;
				break;
			//右箭头
			case 39:
				Right = true;
				break;
			//下箭头
			case 40:
				Down = true;
				break;
			
			//数字键盘0
			case 96:
				NumPad_0 = true;
				break;
			//数字键盘1
			case 97:
				NumPad_1 = true;
				break;
			//数字键盘2
			case 98:
				NumPad_2 = true;
				break;
			//数字键盘3
			case 99:
				NumPad_3 = true;
				break;
			//数字键盘4
			case 100:
				NumPad_4 = true;
				break;
			//数字键盘5
			case 101:
				NumPad_5 = true;
				break;
			//数字键盘6
			case 102:
				NumPad_6 = true;
				break;
			//数字键盘7
			case 103:
				NumPad_7 = true;
				break;
			//数字键盘8
			case 104:
				NumPad_8 = true;
				break;
			//数字键盘9
			case 105:
				NumPad_9 = true;
				break;
				
			}
		}
		
		private function onKeyboardUp(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
			//A
			case 65:
				A = false;
				break;
			//W
			case 87:
				W = false;
				break;
			//D
			case 68:
				D = false;
				break;
			//E
			case 69:
				E = false;
				break;
			//S
			case 83:
				S = false;
				break;
			//J
			case 74:
				J = false;
				break;
			//K
			case 75:
				K = false;
				break;
			
			//Q
			case 81:
				Q = false;
				break;
			
			//Space
			case 32:
				Space = false;
				break;
			
			//左箭头
			case 37:
				Left = false;
				break;
			//上箭头
			case 38:
				Up = false;
				break;
			//右箭头
			case 39:
				Right = false;
				break;
			//下箭头
			case 40:
				Down = false;
				break;
			//数字键盘0
			case 96:
				NumPad_0 = false;
			//数字键盘1
			case 97:
				NumPad_1 = false;
				break;
			//数字键盘2
			case 98:
				NumPad_2 = false;
				break;
			//数字键盘3
			case 99:
				NumPad_3 = false;
				break;
			//数字键盘4
			case 100:
				NumPad_4 = false;
				break;
			//数字键盘5
			case 101:
				NumPad_5 = false;
				break;
			//数字键盘6
			case 102:
				NumPad_6 = false;
				break;
			//数字键盘7
			case 103:
				NumPad_7 = false;
				break;
			//数字键盘8
			case 104:
				NumPad_8 = false;
				break;
			//数字键盘9
			case 105:
				NumPad_9 = false;
				break;
				
			}
		}
		
		private function onMouseButtonDown(evt:MouseEvent):void {
			MouseDown = true;
			MouseUp = false;
		}
		
		private function onMouseButtonUp(evt:MouseEvent):void {
			MouseDown = false;
			MouseUp = true;
		}
	}
}
