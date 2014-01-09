package ;

import ru.stablex.ui.UIBuilder;

/**
 * ...
 * @author pm
 */
class Init
{

	macro static public function init():Void {
		
		// register class(es) for usage in XML
		UIBuilder.regClass("");
		
		// build XML-based class
		UIBuilder.buildClass("ui/index2bind.xml", CustomWidget);
		
	}
	
}