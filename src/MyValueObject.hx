package ;

/*
 * import bindx.BindSignal.MethodsBindSignal;
 * import bindx.BindSignal.FieldsBindSignal;
 * */
import bindx.IBindable

using  bindx.Bind;

/**
 * ...
 * @author pm  (with a lot of help from 'deep')
 * 
 * 
 * TODO  there's still a problem with the 
 * 			using bindx.Bind  statement above, 
 * 			still need to check that out...
 * 
 */

@bindable class MyValueObject implements IBindable
{
	
	public function new() {}

	
	/* Binding Var 'a' to var 'def' */	
	@:isVar public var a(get_a, default):Int;
	
	function get_a():Int { return def; }
	

	// definition of Var def
	public var def(default, default):Int;
					//@bindable public var never(default, never):Int;
					//@bindable public var no(default, null):Int;
					//@bindable public var dyn(default, dynamic):Int;

	// definition of public String-Var s
	public var s:String;
	
	// a bindable function for reporting
	@bindable public function toString():String {
		var temp:String = '$a + $def + $s';
		trace("toString just returns: " + temp);
		return temp;
		// return '$a + $def + $s';
	}
	
	
	
	
		
	/* INTERFACE bindx.IBindable 
	
	function get___fieldBindings__():FieldsBindSignal {
		return ___fieldBindings__;
	}
	
	public var __fieldBindings__(get___fieldBindings__, null):FieldsBindSignal;
	
	function get___methodBindings__():MethodsBindSignal {
		return ___methodBindings__;
	}
	
	public var __methodBindings__(get___methodBindings__, null):MethodsBindSignal;
	
	*/	
}