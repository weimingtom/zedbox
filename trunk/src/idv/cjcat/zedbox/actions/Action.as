package idv.cjcat.zedbox.actions {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import idv.cjcat.zedbox.display.ZedSprite;
	import idv.cjcat.zedbox.events.ActionEvent;
	import idv.cjcat.zedbox.geom.ZedData;
	
	[Event(name = "zedBoxActoinPriorityChange" , type = "idv.cjcat.zedbox.events.ActionEvent")]
	
	public class Action extends EventDispatcher {
		
		/**
		 * Denotes if the action is active, true by default.
		 */
		public var active:Boolean;
		
		/**
		 * Reset to false on each render loop. 
		 * If set to true in a <code>update()</code> method call, 
		 * this action is skipped in the render loop.
		 */
		public var skipThisAction:Boolean;
		
		private var _mask:int;
		private var _priority:int;
		
		/** @private */
		protected var _supports2D:Boolean;
		/** @private */
		protected var _supports3D:Boolean;
		
		public function Action() {
			priority = ActionPriority.getInstance().getPriority(Object(this).constructor as Class);
			active = true;
		}
		
		public final function doUpdate(data:ZedData):void {
			if (!active) {
				skipThisAction = true;
				return;
			}
			update(data);
		}
		
		/**
		 * [Template Method] This method is called once upon each render loop, 
		 * before the <code>update()</code> calls with each <code>ZedSprite</code> in the scene.
		 * 
		 * <p>
		 * All setup operatoins before the <code>update()</code> calls should be done here.
		 * </p>
		 */
		public function preUpdate():void {
			//template method
		}
		
		/**
		 * [Template Method] Override this method to create custom actions.
		 * @param	data	The associated <code>ZedData</code>.
		 */
		public function update(data:ZedData):void {
			//template method
		}
		
		/**
		 * [Template Method] This method is called once each render loop finishes. 
		 */
		public function postUpdate():void {
			//template method
		}
		
		/**
		 * [Template Method]
		 * @param	data
		 */
		public function restore(data:ZedData):void {
			//template method
		}
		
		/**
		 * Actions will be sorted according to their priorities.
		 */
		public function get priority():int { return _priority; }
		public function set priority(value:int):void {
			_priority = value;
			dispatchEvent(new ActionEvent(ActionEvent.PRIORITY_CHANGE, this));
		}
	}
}