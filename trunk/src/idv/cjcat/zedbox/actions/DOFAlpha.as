package idv.cjcat.zedbox.actions {
	import idv.cjcat.zedbox.geom.ZedData;
	import idv.cjcat.zedbox.ZedBoxMath;
	
	/**
	 * Applies a depth-of-field alpha variation effect.
	 * @param	nearPlane  The near z plane.
	 * @param	farPlane   The far z plane.
	 * @param	range  The range of variation.
	 */
	public class DOFAlpha extends Action {
		
		private var _nearPlane:Number;  //small
		private var _farPlane:Number;  //large
		private var _nearRange:Number;
		private var _farRange:Number;
		
		public function DOFAlpha(nearPlane:Number = 0, farPlane:Number = 2000, range:Number = 100) {
			this.nearPlane = nearPlane;
			this.farPlane = farPlane;
			_nearRange = _farRange = range;
		}
		
		override public function update(data:ZedData):void {
			var dz:Number = data.cameraDiff.z;
			if ((dz >= (_nearPlane + _nearRange)) && (dz <= (_farPlane - _farRange))) {
				data.zedSprite.alpha = 1;
				return;
			}
			if (dz < (_nearPlane + _nearRange)) {
				data.zedSprite.alpha = ZedBoxMath.clamp(ZedBoxMath.interpolate(_nearPlane + _nearRange, 1, _nearPlane, 0, dz), 0, 1);
				return;
			} else if (dz > (_farPlane - _farRange)) {
				data.zedSprite.alpha = ZedBoxMath.clamp(ZedBoxMath.interpolate(_farPlane - _farRange, 1, _farPlane, 0, dz), 0, 1);
				return;
			}
		}
		
		override public function restore(data:ZedData):void {
			data.zedSprite.alpha = 1;
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