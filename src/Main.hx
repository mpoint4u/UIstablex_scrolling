package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Widget;

//  time to import my own classes 
import MyValueObject;
import TextBindable;
		
import bindx.IBindable;
using bindx.Bind;

/**  
 * Simple demo project for using the bindx -lib with StablexUI  
 * **/

class Main extends Sprite {
			
	/* MEMBER FIELDS*/
	var inited:Bool = false;
	var myTextWidget_001:TextBindable = null;
	var myProgButton_001:Button = null;
	
/*  vars just for testing ..........
	var globalCall:Int = 0;
	var toStringCall:Int = 0;
	var aCall:Int = 0;
	var lastS:String = null;	
*/	
	
	
	public function new() {   	/* CONSTRUCTOR */
		trace("constructor of class 'Main' called...");
			super();
			addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStage);			
			//init();  	//  here init()  is already called from inside the 'addedToStage()' method... 			
			constructUI();
	}		
		
	private function constructUI():Void {
		//  start testing
		//trace_Counters("Right Before startTest");
	
		// instantiate a NEW TEXT WIDGET  !!
		this.myTextWidget_001 = createTextWidget();   // 
		this.myTextWidget_001.text = "text was overwritten in code...";
		//Lib.current.stage.addChild();
		
		// instantiate a NEW SIMPLE BUTTON  !!
		this.myProgButton_001 = createButton();
		//this.myProgButton_001.onPress(
		
		
		//instantiate a NEW VALUE OBJECT 
		var vo = new Value();			
	
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

/********** BINDING TEST 2 (the MANUAL, but SAFE way) ******************
		var listener0 = function(_, b) { myTextWidget_001.text = b; }
		
		vo.__fieldBindings__.add("s",listener0);
		listener0(null, vo.s);   // gets called 1 time anyway (in the previous line)
	**/	

		// Bind.bindx( vo.s, function(_, s) myTextWidget_001.text = s );
		Bind.bindxTo( vo.s , myTextWidget_001.text );
	
		// all this changes of the vo field should be reflected in the widget textfield
		// i.e. only the LAST CHANGE will be visible...
		vo.s = "how nice !!";
		//vo.s = "Hi, binding works !!";
		vo.s = "time for some serious fun!";

/****** CREATE the BASE UI  */		
		var myCustomUI = UIBuilder.create(CustomUI);
		//trace(Type.typeof(myCustomUI));
		//trace(Type.typeof(myCustomUI.box));
		
		// put the TextWidget and the Button to the custom UI
		myCustomUI.holder.addChildAt(myTextWidget_001, 0);
		myCustomUI.holder.addChildAt(myProgButton_001, 2);		
		
		
		// make some changes to the UI if needed...
		// myCustomUI.btn.label.text = "Press me";
		
		
		
		
		
		//trace(Type.typeof(myCustomUI.btn));
		//trace(myCustomUI.btn.label.text);	
		
		
		 
/*******	ADDING WIDGET TO STAGE		*/	 
/*		Lib.current.addChild( 
		
			UIBuilder.buildFn('ui/index.xml')()
			//UIBuilder.buildFn('ui/index2bind.xml')() 
		
							);*/
							
		this.addChild(myCustomUI);
		// or SAFE // this.addChild(this.myTextWidget_001);      
				 
		 
		trace(" added WIDGET to the STAGE !!");
	}
	
	private function createTextWidget():TextBindable {
		
		trace(" created a TextBindable widget programmatically and giving it back to the calling function .. ");
		
		return UIBuilder.create( TextBindable, {
			id  : 'myTextBindable',
			left:  50,
			top : 100,
			text: 'myTextBindable just instantiated...'
			
			});	
	}

	private function createButton():Button {
		// create the Text widget programmatically and give it back to the caller
		return UIBuilder.create( Button, {
			id  	: 'myProgButton',
			name	: 'btn2',
/*			skin:Paint-border = '2',  
			skin:Paint-color  = '0xC835EC',*/
			height	:15,
			widthPt	:90,					
			text	:'2nd Btn..'
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
	 *  prepare StablexUI i.e. register various classes so we can use it in xml (if needed..)
	 * 
	 *  we can even BUILD CUSTOM CLASSES here, but this has still to be explored...
	 *  (details can be found in this post by Alex Kuzmenko.. 
	 *    		https://github.com/RealyUniqueName/StablexUI/issues/91
	 * )
	 *  UIBuilder.buildClass("ui/custom_UI.xml", "CustomUI");
	 * 
	 * */					
		UIBuilder.regClass('TextBindable');	
		//UIBuilder.init('ui/android/defaults.xml');
		UIBuilder.init('ui/defaults.xml');
		}
	
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
		// Lib.current.addChild(new Main());
		Lib.current.stage.addChild(new Main());
	
/*	function trace_Counters(mess:String):Void {
		trace("-----------------------------------");
		trace("Called from '"    + mess + "'...");
		trace("globalCall = "   + this.globalCall);		
		trace("toStringCall = " + this.toStringCall);		
		trace("aCall = "        + this.aCall);		
		trace("lastS = "        + this.lastS);
		trace("-----------------------------------");
		}    */
	}	
	
}		//end of class Main

/* VALUE CLASS 
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
*/