package idv.cjcat.zedbox.pools {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	import idv.cjcat.zedbox.geom.*;
	
	/** @private */
	public class ZedDataPool {
		
		private static var _vec:Vector.<ZedData> = Vector.<ZedData>([new ZedData()]);
		private static var _position:int = 0;
		
		public static function get(zs:ZedSprite, cameraDiff:Vec3):ZedData {
			if (_position == _vec.length) {
				_vec.length *= 2;
				for (var i:int = _position; i < _vec.length; i++) {
					_vec[i] = new ZedData();
				}
			}
			_position++;
			
			_vec[_position - 1]._zs = zs;
			_vec[_position - 1]._cameraDiff.set(cameraDiff.x, cameraDiff.y, cameraDiff.z);
			return _vec[_position - 1];
		}
		
		public static function recycle(obj:ZedData):void {
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