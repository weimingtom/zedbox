package idv.cjcat.zedbox.actions {
	
	public interface IActionCollector {
		
		function addAction(action:Action):void;
		function removeAction(action:Action):void;
		function clearActions():void;
	}
	
}