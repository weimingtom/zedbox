package idv.cjcat.zedbox.geom {
	
	/** @private */
	public class Vec3DPool {
		
		private static var _vec:Array = [new Vec3D()];
		private static var _position:int = 0;
		
		private static var v3:Vec3D;
		public static function get(x:Number, y:Number, z:Number):Vec3D {
			if (_position == _vec.length) {
				_vec.length *= 2;
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new Vec3D();
				}
			}
			_position++;
			_vec[_position - 1].x = x;
			_vec[_position - 1].y = y;
			_vec[_position - 1].z = z;
			
			return _vec[_position - 1];
		}
		
		public static function recycle(v:Vec3D):void {
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