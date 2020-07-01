package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class SoundManager extends MovieClip {
		public var bulletSound:BulletSound = new BulletSound();
		public var destorySound:DestorySound = new DestorySound();
		public var bulletHitSound:BulletHitSound = new BulletHitSound();
		public var duckSound:DuckSound = new DuckSound();
		public var laserSound:LaserSound = new LaserSound();
		public var pickupSound:PickupSound = new PickupSound();
		public var errorSound:ErrorSound = new ErrorSound();
		public var menuBgm:MenuBgm = new MenuBgm();
		public var selectSound:SelectSound = new SelectSound();
		public var portalSound:PortalSound = new PortalSound();
		public var flayOutSound:FlyOutSound = new FlyOutSound();
		
		public function SoundManager() {
		
		}
	}

}
