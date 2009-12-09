package idv.cjcat.zedbox.display {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import idv.cjcat.zedbox.actions.Action;
	import idv.cjcat.zedbox.actions.ActionCollection;
	import idv.cjcat.zedbox.actions.IActionCollector;
	import idv.cjcat.zedbox.cameras.Camera;
	import idv.cjcat.zedbox.geom.Matrix3D;
	import idv.cjcat.zedbox.geom.Vec3D;
	import idv.cjcat.zedbox.geom.ZedData;
	import idv.cjcat.zedbox.geom.ZedDataPool;
	import idv.cjcat.zedbox.zb;
	
	use namespace zb;
	
	public class ZedScene extends Sprite implements IZedBoxSprite, IActionCollector {
		
		private var _actionCollection:ActionCollection = new ActionCollection();
		private var _camera:Camera = new Camera();
		
		private var _zsChildren:Array = new Array();
		
		public function ZedScene() {
			
		}
		
		
		//accessors
		//------------------------------------------------------------------------------------------------
		
		public function get camera():Camera { return _camera; }
		
		//------------------------------------------------------------------------------------------------
		//end of accessors
		
		
		//rendering
		//------------------------------------------------------------------------------------------------
		
		private var _zdList:Array = new Array();
		private var cameraMatrix:Matrix3D = new Matrix3D();
		public function render(e:Event = null):void {
			var zd:ZedData;
			var zs:ZedSprite;
			for each (zd in _zdList) ZedDataPool.recycle(zd);
			_zdList.length = 0;
			
			//camera matrix
			cameraMatrix.identity();
			cameraMatrix.rotateY(Math.atan2(-_camera._direction.x, _camera._direction.z));
			cameraMatrix.rotateX(Math.atan2(_camera._direction.y, Math.sqrt(_camera._direction.x * _camera._direction.x + _camera._direction.z * _camera._direction.z)));
			
			calculateFlatMatrices();
			for each (zs in _zsChildren) addChildToScene(zs);
			
			_zdList.sort(zdSort);
			
			
			//while (numChildren > 0) removeChildAt(0);
			var i:int, len:int = _zdList.length;
			var action:Action;
			for each (action in _actionCollection.actions) action.preUpdate();
			for (i = 0; i < len; i++) {
				zd = _zdList[i];
				zs = zd._zs;
				super.addChildAt(zs, i);
				
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
				
				var factor:Number;
				if (_camera.usePerspective) {
					//var d:Number = zd._cameraDiff.z / _camera.focalLength;
					factor = _camera.zoom * _camera.focalLength / zd.cameraDiff.z;
					zs.superX = factor * zd.cameraDiff.x;
					zs.superY = factor * zd.cameraDiff.y;
					zs.superScaleX = zs.superScaleY = factor;
					//zs.superX = _camera.zoom * zd._cameraDiff.x / (d);
					//zs.superY = _camera.zoom * zd._cameraDiff.y / (d);
					//zs.superScaleX = zs.superScaleY = _camera.zoom / (d);
				} else {
					factor = _camera.zoom;
					zs.superX = factor * zd.cameraDiff.x;
					zs.superY = factor * zd.cameraDiff.y;
					zs.superScaleX = zs.superScaleY =factor;
				}
				
				for each (action in _actionCollection.actions) {
					action.update(zd);
				}
			}
			for each (action in _actionCollection.actions) action.postUpdate();
		}
		
		
		private function calculateFlatMatrices():void {
			var zs:ZedSprite;
			for each (zs in this._zsChildren) {
				zs.updateMatrix();
				zs._flatMatrix = zs._matrix;
				flattenChildrenMatrices(zs);
			}
		}
		
		private function flattenChildrenMatrices(zs:ZedSprite):void {
			var child:ZedSprite;
			for each (child in zs._zsChildren) {
				child.updateMatrix();
				child._flatMatrix = child._matrix.clone().preMultiply(zs._flatMatrix);
				flattenChildrenMatrices(child);
			}
		}
		
		private var m:Matrix3D;
		private var _cameraDiff:Vec3D = new Vec3D();
		private function addChildToScene(zs:ZedSprite):void {
			m = zs._flatMatrix;
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
		
		
		//actions
		//------------------------------------------------------------------------------------------------
		
		public function addAction(action:Action):void {
			_actionCollection.addAction(action);
		}
		
		public function removeAction(action:Action):void {
			for each (var data:ZedData in _zdList) {
				action.restore(data);
			}
			_actionCollection.removeAction(action);
		}
		
		public function clearActions():void {
			for each (var data:ZedData in _zdList) {
				for each (var action:Action in _actionCollection.actions) {
					action.restore(data);
				}
			}
			_actionCollection.clearActions();
		}
		
		//------------------------------------------------------------------------------------------------
		//end of actions
		
		
		//overridings
		//------------------------------------------------------------------------------------------------
		
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
					super.removeChild(obj);
				}
			} else throw new IllegalOperationError("The child must be a ZedSprite.");
			return obj;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of overridings
	}
}