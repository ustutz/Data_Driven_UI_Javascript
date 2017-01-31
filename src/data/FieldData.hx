package data;
import enums.TValueType;
import js.html.Element;
import js.html.InputElement;

/**
 * ...
 * @author Urs Stutz
 */
class FieldData {
	
	public var name:String;
	public var type:TValueType;
	public var value:Dynamic;
	public var labelElement:Element;
	public var inputElement:InputElement;
	public var retrieve:InputElement->Dynamic;

	public function new( name:String, type:TValueType, value:Dynamic, labelElement:Element, inputElement:InputElement, retrieve:InputElement->Dynamic ) {
		this.name = name;
		this.type = type;
		this.value = value;
		this.labelElement = labelElement;
		this.inputElement = inputElement;
		this.retrieve = retrieve;
	}
	
}