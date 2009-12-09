package idv.cjcat.zedbox.display {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import idv.cjcat.zedbox.geom.Matrix3D;
	import idv.cjcat.zedbox.zb;
	import idv.cjcat.zedbox.ZedBoxMath;
	
	use namespace zb;
	
	public class ZedSprite extends Sprite implements IZedBoxSprite {
		
		private var _rotationOrder:int = RotationOrder.ZYX;
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _z:Number = 0;
		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		private var _scaleZ:Number = 1;
		/** @private */
		zb var _matrix:Matrix3D = new Matrix3D();
		/** @private */
		zb var _flatMatrix:Matrix3D = new Matrix3D();
		
		/** @private */
		zb var _parent:Sprite;
		/** @private */
		zb var _zsChildren:Array = new Array();
		/** @private */
		zb var _doChildren:Array = new Array();
		/** @private */
		zb var _outOfRange:Boolean = false;
		/** @private */
		zb var _visibleBeforeOutOfRange:Boolean = true;
		
		public function ZedSprite(displayObject:DisplayObject = null) {
			if (displayObject) addChild(displayObject);
		}
		
		private var _transformDirty:Boolean = true;
		public function updateMatrix():Boolean {
			if (_transformDirty) {
				_matrix.set(_rotationX, _rotationY, _rotationZ, scaleX, scaleY, scaleZ, x, y, z, rotationOrder);
				_transformDirty = false;
				return true;
			}
			return false;
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
		override public function set x(value:Number):void { _x = value; _transformDirty = true; }
		override public function get y():Number { return _y; }
		override public function set y(value:Number):void { _y = value; _transformDirty = true; }
		override public function get z():Number { return _z; }
		override public function set z(value:Number):void { _z = value; _transformDirty = true; }
		/**
		 * 
		 * @param	angle  In degrees.
		 */
		override public function get rotationX():Number { return _rotationX * ZedBoxMath.RADIAN_TO_DEGREE; }
		override public function set rotationX(value:Number):void { _rotationX = value * ZedBoxMath.DEGREE_TO_RADIAN; _transformDirty = true; }
		/**
		 * 
		 * @param	angle  In degrees.
		 */
		override public function get rotationY():Number { return _rotationY * ZedBoxMath.RADIAN_TO_DEGREE; }
		override public function set rotationY(value:Number):void { _rotationY = value * ZedBoxMath.DEGREE_TO_RADIAN; _transformDirty = true; }
		/**
		 * 
		 * @param	angle  In degrees.
		 */
		override public function get rotationZ():Number { return _rotationZ * ZedBoxMath.RADIAN_TO_DEGREE; }
		override public function set rotationZ(value:Number):void { _rotationZ = value * ZedBoxMath.DEGREE_TO_RADIAN; _transformDirty = true; }
		public function get rotationOrder():int { return _rotationOrder; }
		public function set rotationOrder(value:int):void { _rotationOrder = value; _transformDirty = true; }
		
		override public function set rotation(value:Number):void { return; }
		
		override public function get scaleX():Number { return _scaleX; }
		override public function set scaleX(value:Number):void { _scaleX = value; _transformDirty = true; }
		override public function get scaleY():Number { return _scaleY; }
		override public function set scaleY(value:Number):void { _scaleY = value; _transformDirty = true; }
		override public function get scaleZ():Number { return _scaleZ; }
		override public function set scaleZ(value:Number):void { _scaleZ = value; _transformDirty = true; }
		
		public function get screenX():Number { return super.x; }
		public function get screenY():Number { return super.y; }
		
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