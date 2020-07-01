package {
	
	import flash.display.MovieClip;
	
	public class HealthItem extends Item {
		
		public function HealthItem(num:Number) {
			number = num;
		}
		
		override public function add(player:Player):void {
			player.targetHealth += number;
		}
	
	}

}
