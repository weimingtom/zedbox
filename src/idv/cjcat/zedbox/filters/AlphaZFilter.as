package idv.cjcat.zedbox.filters {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	
	public class AlphaZFilter implements IZFilter {
		
		private var _nearPlane:Number;  //small
		private var _farPlane:Number;  //large
		private var _nearRange:Number;
		private var _farRange:Number;
		
		/**
		 * Creates a z-filter that applies a depth-of-field alpha variation effect.
		 * @param	nearPlane  The near z plane.
		 * @param	farPlane   The far z plane.
		 * @param	range  The range of variation.
		 */
		public function AlphaZFilter(nearPlane:Number = 0, farPlane:Number = 2000, range:Number = 100) {
			this.nearPlane = nearPlane;
			this.farPlane = farPlane;
			_nearRange = _farRange = range;
		}
		
		private var dz:Number;
		public function process(data:ZedData):void {
			dz = data._cameraDiff.z;
			if ((dz >= (_nearPlane + _nearRange)) && (dz <= (_farPlane - _farRange))) {
				data._zs.alpha = 1;
				return;
			}
			if (dz < (_nearPlane + _nearRange)) {
				data._zs.alpha = ZedBoxMath.clamp(ZedBoxMath.interpolate(_nearPlane + _nearRange, 1, _nearPlane, 0, dz), 0, 1);
				return;
			} else if (dz > (_farPlane - _farRange)) {
				data._zs.alpha = ZedBoxMath.clamp(ZedBoxMath.interpolate(_farPlane - _farRange, 1, _farPlane, 0, dz), 0, 1);
				return;
			}
		}
		
		public function restore(data:ZedData):void {
			data._zs.alpha = 0;
		}
		
		/**
		 * The near z plane.
		 */
		public function get nearPlane():Number { return _nearPlane; }
		public function set nearPlane(value:Number):void { _nearPlane = ZedBoxMath.clamp(value, -Number.MAX_VALUE, _farPlane); }
		/**
		 * The near range of variation.
		 */
		public function get nearRange():Number { return _nearRange; }
		public function set nearRange(value:Number):void { _nearRange = ZedBoxMath.clamp(value, 0, Number.MAX_VALUE); }
		/**
		 * The far z plane.
		 */
		public function get farPlane():Number { return _farPlane; }
		public function set farPlane(value:Number):void { _farPlane = ZedBoxMath.clamp(value, _nearPlane, Number.MAX_VALUE); }
		/**
		 * The far range of variation.
		 */
		public function get farRange():Number { return _farRange; }
		public function set farRange(value:Number):void { _farRange = ZedBoxMath.clamp(value, 0, Number.MAX_VALUE); }
	}
	
}