package contexts;
import data.FieldData;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author Urs Stutz
 */
class CreateUI {

	public static function create( fieldDatasets:Array<FieldData> ):Void {
		
		var table = Browser.document.getElementById( "table" );
		for ( fieldData in fieldDatasets ) {
			
			var row = createRow( fieldData.labelElement, fieldData.inputElement );
			table.appendChild( row );
			
		}
	}
	
	static function createRow( element1:Element, element2:Element ):Element {
		
		var doc = Browser.document;
		
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
	
}