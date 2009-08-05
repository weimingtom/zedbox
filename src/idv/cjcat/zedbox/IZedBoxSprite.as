package idv.cjcat.zedbox {
	import flash.display.DisplayObject;
	
	/**
	 * Marker interface for <code>ZedScenes</code> and <code>ZedSprites</code>.
	 */
	public interface IZedBoxSprite {
		function addChild(obj:DisplayObject):DisplayObject;
		function removeChild(obj:DisplayObject):DisplayObject;
	}
}