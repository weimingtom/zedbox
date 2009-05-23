package idv.cjcat.zedbox {
	use namespace zb;
	
	import idv.cjcat.zedbox.geom.*;
	
	public class ZedData {
		
		zb var _zs:ZedSprite;
		zb var _cameraDiff:Vec3 = new Vec3();
		
		public function get zedSprite():ZedSprite { return _zs; }
		public function get cameraDiff():Vec3 { return _cameraDiff; }
	}
}