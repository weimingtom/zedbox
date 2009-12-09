package idv.cjcat.zedbox.cameras {
	import idv.cjcat.zedbox.geom.Vec3D;
	import idv.cjcat.zedbox.zb;
	
	use namespace zb;
	
	public class Camera {
		
		public var focalLength:Number = 1000;
		public var zoom:Number = 1;
		public var rotation:Number = 0;
		public var usePerspective:Boolean = true;
		
		/** @private */
		zb var _position:Vec3D = new Vec3D(0, 0, -1000);
		/** @private */
		zb var _direction:Vec3D = new Vec3D(0, 0, 1);
		
		public function Camera() {
			
		}
		
		public function get position():Vec3D { return _position; }
		public function get direction():Vec3D { return _direction; }
	}
}