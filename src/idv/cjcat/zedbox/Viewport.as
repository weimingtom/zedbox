package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.accessibility.Accessibility;
	import flash.display.*;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import idv.cjcat.zedbox.geom.*;
	
	/**
	 * The <code>ZContainer</code> class is a 2.5D engine,
	 * which does not make use of the build-in 3D engine in Flash Player 10.
	 * 
	 * <p>
	 * The <code>ZContainer</code> class supports both orthogonal projection and perspective projection.
	 * </p>
	 */
	public class Viewport extends Sprite {
		
		public var topZSprite:ZSprite;
		
		private var _camera:Camera;
		private var _bbdVec:Vector.<BillboardData> = new Vector.<BillboardData>();
		
		public function Viewport(topZSprite:ZSprite, camera:Camera = null) {
			this.topZSprite = topZSprite;
			
			if (camera == null) _camera = new Camera();
			else _camera = camera.clone();
		}
		
		public function get camera():Camera { return _camera; }
		
		public function render(e:Event = null):void {
			if (topZSprite == null) {
				while (numChildren > 0) removeChildAt(0);
				return;
			}
			
			_bbdVec.length = 0;
			traverseZSprites(topZSprite, topZSprite.position);
			_bbdVec.sort(zSort);
			
			
		}
		
		private var zs:ZSprite;
		private var vec3:Vec3 = new Vec3();
		private function traverseZSprites(zSprite:ZSprite, v:Vec3):void {
			for each (zs in zSprite._zsVec) {
				vec3 = v.add(zs.position);
				_bbdVec.push(new BillboardData(zs._billboard, vec3.x, vec3.y, vec3.z));
				traverseZSprites(zs, vec3);
			}
		}
		
		private function zSort(bd1:BillboardData, bd2:BillboardData):Number {
			if (bd1.z > bd2.z) return -1;
			else return 1;
		}
		
		/**
		 * Repeatedly call this method to render the <code>ZContainer</code>.
		 * <p>This method can be used as an event listener.</p>
		 */
		/*public var render:Function;
		private var dz:Number, d:Number, zs:ZSprite;
		private function renderPerspective(e:Event = null):void {
			//z-sorting
			zsVec.sort(zSorter);
			
			//perspective projection
			for each (zs in zsVec) {
				_sprite.addChild(zs);
				
				dz = zs.z - cameraZ;
				if (dz < 0) {
					zs._outOfRange = true;
					zs._visibleBeforeOutOfRange = zs.visible;
					zs.visible = false;
					continue;
				} else {
					if (zs._outOfRange) {
						zs._outOfRange = false;
						zs.visible = zs._visibleBeforeOutOfRange;
					}
				}
				
				d = dz / focalLength;
				zs.superX = (zs.x - cameraX) / (d + 1);
				zs.superY = (zs.y - cameraY) / (d + 1);
				
				zs.scaleX = zs.scaleY = 1 / (d + 1);
			}
		}
		private function renderOrthographic(e:Event = null):void {
			//z-sorting
			zsVec.sort(zSorter);
			
			//orthographic projection
			for each ( zs in zsVec) {
				_sprite.addChild(zs);
				zs.superX = zs.x - cameraX;
				zs.superY = zs.y - cameraY;
			}
		}*/
	}
}
	