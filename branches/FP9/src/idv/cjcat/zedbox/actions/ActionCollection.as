package idv.cjcat.zedbox.actions {
	import flash.events.Event;
	import idv.cjcat.zedbox.events.ActionEvent;
	import idv.cjcat.zedbox.zb;
	
	use namespace zb;
	
	/**
	 * This class is used internally by classes that implements the <code>ActionCollector</code> interface.
	 */
	public class ActionCollection implements IActionCollector {
		
		/** @private */
		zb var actions:Array;
		
		public function ActionCollection() {
			actions = [];
		}
		
		public final function addAction(action:Action):void {
			actions.push(action);
			action.addEventListener(ActionEvent.PRIORITY_CHANGE, sortActions);
			sortActions();
		}
		
		public final function removeAction(action:Action):void {
			var index:int;
			while ((index = actions.indexOf(action)) >= 0) {
				var action:Action = actions.splice(index, 1)[0] as Action;
				action.removeEventListener(ActionEvent.PRIORITY_CHANGE, sortActions);
			}
		}
		
		public final function clearActions():void {
			for each (var action:Action in actions) removeAction(action);
		}
		
		public final function sortActions(e:Event = null):void {
			actions.sortOn("priority", Array.NUMERIC | Array.DESCENDING);
		}
	}
}