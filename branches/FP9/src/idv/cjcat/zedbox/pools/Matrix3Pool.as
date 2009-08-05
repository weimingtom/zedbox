package idv.cjcat.zedbox.pools {
	import idv.cjcat.zedbox.geom.*;
	
	/** @private */
	public class Matrix3Pool {
		
		private static var _vec:Array = [new Matrix3()];
		private static var _position:int = 0;
		
		public static function get(a:Number, b:Number, c:Number, d:Number, e:Number, f:Number, g:Number, h:Number, i:Number, tx:Number, ty:Number, tz:Number):Matrix3 {
			if (_position == _vec.length) {
				_vec.length *= 2;
				for (var k:int = _position; k < _vec.length; k++) {
					_vec[k] = new Matrix3();
				}
			}
			_position++;
			var obj:Matrix3 = _vec[_position - 1] as Matrix3;
			obj.a = a;
			obj.b = b;
			obj.c = c;
			obj.d = d;
			obj.e = e;
			obj.f = f;
			obj.g = g;
			obj.h = h;
			obj.i = i;
			obj.tx = tx;
			obj.ty = ty;
			obj.tz = tz;
			return obj;
		}
		
		public static function recycle(obj:Matrix3):void {
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