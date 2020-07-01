package {
	
	public class LaserItem extends Item {
		
		public function LaserItem(num:Number) {
			number = num;
		}
		
		override public function add(player:Player):void {
			player.laserNum += number;
		}
	}

}
