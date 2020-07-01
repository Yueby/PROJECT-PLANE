package {
	import flash.display.MovieClip;
	
	public class WeaponIcon extends MovieClip {
		public var text:Text = new Text();
		public var bulletIcon:BulletIcon = new BulletIcon();
		public var laserIcon:LaserIcon = new LaserIcon();
		
		public function WeaponIcon() {
			bulletIcon.x = x + 50;
			bulletIcon.y = y + 50;
			laserIcon.x = x + 50;
			laserIcon.y = y + 50;
			laserIcon.visible = false;
			
			text.x = bulletIcon.x;
			text.y = bulletIcon.y + 40;
			
			addChild(bulletIcon);
			addChild(laserIcon);
			addChild(text);
		}
		
		//切换icon图标
		public function switchIcon():void {
			switch (Main.player.currentWeapon) {
			case Weapon.BULLET:
				laserIcon.visible = false;
				bulletIcon.visible = true;
				text.text.text = Main.player.bulletNum.toString();
				break;
			case Weapon.LASER:
				laserIcon.visible = true;
				bulletIcon.visible = false;
				text.text.text = Main.player.laserNum.toString();
				break;
			}
		}
	
	}

}
