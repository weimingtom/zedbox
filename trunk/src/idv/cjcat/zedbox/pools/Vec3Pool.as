package idv.cjcat.zedbox.pools {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	import idv.cjcat.zedbox.geom.*;
	
	/** @private */
	public class Vec3Pool {
		
		private static var _vec:Vector.<Vec3> = Vector.<Vec3>([new Vec3()]);
		private static var _position:int = 0;
		
		private static var v3:Vec3;
		public static function get(x:Number, y:Number, z:Number):Vec3 {
			if (_position == _vec.length) {
				_vec.length *= 2;
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new Vec3();
				}
			}
			_position++;
			_vec[_position - 1].x = x;
			_vec[_position - 1].y = y;
			_vec[_position - 1].z = z;
			
			return _vec[_position - 1];
		}
		
		public static function recycle(v:Vec3):void {
			if (_position == 0) return;
			_vec[_position - 1] = v;
			_position--;
			if (_position < 0) _position = 0;
			
			if (_vec.length >= 4) {
				if (_position < _vec.length / 4) _vec.length /= 2;
			}
		}
	}
}