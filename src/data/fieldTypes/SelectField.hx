package data.fieldTypes;
import data.Selection;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.SelectElement;


class SelectField implements IDataField {

	var data:Dynamic;
	var field:String;
	var element:SelectElement;
	var selection:Selection;
	
	public function new( data:Dynamic, field:String, element:SelectElement ) {
		
		this.data = data;
		this.field = field;
		this.element = element;
	}
	
	public function data2UI():Void {
		
		selection = Reflect.getProperty( data, field );
		
		while ( element.hasChildNodes() ) {
			element.removeChild( element.lastElementChild );
		}
		
		for ( i in 0...selection.options.length ) {
			var option = Browser.document.createOptionElement();
			option.value = Std.string( i );
			option.innerHTML = selection.options[i];
			element.appendChild( option );
		}
		
		element.selectedIndex = selection.index;
		
		if ( selection.options.length == 1 ) {
			element.disabled = true;
		} else {
			element.disabled = false;
		}
	}
	
	public function ui2Data():Void {
		selection.index = element.selectedIndex;
		Reflect.setProperty( data, field, selection );
	}
}