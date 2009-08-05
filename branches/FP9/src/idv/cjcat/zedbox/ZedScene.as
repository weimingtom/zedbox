package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	
	import idv.cjcat.zedbox.filters.*;
	import idv.cjcat.zedbox.geom.*;
	import idv.cjcat.zedbox.pools.*;
	
	public class ZedScene extends Sprite implements IZedBoxSprite {
		
		/** @private */
		zb var _zfilters:Array = [];
		
		/** @private */
		zb var _camera:Camera = new Camera();
		
		private var _zsChildren:Array = [];
		
		public function ZedScene() {
			
		}
		
		//rendering
		//------------------------------------------------------------------------------------------------
		
		private var _zdList:Array = [];
		private var cameraMatrix:Matrix3 = new Matrix3();
		public function render(e:Event = null):void {
			var zd:ZedData;
			var zs:ZedSprite;
			for each (zd in _zdList) ZedDataPool.recycle(zd);
			_zdList.length = 0;
			cameraMatrix.identity();
			cameraMatrix.rotateY(Math.atan2(-_camera._direction.x, _camera._direction.z));
			cameraMatrix.rotateX(Math.atan2(_camera._direction.y, Math.sqrt(_camera._direction.x * _camera._direction.x + _camera._direction.z * _camera._direction.z)));
			for each (zs in _zsChildren) addChildToScene(zs);
			
			_zdList.sort(zdSort);
			
			while (numChildren > 0) removeChildAt(0);
			for each (zd in _zdList) {
				zs = zd._zs;
				super.addChild(zs);
				
				if (zd._cameraDiff.z < 0) {
					if (!zs._outOfRange) {
						zs._outOfRange = true;
						zs._visibleBeforeOutOfRange = zs.visible;
						zs.visible = false;
					}
				} else {
					if (zs._outOfRange) {
						zs._outOfRange = false;
						zs.visible = zs._visibleBeforeOutOfRange;
					}
					
				}
				
				if (_camera.usePerspective) {
					var d:Number = zd._cameraDiff.z / _camera.focalLength;
					zs.superX = _camera.zoom * zd._cameraDiff.x / (d + 1);
					zs.superY = _camera.zoom * zd._cameraDiff.y / (d + 1);
					zs.superScaleX = zs.superScaleY = _camera.zoom / (d + 1);
				} else {
					zs.superX = _camera.zoom * zd._cameraDiff.x;
					zs.superY = _camera.zoom * zd._cameraDiff.y;
					zs.superScaleX = zs.superScaleY = 1;
				}
				
				var filter:IZFilter;
				if (zs.visible) for each (filter in _zfilters) filter.process(zd);
				else for each (filter in _zfilters) filter.restore(zd);
			}
		}
		
		private var m:Matrix3;
		private var _cameraDiff:Vec3 = new Vec3();
		private function addChildToScene(zs:ZedSprite):void {
			m = zs.getMatrix();
			_cameraDiff.set(m.tx - _camera._position.x, m.ty - _camera._position.y, m.tz - _camera._position.z);
			cameraMatrix.transformThisVec(_cameraDiff);
			_zdList.push(ZedDataPool.get(zs, _cameraDiff));
			for each (var sprite:ZedSprite in zs._zsChildren) addChildToScene(sprite);
		}
		
		private function zdSort(zd1:ZedData, zd2:ZedData):Number {
			if (zd1._cameraDiff.z > zd2._cameraDiff.z) return -1;
			return 1;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of rendering
		
		override public function addChild(obj:DisplayObject):DisplayObject {
			if (obj is ZedSprite) {
				var zs:ZedSprite = obj as ZedSprite;
				var index:int = _zsChildren.indexOf(zs);
				if (index == -1) {
					if (zs._parent != null) zs._parent.removeChild(zs);
					ZedSprite(obj)._parent = this;
					_zsChildren.push(zs);
				}
			} else throw new IllegalOperationError("The child must be a ZedSprite.");
			return obj;
		}
		
		override public function removeChild(obj:DisplayObject):DisplayObject {
			if (obj is ZedSprite) {
				var zs:ZedSprite = obj as ZedSprite;
				var index:int = _zsChildren.indexOf(zs);
				if (index >= 0) {
					zs._parent = null;
					_zsChildren.splice(index, 1);
				}
			} else throw new IllegalOperationError("The child must be a ZedSprite.");
			return obj;
		}
		
		
		//accessors
		//------------------------------------------------------------------------------------------------
		
		public function get zFilters():Array { return _zfilters; }
		public function get camera():Camera { return _camera; }
		
		//------------------------------------------------------------------------------------------------
		//end of accessors
	}
}