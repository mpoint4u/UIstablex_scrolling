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
		// UIBuilder.regClass("CustomWidget");
		
		// build XML-based class
		UIBuilder.buildClass("ui/custom_UI.xml", "CustomUI");		
		//UIBuilder.buildClass("ui/index_android.xml", "CustomUI");
		
	}
	
}
