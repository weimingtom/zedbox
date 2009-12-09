package idv.cjcat.zedbox.geom {
	import idv.cjcat.zedbox.display.ZedSprite;
	import idv.cjcat.zedbox.zb;
	
	public class ZedData {
		
		/** @private */
		zb var _zs:ZedSprite;
		/** @private */
		zb var _cameraDiff:Vec3D = new Vec3D();
		
		public function get zedSprite():ZedSprite { return zb::_zs; }
		public function get cameraDiff():Vec3D { return zb::_cameraDiff; }
	}
}