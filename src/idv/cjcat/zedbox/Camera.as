package idv.cjcat.zedbox {
	use namespace zb;
	
	import idv.cjcat.zedbox.geom.*;
	
	public class Camera {
		
		public var focalLength:Number = 1000;
		public var zoom:Number = 1;
		public var rotation:Number = 0;
		public var usePerspective:Boolean = true;
		
		zb var _position:Vec3 = new Vec3(0, 0, -1000);
		zb var _direction:Vec3 = new Vec3(0, 0, 1);
		
		public function Camera() {
			
		}
		
		public function get position():Vec3 { return _position; }
		public function get direction():Vec3 { return _direction; }
	}
}