package contexts;
import js.html.InputElement;

/**
 * ...
 * @author Urs Stutz
 */
class UI2Data {

	public static function retrieveBool( inputElement:InputElement ):Bool {
		return inputElement.checked;
	}
	public static function retrieveFloat( inputElement:InputElement ):Float {
		return Std.parseFloat( inputElement.value );
	}
	public static function retrieveInt( inputElement:InputElement ):Int {
		return Std.parseInt( inputElement.value );
	}
	public static function retrieveString( inputElement:InputElement ):String {
		return inputElement.value;
	}
	
}