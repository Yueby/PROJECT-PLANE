package {
	
	public class BulletItem extends Item {
		
		public function BulletItem(num:Number) {
			number = num;
		}
		
		override public function add(player:Player):void {
			player.bulletNum += number;
		}
	}

}
