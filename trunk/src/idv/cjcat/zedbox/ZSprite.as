package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.display.*;
	import idv.cjcat.zedbox.geom.Vec3;
	
	public class ZSprite {
		
		/** @private */
		zb var _position:Vec3 = new Vec3();
		/** @private */
		zb var _zsVec:Vector.<ZSprite> = new Vector.<ZSprite>();
		/** @private */
		zb var _billboard:Sprite = new Sprite();
		
		public function ZedSprite() {
		}
		
		public function addChild(zs:ZSprite):void {
			removeChild(zs);
			_zsVec.push(zs);
		}
		
		public function removeChild(zs:ZSprite):ZSprite {
			var index:int = _zsVec.indexOf(zs);
			if (index >= 0) return _zsVec.splice(index, 1)[0];
			return null;
		}
		
		public function clearChildren():Vector.<ZSprite> {
			var temp:Vector.<ZSprite> = _zsVec;
			_zsVec = new Vector.<ZSprite>();
			return temp;
		}
		
		public function get position():Vec3 { return _position; }
	}
}