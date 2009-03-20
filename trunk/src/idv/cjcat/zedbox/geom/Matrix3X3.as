package idv.cjcat.zedbox.geom {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	
	public class Matrix3X3 {
		
		zb var a11:Number;
		zb var a12:Number;
		zb var a13:Number;
		zb var a21:Number;
		zb var a22:Number;
		zb var a23:Number;
		zb var a31:Number;
		zb var a32:Number;
		zb var a33:Number;
		public function Matrix3X3(a11:Number = 1, a12:Number = 0, a13:Number = 0, a21:Number = 0, a22:Number = 1, a23:Number = 0, a31:Number = 0, a32:Number = 0, a33:Number = 1) {
			this.a11 = a11;
			this.a12 = a12;
			this.a13 = a13;
			this.a21 = a21;
			this.a22 = a22;
			this.a23 = a23;
			this.a31 = a31;
			this.a32 = a32;
			this.a33 = a33;
		}
		
		public function transform(vec3:Vec3):Vec3 {
			
			//to be done
			
			return new Vec3();
		}
		
		public function concat(matrix3X3:Matrix3X3):Matrix3X3 {
			
			//to be done
			
			return new Matrix3X3();
		}
	}
}