package idv.cjcat.zedbox.actions {
	import flash.filters.BlurFilter;
	import idv.cjcat.stardust.common.actions.Action;
	import idv.cjcat.zedbox.geom.ZedData;
	import idv.cjcat.zedbox.ZedBoxMath;
	
	/**
	 * Applies a depth-of-field blurring effect.
	 * @param	nearPlane  The near z plane.
	 * @param	farPlane   The far z plane.
	 * @param	range  The range of variation.
	 */
	public class DOFBlur extends Action {
		
		private var _nearPlane:Number;  //small
		private var _farPlane:Number;  //large
		private var _nearRange:Number;
		private var _farRange:Number;
		
		/**
		 * The maximum amount of blur.
		 */
		private var _blur:Number = 10;
		/**
		 * The quality of blur. 1 for the worst quality, 2 for medium quality, and 3 for the best quality.
		 */
		private var _quality:int = 1;
		
		public function DOFBlur(nearPlane:Number = 700, farPlane:Number = 1300, range:Number = 100, blur:Number = 10, quality:int = 1) {
			this.nearPlane = nearPlane;
			this.farPlane = farPlane;
			_nearRange = _farRange = range;
			_blur = blur;
			_quality = quality;
			updateFilter();
		}
		
		private var filter:BlurFilter = new BlurFilter();
		override public function update(data:ZedData):void {
			var dz:Number = data.cameraDiff.z;
			if ((dz >= (_nearPlane + _nearRange)) && (dz <= (_farPlane - _farRange))) {
				data.zedSprite.filters = [];
				return;
			}
			
			var actualBlur:Number = 0;
			if (dz < (_nearPlane + _nearRange)) {
				actualBlur = ZedBoxMath.clamp(ZedBoxMath.interpolate(_nearPlane + _nearRange, 0, _nearPlane, blur, dz), 0, blur);
			} else if (dz > (_farPlane - _farRange)) {
				actualBlur = ZedBoxMath.clamp(ZedBoxMath.interpolate(_farPlane - _farRange, 0, _farPlane, blur, dz), 0, blur);
			}
			actualBlur = int(actualBlur + 0.5);
			
			var existingFilter:BlurFilter = data.zedSprite.filters[0] as BlurFilter;
			if (existingFilter) {
				if (!(existingFilter.blurX - actualBlur)) return;
			}
			filter.blurX = filter.blurY = actualBlur;
			data.zedSprite.filters = [filter];
		}
		
		override public function restore(data:ZedData):void {
			data.zedSprite.filters = [];
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
		
		
		//filter
		//------------------------------------------------------------------------------------------------
		
		public function get blur():Number { return _blur; }
		public function set blur(value:Number):void {
			_blur = value;
			//updateFilter();
		}
		
		public function get quality():int { return _quality; }
		public function set quality(value:int):void {
			_quality = value;
			updateFilter();
		}
		
		private function updateFilter():void {
			filter.quality = quality;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of filter
	}
}