package;

import contexts.CreateUI;
import contexts.Data2UIData;
import contexts.UI2Data;
import data.DataAllTypes;
import data.DataString;
import data.FieldData;
import data.Selection;
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
	
	static var data1:DataAllTypes;
	static var data2:DataString;
	
	static var usedData:Dynamic;
	static var fieldDatasets:Array<FieldData>;
	
	static function main() {
		
		data1 = new DataAllTypes( 	0, 
									true, 
									0.12, 
									4, 
									"Random Text", 
									Choices.Second, 
									new Selection( ["Same as Input Series", "1", "2"] ), 
									new Selection( ["Input Series"]
								));
								
		data2 = new DataString( 1, "Some Text", "More Text", "and another one" );
		
		usedData = data1;
		
		fieldDatasets = Data2UIData.createFieldDatasets( usedData );
		CreateUI.create( fieldDatasets );
		
		var okButton = Browser.document.getElementById( "ok" );
		okButton.addEventListener( "click", onClick );
	}
	
	static function onClick( e:Event ):Void { //trace( "click" );
		
		var retrievedData = UI2Data.retrieve( usedData.copy(), fieldDatasets );
		
		trace( usedData );
		trace( retrievedData );
	}
}