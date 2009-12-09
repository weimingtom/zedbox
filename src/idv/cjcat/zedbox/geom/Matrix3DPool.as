package idv.cjcat.zedbox.geom {
	
	/** @private */
	public class Matrix3DPool {
		
		private static var _vec:Array = [new Matrix3D()];
		private static var _position:int = 0;
		
		public static function get(a:Number, b:Number, c:Number, d:Number, e:Number, f:Number, g:Number, h:Number, i:Number, tx:Number, ty:Number, tz:Number):Matrix3D {
			if (_position == _vec.length) {
				_vec.length *= 2;
				for (var k:int = _position; k < _vec.length; k++) {
					_vec[k] = new Matrix3D();
				}
			}
			_position++;
			_vec[_position - 1].a = a;
			_vec[_position - 1].b = b;
			_vec[_position - 1].c = c;
			_vec[_position - 1].d = d;
			_vec[_position - 1].e = e;
			_vec[_position - 1].f = f;
			_vec[_position - 1].g = g;
			_vec[_position - 1].h = h;
			_vec[_position - 1].i = i;
			_vec[_position - 1].tx = tx;
			_vec[_position - 1].ty = ty;
			_vec[_position - 1].tz = tz;
			return _vec[_position - 1];
		}
		
		public static function recycle(obj:Matrix3D):void {
			if (_position == 0) return;
			_vec[_position - 1] = obj;
			_position--;
			if (_position < 0) _position = 0;
			
			if (_vec.length >= 4) {
				if (_position < _vec.length / 4) _vec.length /= 2;
			}
		}
	}
}