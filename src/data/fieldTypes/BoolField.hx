package data.fieldTypes;
import js.html.Element;
import js.html.InputElement;


class BoolField implements IDataField {

	var data:Dynamic;
	var field:String;
	var element:InputElement;
	
	public function new( data:Dynamic, field:String, element:InputElement ) {
		
		this.data = data;
		this.field = field;
		this.element = element;
	}
	
	public function data2UI():Void {
		element.checked = Reflect.getProperty( data, field );
	}
	
	public function ui2Data():Void {
		Reflect.setProperty( data, field, element.checked );
	}
}