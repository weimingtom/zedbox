package idv.cjcat.zedbox {
	use namespace zb;
	
	import flash.display.*;
	
	internal class BillboardData {
		
		zb var billboard:Sprite;
		zb var x:Number;
		zb var y:Number;
		zb var z:Number;
		
		
		public function BillboardData(billboard:Sprite, x:Number, y:Number, z:Number) {
			this.billboard = billboard;
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}