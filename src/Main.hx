package;

import contexts.Data2UI;
import contexts.UI2Data;
import data.DataAllTypes;
import data.DataString;
import data.FieldData;
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
	
	static var doc:HTMLDocument;
	static var data1:DataAllTypes;
	static var data2:DataString;
	
	static var usedData:Dynamic;
	static var fieldDatasets:Array<FieldData>;
	
	static function main() {
		
		doc = Browser.document;
		
		data1 = new DataAllTypes( 0, true, 0.12, 4, "Random Text", Choices.Second, ["Same as Input Series", 1, 2] );
		data2 = new DataString( 1, "Some Text", "More Text", "and another one" );
		
		usedData = data1;
		
		fieldDatasets = Data2UI.create( usedData );
		
		var table = doc.getElementById( "table" );
		for ( fieldData in fieldDatasets ) {
			
			var row = createRow( fieldData.labelElement, fieldData.inputElement );
			table.appendChild( row );
			
		}
		
		var okButton = doc.getElementById( "ok" );
		okButton.addEventListener( "click", onClick );
	}
	
	static function createRow( element1:Element, element2:Element ):Element {
		
		var row = doc.createDivElement();
		row.classList.add( "row" );
		
		var cell1 = doc.createDivElement();
		cell1.classList.add( "cell" );
		
		var cell2 = doc.createDivElement();
		cell2.classList.add( "cell" );
		
		row.appendChild( cell1 );
		row.appendChild( cell2 );
		cell1.appendChild( element1 );
		cell2.appendChild( element2 );
		
		return row;
	}
	
	static function onClick( e:Event ):Void { //trace( "click" );
		
		var retrievedData = UI2Data.retrieve( usedData.copy(), fieldDatasets );
		
		trace( usedData );
		trace( retrievedData );
	}
}