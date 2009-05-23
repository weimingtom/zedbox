package idv.cjcat.zedbox.geom {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	import idv.cjcat.zedbox.pools.*;
	
	public class Matrix3 {
		
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var d:Number;
		public var e:Number;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var i:Number;
		public var tx:Number;
		public var ty:Number;
		public var tz:Number;
		
		public function Matrix3(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 0, e:Number = 1, f:Number = 0, g:Number = 0, h:Number = 0, i:Number = 1, tx:Number = 0, ty:Number = 0, tz:Number = 0) {
			this.a = a;	this.b = b;	this.c = c;
			this.d = d;	this.e = e;	this.f = f;
			this.g = g;	this.h = h;	this.i = i;
			this.tx = tx; this.ty = ty; this.tz = tz;
		}
		
		public function set(rotationX:Number = 0, rotationY:Number = 0, rotationZ:Number = 0, scaleX:Number = 1, scaleY:Number = 1, scaleZ:Number = 1, tx:Number = 0, ty:Number = 0, tz:Number = 0):void {
			identity();
			if (rotationZ != 0) rotateZ(rotationZ);
			if (rotationY != 0) rotateY(rotationY);
			if (rotationX != 0) rotateX(rotationX);
			if (scaleX != 1 || scaleY != 1 || scaleZ != 1) scale(scaleX, scaleY, scaleZ);
			if (tx != 0 || ty != 0 || tz != 0) translate(tx, ty, tz);
		}
		
		public function transformThisVec(v:Vec3):Vec3 {
			v.set((a * v.x + b * v.y + c * v.z + tx), (d * v.x + e * v.y + f * v.z + ty), (g * v.x + h * v.y + i * v.z + tz));
			return v;
		}
		
		public function transform(v:Vec3):Vec3 {
			return transformThisVec(v.clone());
		}
		
		public function concat(m:Matrix3):Matrix3 {
			var thisClone:Matrix3 = clone();
			a = thisClone.a * m.a + thisClone.b * m.d + thisClone.c * m.g;
			b = thisClone.a * m.b + thisClone.b * m.e + thisClone.c * m.h;
			c = thisClone.a * m.c + thisClone.b * m.f + thisClone.c * m.i;
			d = thisClone.d * m.a + thisClone.e * m.d + thisClone.f * m.g;
			e = thisClone.d * m.b + thisClone.e * m.e + thisClone.f * m.h;
			f = thisClone.d * m.c + thisClone.e * m.f + thisClone.f * m.i;
			g = thisClone.g * m.a + thisClone.h * m.d + thisClone.i * m.g;
			h = thisClone.g * m.b + thisClone.h * m.e + thisClone.i * m.h;
			i = thisClone.g * m.c + thisClone.h * m.f + thisClone.i * m.i;
			tx = thisClone.a * m.tx + thisClone.b * m.ty + thisClone.c * m.tz + thisClone.tx;
			ty = thisClone.d * m.tx + thisClone.e * m.ty + thisClone.f * m.tz + thisClone.ty;
			tz = thisClone.g * m.tx + thisClone.h * m.ty + thisClone.i * m.tz + thisClone.tz;
			return this;
		}
		
		public function identity():void {
			a = 1; b = 0; c = 0;
			d = 0; e = 1; f = 0;
			g = 0; h = 0; i = 1;
			tx = ty = tz = 0;
		}
		
		private var temp:Matrix3;
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public function rotateX(angle:Number):void {
			temp = Matrix3Pool.get(1, 0, 0, 0, Math.cos(angle), -Math.sin(angle), 0, Math.sin(angle), Math.cos(angle), 0, 0, 0);
			concat(temp);
			Matrix3Pool.recycle(temp);
			temp = null;
		}
		
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public function rotateY(angle:Number):void {
			temp = Matrix3Pool.get(Math.cos(angle), 0, Math.sin(angle), 0, 1, 0, -Math.sin(angle), 0, Math.cos(angle), 0, 0, 0);
			concat(temp);
			Matrix3Pool.recycle(temp);
			temp = null;
		}
		
		/**
		 * 
		 * @param	angle  In radians.
		 */
		public function rotateZ(angle:Number):void {
			temp = Matrix3Pool.get(Math.cos(angle), -Math.sin(angle), 0, Math.sin(angle), Math.cos(angle), 0, 0, 0, 1, 0, 0, 0);
			concat(temp);
			Matrix3Pool.recycle(temp);
			temp = null;
		}
		
		public function scale(x:Number, y:Number, z:Number):void {
			temp = Matrix3Pool.get(x, 0, 0, 0, y, 0, 0, 0, z, 0, 0, 0);
			concat(temp);
			Matrix3Pool.recycle(temp);
			temp = null;
		}
		
		public function translate(x:Number, y:Number, z:Number):void {
			tx += x; ty += y; tz += z;
		}
		
		public function clone():Matrix3 {
			return new Matrix3(a, b, c, d, e, f, g, h, i, tx, ty, tz);
		}
		
		public function toString():String {
			return "[Matrix3 a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", e=" + e + ", f=" + f + ", g=" + g + ", h=" + h + ", i=" + i + ", tx=" + tx + ", ty=" + ty + ", tz=" + tz + "]";
		}
	}
}