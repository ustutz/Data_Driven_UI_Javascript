package data.fieldTypes;
import js.html.Element;
import js.html.InputElement;


class StringField implements IDataField {

	var data:Dynamic;
	var field:String;
	var element:InputElement;
	
	public function new( data:Dynamic, field:String, element:InputElement ) {
		
		this.data = data;
		this.field = field;
		this.element = element;
	}
	
	public function data2UI():Void {
		element.value = Reflect.getProperty( data, field );
	}
	
	public function ui2Data():Void {
		Reflect.setProperty( data, field, element.value );
	}
}