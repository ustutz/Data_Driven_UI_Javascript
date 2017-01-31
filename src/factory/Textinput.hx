package factory;
import js.Browser;
import js.html.Element;
import js.html.InputElement;

/**
 * ...
 * @author Urs Stutz
 */
class Textinput {

	public static function create( value:String = "" ):InputElement {
		
		var input = Browser.document.createInputElement();
		input.type = "text";
		input.defaultValue = value;
		return input;
	}
	
}