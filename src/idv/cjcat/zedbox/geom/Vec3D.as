package idv.cjcat.zedbox.geom {
	
	public class Vec3D {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Vec3D(x:Number = 0, y:Number = 0, z:Number = 0) {
			this.set(x, y, z);
		}
		
		public function set(x:Number, y:Number, z:Number):void {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function dot(v:Vec3D):Number {
			return x * v.x + y * v.y + z * v.z;
		}
		
		public function cross(v:Vec3D):Vec3D {
			return new Vec3D((y * v.z - z * v.y), (z * v.x - x * v.z), (x * v.y - y * v.x));
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
		
		public function unitVec():Vec3D {
			var len:Number = length;
			return new Vec3D(x / len, y / len, z / len);
		}
		
		public function rotateThis(axis:Vec3D, angle:Number):void {
			var temp:Vec3D = rotate(axis, angle);
			this.x = temp.x;
			this.y = temp.y;
			this.z = temp.z;
		}
		
		public function project(target:Vec3D):Vec3D {
			target = target.unitVec();
			target.length = dot(target);
			return target;
		}
		
		public function rotate(axis:Vec3D, angle:Number):Vec3D {
			var n:Vec3D = axis.unitVec();
			var dotProd:Number = this.dot(n);
			var par:Vec3D = new Vec3D(dotProd * n.x, dotProd * n.y, dotProd * n.z);
			var per:Vec3D = new Vec3D(x - par.x, y - par.y, z - par.z);
			var w:Vec3D = n.cross(this);
			
			var cosine:Number = Math.cos(angle);
			var sine:Number = Math.sin(angle);
			
			return new Vec3D((cosine * per.x + sine * w.x + par.x), (cosine * per.y + sine * w.y + par.y), (cosine * per.z + sine * w.z + par.z));
		}
		
		public function clone():Vec3D { return new Vec3D(x, y, z); }
		
		public function toString():String {
			return "[Vec3D x=" + x + ", y=" + y + ", z=" + z + "]";
		}
	}
}