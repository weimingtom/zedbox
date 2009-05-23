package idv.cjcat.zedbox.filters {
	use namespace zb;
	
	import idv.cjcat.zedbox.*;
	
	public interface IZFilter {
		
		function process(data:ZedData):void;
	}
}