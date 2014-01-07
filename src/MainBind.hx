package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;

		//  time to import my own Value class 
		//import MyValueObject;
		
import bindx.IBindable;
using bindx.Bind;

/**  
 * Simple demo project for using the bindx -lib with StablexUI  
 * **/ 
class MainBind extends Sprite {
			
	/* MEMBER FIELDS*/
	var inited:Bool = false;
	var myTextWidget_001:Text = null;
	
/* just for testing 
	var globalCall:Int = 0;
	var toStringCall:Int = 0;
	var aCall:Int = 0;
	var lastS:String = null;	
*/	
	
	
	public function new() {   	/* CONSTRUCTOR */
		trace("constructor of class 'MainBind' called...");
			super();
			addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStage);			
			init();  	//  additional init tasks... 			
			//createUI();	  		// and add it to display list on the stage...
			startTest();
	}		
		
	private function startTest():Void {
		//  start testing
		//trace_Counters("Right Before startTest");
	
		// instantiate a NEW VALUE OBJECT and a NEW TEXT WIDGET  !!
		this.myTextWidget_001 = createTextWidget(); // trace(" instantiated a NEW TEXT WIDGET !!");	
		this.addChild(myTextWidget_001);   			// or SAFE // this.addChild(this.myTextWidget_001);      
													// trace(" added WIDGET to the STAGE !!");
		
		var vo = new Value();			
									// trace(" instantiated a NEW VALUE OBJECT !!");	
		vo.a = 5;
		vo.def = 12;
		vo.s = "..dummy start text in vo.s";
		trace('$vo');		// here the .toString() method of the ValueObject gets called
 		
		
/********** BINDING TEST 1 ( THE COMFORTABLY - but not always helpful - VARIANT )  *****
 * 		
		var unbindTo = vo.s.bindxTo(myTextWidget_001.text);   
								// myTextWidget_001.text == "..dummy start text in vo.s"
		unbindTo();   
						// the comfortably variant (unfort. it removes binding imm. after first usage...)  
 * */

/********** BINDING TEST 2 (the MANUAL, but SAFE way) ********************/
		var listener0 = function(_, b) { myTextWidget_001.text = b; }
		
			vo.__fieldBindings__.add("s",listener0);
			//listener0(null, vo.s);   // gets called 1 time anyway (in the previous line)
		
		
		vo.s = "Hi, binding worked !!";
		
		var unbind_s = function () {
			vo.__fieldBindings__.remove("s",listener0);
			listener0 = null;
			};
			
		//unbind_s();

		vo.s = "how nice !!";
		
/*  like this a FUNCTION can be bound (and unbound) ...
 * 
 var unbind = function() {	vo.s.bindx(function (from:String, to:String) 
															{ 
															trace('vo.s changed from: $from to: $to'); 
															} 
											);
							}
		unbind();

 */		
		
/*	looking for ANY (=GLOBAL) CHANGES to MEMBERS VARS of VALUE objects !! 
 *  
 * vo.bindxGlobal(function (varName:String, old:Dynamic, val:Dynamic) {
			this.globalCall++;	
			});*/		

		//trace_Counters("After first v.def attachment");
		
		vo.def = 14;
		//this.widget.text = '$v';
		//trace_Counters("After 2nd  v.def attachment");
		
		// etc....
	}
	
	private function createTextWidget():Text {
		// create the Text widget programmatically and give it back to the caller
		return UIBuilder.create( Text, {
			id  : 'myWidget',
			left:  50,
			top : 100,
			text: 'some static dummy text ...'
			});	
	}
	
	private function init(): Void {
		if (this.inited) return;
		this.inited = true;
		
	/*  TODO (your additional code here)
	 * 
	 * 	Stage:
	 *  stage.stageWidth x stage.stageHeight @ stage.dpiScale
	 *  
	 *  Assets:
	 *  nme.Assets.getBitmapData("img/assetname.jpg");		
	 *  
	 *  prepare StablexUI i.e. register Main class so we can use it in xml (if needed..)
	 *  UIBuilder.regClass("MainBind");
	 * 
	 * */			
		UIBuilder.init('ui/defaults.xml');
		}
			
/*	function trace_Counters(mess:String):Void {
		trace("-----------------------------------");
		trace("Called from '"    + mess + "'...");
		trace("globalCall = "   + this.globalCall);		
		trace("toStringCall = " + this.toStringCall);		
		trace("aCall = "        + this.aCall);		
		trace("lastS = "        + this.lastS);
		trace("-----------------------------------");		
	}*/
	
	private function addedToStage(e) {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}	
	
	private function resize(e:Event):Void {}
	
    static public function main () : Void {
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new MainBind());
	}	
}		//end of class MainBind




/* VALUE CLASS */
@bindable class Value implements IBindable {
		
	public function new() {}

	public var def(default, default):Int;
					//@bindable public var never(default, never):Int;
					//@bindable public var no(default, null):Int;
					//@bindable public var dyn(default, dynamic):Int;
	
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
