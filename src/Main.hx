package;

import data.DataAllTypes;
import data.NestedData;
import data.Selection;
import data.UIData;
import data.fieldTypes.IDataField;
import enums.TValueType;
import haxe.Json;
import js.Browser;
import js.Lib;
import js.html.Document;
import js.html.Element;
import js.html.Event;
import js.html.HTMLDocument;
import js.html.InputElement;

/**
 * ...
 * @author Urs Stutz
 */
class Main {
	
	static var testData:DataAllTypes;
	
	static private var uiData:UIData;
	
	static function main() {
		
		testData = new DataAllTypes( 	0, 
									true, 
									0.12, 
									4, 
									"Random Text", 
									Choices.Second, 
									new Selection( ["Same as Input Series", "1", "2"] ), 
									new Selection( ["Input Series"] ),
									new NestedData( false, 5 )
								);
								
		uiData = new UIData( testData );
		uiData.init();
		
		var table = Browser.document.getElementById( "table" );
		for ( row in uiData.rows ) {
			table.appendChild( row );
		}
		
		var okButton = Browser.document.getElementById( "ok" );
		if( okButton != null ) {
			okButton.addEventListener( "click", onClick );
		}
	}
	
	static function onClick( e:Event ):Void { //trace( "click" );
		
		uiData.ui2Data();
		
		trace( testData );
	}
}