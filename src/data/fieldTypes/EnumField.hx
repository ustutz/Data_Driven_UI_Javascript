package data.fieldTypes;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.SelectElement;


class EnumField implements IDataField {

	var data:Dynamic;
	var field:String;
	var element:SelectElement;
	var value:Dynamic;
	
	public function new( data:Dynamic, field:String, element:SelectElement ) {
		
		this.data = data;
		this.field = field;
		this.element = element;
	}
	
	public function data2UI():Void {
		
		value = Reflect.getProperty( data, field );
		
		while ( element.hasChildNodes() ) {
			element.removeChild( element.lastElementChild );
		}
		
		var options = Type.getEnumConstructs( Type.getEnum( value ));
		
		for ( i in 0...options.length ) {
			var option = options[i];
			var optionElement = Browser.document.createOptionElement();
			optionElement.value = Std.string( i );
			optionElement.innerHTML = option;
			element.appendChild( optionElement );
		}
		
		element.selectedIndex = Type.enumIndex( value );
		
		if ( options.length == 1 ) {
			element.disabled = true;
		} else {
			element.disabled = false;
		}
	}
	
	public function ui2Data():Void {
		
		var index = element.selectedIndex;
		var enumType = Type.getEnum( value );
		var constructs = Type.getEnumConstructs( enumType );
		var enumString = constructs[index];
		var enumValue = Type.createEnum( enumType, enumString );
		Reflect.setProperty( data, field, enumValue );
	}
}