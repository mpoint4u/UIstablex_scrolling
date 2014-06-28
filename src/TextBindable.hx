package ;

/* import bindx.BindSignal.MethodsBindSignal;
 * import bindx.BindSignal.FieldsBindSignal;
 * */

import ru.stablex.ui.widgets.Text;
import bindx.IBindable;

using bindx.Bind;

/**
 * ...
 * @author pm
 */

 
@bindable class TextBindable extends Text implements IBindable
{

	public function new() 
	{
		super();
		// here goes code that makes this class behave different than it parent class
	}
	
	
	@bindable override public function toString():String {
		
		var tempStr:String = this.label.text;
		trace("TextBindable.toString just returns: " + tempStr);
		return this.label.text;
		}
	
	
	
	
	/* INTERFACE bindx.IBindable 
	
	function get___fieldBindings__():FieldsBindSignal 
	{
		return ___fieldBindings__;
	}
	
	public var __fieldBindings__(get___fieldBindings__, null):FieldsBindSignal;
	
	private function set___fieldBindings__(value:Void):Void 
	{
		return ___fieldBindings__ = value;
	}
	
	public var __fieldBindings__(null, set___fieldBindings__):Void;
	
	function get___methodBindings__():MethodsBindSignal 
	{
		return ___methodBindings__;
	}
	
	public var __methodBindings__(get___methodBindings__, null):MethodsBindSignal;
	
	private function set___methodBindings__(value:Void):Void 
	{
		return ___methodBindings__ = value;
	}
	
	public var __methodBindings__(null, set___methodBindings__):Void;
	*/
}