/**
 * Vec3
 * 
 * @author		Allen Chou
 * @version		1.0.4 (last update: Nov 16 2008)
 * @link        http://cjcat.blogspot.com
 * @link		http://cjcat2266.deviantart.com
 */

package idv.cjcat.zedbox.geom {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import idv.cjcat.*;
	
	/**
	 * A <code>Vec3</code> object represents a vector in 2D space.
	 */
	public class Vec3 {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Vec3(x:Number = 0, y:Number = 0, z:Number = 0) {
			set(x, y, z);
		}
		
		public function set(x:Number, y:Number, z:Number):void {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function add(vector:Vec3):Vec3 {
			return new Vec3(this.x + vector.x, this.y + vector.y, this.z + vector.z);
		}
		
		public function subtract(vector:Vec3):Vec3 {
			return new Vec3(this.x - vector.x, this.y - vector.y, this.z - vector.z);
		}
		
		/**
		 * Copies a vector.
		 * @return The copy.
		 */
		public function clone():Vec3 {
			return new Vec3(x, y, z);
		}
		
		/**
		 * Calculates the dot product of two vectors.
		 * @param	vector  Another vector.
		 * @return The dot product.
		 */
		public function dot(vector:Vec3):Number {
			return (x * vector.x) + (y * vector.y) + (z * vector.z);
		}
		
		/**
		 * Calcultes the cross product of two vectors
		 * @param	vector  Another vector.
		 * @return The cross product.
		 */
		public function cross(vector:Vec3):Vec3 {
			return new Vec3(this.y * vector.z - this.z - vector.y, this.z * vector.x - this.x * vector.z, this.x * vector.y - this.y * vector.x);
		}
		
		/**
		 * Calculate the projection of one vector onto another.
		 * @param	target  The target vector.
		 * @return The projected vector obtained.
		 */
		public function project(target:Vec3):Vec3 {
			target = target.unitVec();
			target.length = this.dot(target);
			return target;
		}
		
		/**
		 * Returns the result of a vector after rotated by a specified angle.
		 * @param	angle      The angle of rotation.
		 * @param	radian     Whether the unit of angle is radian; otherwise, it's in degree.
		 * @param	clockwise  Whether the rotation is clockwise; otherwise, it's counterclockwise.
		 * @return The rotated vector.
		 */
		public function rotateZ(angle:Number, useAngle:Boolean = false, clockwise:Boolean = false):Vec3 {
			var factor:Number = (clockwise)?(1):(-1);
			if (useAngle) angle = angle * Math.PI / 180;
			
			var temp:Vec3 = new Vec3(x * Math.cos(angle) + y * factor * Math.sin(angle), -x * factor * Math.sin(angle) + y * Math.cos(angle), z);
			temp.length = temp.length;
			
			return temp;
		}
		
		/**
		 * Returns the unit vector of a vector.
		 * @return The unit vector.
		 */
		public function unitVec():Vec3 {
			if (length == 0) return new Vec3();
			
			var vec:Vec3 = this.clone();
			vec.length = 1;
			return vec;
		}
		
		/**
		 * The square of the vector length.
		 */
		public function get lengthSQ():Number {
			return x * x + y * y + z * z;
		}
		
		/**
		 * Vector length;
		 */
		public function get length():Number { return Math.sqrt(lengthSQ); }
		public function set length(value:Number):void {
			var leng:Number = length;
			x = x * value / leng;
			y = y * value / leng;
			z = z * value / leng;
		}
	}
}