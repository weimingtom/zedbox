package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.errors.IllegalOperationError;
	
	public class ZedBoxMath {
		
		/**
		 * Clamps a value between bounds.
		 * 
		 * <listing>
		 * import idv.cjcat.CJMath;
		 * trace(CJMath.clamp(5, 3, 7));  //outputs 5
		 * trace(CJMath.clamp(1, 3, 7));  //outputs 3
		 * trace(CJMath.clamp(9, 3, 7));  //outputs 7</listing>
		 * 
		 * @param	input       Original value.
		 * @param	lowerBound  Lower bound.
		 * @param	upperBound  Upper bound.
		 * @return The original value clamped between two bounds.
		 */
		public static function clamp(input:Number, lowerBound:Number, upperBound:Number):Number {
			if (lowerBound > upperBound) throw new IllegalOperationError("the lowerBound must be less than the upperBound.");
			if (input < lowerBound) return lowerBound;
			if (input > upperBound) return upperBound;
			return input;
		}
		
		/**
		 * Interpolates between/beyond (x1, y1) and (x2, y2).
		 * @param	x1  First X value.
		 * @param	y1  First Y value.
		 * @param	x2  Second X value.
		 * @param	y2  Second Y value.
		 * @param	x3  Third X value.
		 * @param	usePercentage Whether x3 is absolute value or relative value.
		 * @return Third Y value.
		 */
		public static function interpolate(x1:Number, y1:Number, x2:Number, y2:Number, x3:Number):Number {
			if (x1 == x2) throw new IllegalOperationError("x1 must not equal to x2.");
			return y1 - ((y1 - y2) * (x1 - x3) / (x1 - x2));
		}
	}
}