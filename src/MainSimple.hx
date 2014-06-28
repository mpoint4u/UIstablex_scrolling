package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Floating;


/**
* Simple demo project for StablexUI
*/
class Main extends ru.stablex.ui.widgets.Widget {

	//private var floatFrame: Floating;
	
	
    /**
    * Enrty point
    *
    */
    static public function main () : Void{

        Lib.current.stage.align     = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        //register Main so we can use it in xml.
        UIBuilder.regClass("Main");

        //initialize StablexUI
        UIBuilder.init();

        //Create our UI     // conventionally  like   Lib.current.addChild( 
							// or like this...
		//UIBuilder.buildFn('/Users/marcus/Dropbox/DEV/haXe3/pm_haxe3_projects/UIstablex_scrolling/ui/index_android.xml')().show();	
		
		
		Lib.current.addChild( 
		
			UIBuilder.buildFn('/Users/marcus/Dropbox/DEV/haXe3/pm_haxe3_projects/UIstablex_scrolling/ui/index2bind.xml')() 
		
							);
		
		//);
    }//function main()


}//class Main
