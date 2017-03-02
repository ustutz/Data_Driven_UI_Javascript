package data.fieldTypes;
import js.html.Element;
import js.html.InputElement;


class FloatField implements IDataField {

	var data:Dynamic;
	var field:String;
	var element:InputElement;
	
	public function new( data:Dynamic, field:String, element:InputElement ) {
		
		this.data = data;
		this.field = field;
		this.element = element;
	}
	
	public function data2UI():Void {
		element.value = Std.string( Reflect.getProperty( data, field ));
	}
	
	public function ui2Data():Void {
		
		var value = Std.parseFloat( element.value );
		if( value != Math.NaN ) {
			Reflect.setProperty( data, field, value );
		} else {
			trace( 'Error: parsing Float Value ${element.value}' );
		}
	}
}