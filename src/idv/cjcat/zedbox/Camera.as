package idv.cjcat.zedbox {
	use namespace zb;
	
	import idv.cjcat.zedbox.geom.*;
	
	public class Camera {
		
		public var usePerspective:Boolean = true;
		public var focalLength:Number = 1000;
		
		zb var _position:Vec3 = new Vec3(0, 0, 1);
		
		public function Camera(position:Vec3 = null) {
			if (position != null) {
				_position.x = position.x;
				_position.y = position.y;
				_position.z = position.z;
			} else {
				_position = new Vec3();
			}
		}
		
		public function clone():Camera {
			var camera:Camera = new Camera(_position);
			camera.usePerspective = usePerspective;
			camera.focalLength = focalLength;
			
			return camera;
		}
		
		public function get position():Vec3 { return _position; }
	}
}