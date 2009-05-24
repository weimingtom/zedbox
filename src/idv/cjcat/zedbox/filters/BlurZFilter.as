package idv.cjcat.zedbox.filters {
	use namespace zb;
	
	import flash.filters.BlurFilter;
	
	import idv.cjcat.zedbox.*;
	
	public class BlurZFilter implements IZFilter {
		
		private var _nearPlane:Number;  //small
		private var _farPlane:Number;  //large
		private var _nearRange:Number;
		private var _farRange:Number;
		
		/**
		 * The maximum amount of blur.
		 */
		public var blur:Number = 10;
		/**
		 * The quality of blur. 1 for the worst quality, 2 for medium quality, and 3 for the best quality.
		 */
		public var quality:int = 1;
		
		/**
		 * Creates a z-filter that applies a depth-of-field blurring effect.
		 * @param	nearPlane  The near z plane.
		 * @param	farPlane   The far z plane.
		 * @param	range  The range of variation.
		 */
		public function BlurZFilter(nearPlane:Number = 0, farPlane:Number = 2000, range:Number = 100, blur:Number = 10, quality:int = 1) {
			this.nearPlane = nearPlane;
			this.farPlane = farPlane;
			_nearRange = _farRange = range;
			this.blur = blur;
			this.quality = quality;
		}
		
		private var dz:Number;
		private var filter:BlurFilter;
		public function process(data:ZedData):void {
			dz = data._cameraDiff.z;
			if ((dz >= (_nearPlane + _nearRange)) && (dz <= (_farPlane - _farRange))) {
				data._zs.filters = [];
				return;
			}
			filter = new BlurFilter();
			filter.quality = quality;
			if (dz < (_nearPlane + _nearRange)) {
				filter.blurX = filter.blurY = ZedBoxMath.clamp(ZedBoxMath.interpolate(_nearPlane + _nearRange, 0, _nearPlane, blur, dz), 0, blur);
				data._zs.filters = [filter];
				return;
			} else if (dz > (_farPlane - _farRange)) {
				filter.blurX = filter.blurY = ZedBoxMath.clamp(ZedBoxMath.interpolate(_farPlane - _farRange, 0, _farPlane, blur, dz), 0, blur);
				data._zs.filters = [filter];
				return;
			}
		}
		
		public function restore(data:ZedData):void {
			data._zs.filters = [];
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