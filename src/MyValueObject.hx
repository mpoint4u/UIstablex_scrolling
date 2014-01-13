package ;

import bindx.IBindable;

using bindx.Bind;

/**
 * ...
 * @author pm  (with a lot of help from 'deep') 
 */

 @bindable class Value implements IBindable {
		
	public function new() {}

	public var def(default, default):Int;
	
	public var s:String;
	

	// Binding Var 'a' to var 'def' 	
	@:isVar 
	public var a(get_a, default):Int;
	
	function get_a():Int { return def; }


	@bindable public function toString():String {
		var temp:String = '$a + $def + $s';
		trace("toString just returns: " + temp);
		return temp;
		// return '$a + $def + $s';
	}	
}
