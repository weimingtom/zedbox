package idv.cjcat.zedbox.geom {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	
	public class Vec3 {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Vec3(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.set(x, y, z);
		}
		
		public function set(x:Number, y:Number, z:Number):void {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function dot(v:Vec3):Number {
			return x * v.x + y * v.y + z * v.z;
		}
		
		public function cross(v:Vec3):Vec3 {
			return new Vec3((y * v.z - z * v.y), (z * v.x - x * v.z), (x * v.y - y * v.x));
		}
		
		public function lengthSQ():Number { return x * x + y * y + z * z; }
		public function get length():Number { return Math.sqrt(x * x + y * y + z * z); }
		public function set length(value:Number):void {
			var leng:Number = length;
			var ratio:Number = value / leng;
			x *= ratio;
			y *= ratio;
			z *= ratio;
		}
		
		public function unitVec():Vec3 {
			var len:Number = length;
			return new Vec3(x / len, y / len, z / len);
		}
		
		public function rotateThis(axis:Vec3, angle:Number):void {
			var temp:Vec3 = rotate(axis, angle);
			this.x = temp.x;
			this.y = temp.y;
			this.z = temp.z;
		}
		
		public function project(target:Vec3):Vec3 {
			target = target.unitVec();
			target.length = dot(target);
			return target;
		}
		
		public function rotate(axis:Vec3, angle:Number):Vec3 {
			var n:Vec3 = axis.unitVec();
			var dotProd:Number = this.dot(n);
			var par:Vec3 = new Vec3(dotProd * n.x, dotProd * n.y, dotProd * n.z);
			var per:Vec3 = new Vec3(x - par.x, y - par.y, z - par.z);
			var w:Vec3 = n.cross(this);
			
			var cosine:Number = Math.cos(angle);
			var sine:Number = Math.sin(angle);
			
			return new Vec3((cosine * per.x + sine * w.x + par.x), (cosine * per.y + sine * w.y + par.y), (cosine * per.z + sine * w.z + par.z));
		}
		
		public function clone():Vec3 { return new Vec3(x, y, z); }
		
		public function toString():String {
			return "[Vec3 x=" + x + ", y=" + y + ", z=" + z + "]";
		}
	}
}