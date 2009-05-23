package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.display.*;
	import flash.errors.*;
	
	import idv.cjcat.zedbox.geom.*;
	
	public class ZedSprite extends Sprite {
		
		/** @private */
		zb var _x:Number = 0;
		/** @private */
		zb var _y:Number = 0;
		/** @private */
		zb var _z:Number = 0;
		/** @private */
		zb var _rotationX:Number = 0;
		/** @private */
		zb var _rotationY:Number = 0;
		/** @private */
		zb var _rotationZ:Number = 0;
		/** @private */
		zb var _scaleX:Number = 1;
		/** @private */
		zb var _scaleY:Number = 1;
		/** @private */
		zb var _scaleZ:Number = 1;
		
		/** @private */
		zb var _parent:Sprite;
		/** @private */
		zb var _zsChildren:Vector.<ZedSprite> = new Vector.<ZedSprite>();
		/** @private */
		zb var _doChildren:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		/** @private */
		zb var _outOfRange:Boolean = false;
		/** @private */
		zb var _visibleBeforeOutOfRange:Boolean = true;
		
		public function ZedSprite() {
			
		}
		
		public function getMatrix():Matrix3 {
			var matrix:Matrix3 = new Matrix3();
			matrix.set(_rotationX, _rotationY, _rotationZ, _scaleX, _scaleY, _scaleZ, _x, _y, _z);
			
			if (_parent is ZedScene) {
				return matrix;
			} else {
				return ZedSprite(_parent).getMatrix().concat(matrix);
			}
		}
		
		override public function addChild(obj:DisplayObject):DisplayObject {
			var index:int;
			if (obj is ZedSprite) {
				var zs:ZedSprite = obj as ZedSprite;
				index = _zsChildren.indexOf(zs);
				if (index == -1) {
					if (zs._parent != null) zs._parent.removeChild(zs);
					zs._parent = this;
					_zsChildren.push(zs);
				}
			} else if (obj is DisplayObject) {
				index = _doChildren.indexOf(obj);
				if (index == -1) {
					_doChildren.push(obj);
					super.addChild(obj);
				}
			} else throw new IllegalOperationError("The child must be either a DisplayObject or a ZedSprite.");
			return obj;
		}
		
		override public function removeChild(obj:DisplayObject):DisplayObject {
			var index:int = _doChildren.indexOf(obj);
			if (index >= 0) {
				_doChildren.splice(index, 1);
				super.removeChild(obj);
				return obj;
			}
			index = _zsChildren.indexOf(obj as ZedSprite);
			if (index >= 0) {
				ZedSprite(obj)._parent = null;
				_zsChildren.splice(index, 1);
				return obj;
			}
			return obj;
		}
		
		override public function get x():Number { return _x; }
		override public function set x(value:Number):void { _x = value; }
		override public function get y():Number { return _y; }
		override public function set y(value:Number):void { _y = value; }
		override public function get z():Number { return _z; }
		override public function set z(value:Number):void { _z = value; }
		/**
		 * 
		 * @param	angle  In degrees.
		 */
		override public function get rotationX():Number { return _rotationX * 57.29577951; }
		override public function set rotationX(value:Number):void { _rotationX = value * 0.0174532925; }
		/**
		 * 
		 * @param	angle  In degrees.
		 */
		override public function get rotationY():Number { return _rotationY * 57.29577951; }
		override public function set rotationY(value:Number):void { _rotationY = value * 0.0174532925;
		/**
		 * 
		 * @param	angle  In degrees.
		 */}
		override public function get rotationZ():Number { return _rotationZ * 57.29577951; }
		override public function set rotationZ(value:Number):void { _rotationZ = value * 0.0174532925; }
		
		override public function set rotation(value:Number):void { return; }
		
		override public function get scaleX():Number { return _scaleX; }
		override public function set scaleX(value:Number):void { _scaleX = value; }
		override public function get scaleY():Number { return _scaleY; }
		override public function set scaleY(value:Number):void { _scaleY = value; }
		override public function get scaleZ():Number { return _scaleZ; }
		override public function set scaleZ(value:Number):void { _scaleZ = value; }
		
		/** @private */
		zb function get superX():Number { return super.x; }
		/** @private */
		zb function set superX(value:Number):void { super.x = value; }
		/** @private */
		zb function get superY():Number { return super.y; }
		/** @private */
		zb function set superY(value:Number):void { super.y = value; }
		/** @private */
		zb function get superZ():Number { return super.z; }
		/** @private */
		zb function set superZ(value:Number):void { super.z = value; }
		/** @private */
		zb function get superRotation():Number { return super.rotation; }
		/** @private */
		zb function set superRotation(value:Number):void { super.rotation = value; }
		/** @private */
		zb function get superScaleX():Number { return super.scaleX; }
		/** @private */
		zb function set superScaleX(value:Number):void { super.scaleX = value; }
		/** @private */
		zb function get superScaleY():Number { return super.scaleY; }
		/** @private */
		zb function set superScaleY(value:Number):void { super.scaleY = value; }
		
		override public function get parent():DisplayObjectContainer { return _parent; }
		override public function get numChildren():int { return _doChildren.length + _zsChildren.length; }
	}
}