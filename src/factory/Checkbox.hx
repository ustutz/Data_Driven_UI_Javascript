package factory;
import js.Browser;
import js.html.Element;
import js.html.InputElement;

class Checkbox {

	public static function create( value:Bool ):InputElement {
		
		var checkbox = Browser.document.createInputElement();
		checkbox.type = "checkbox";
		checkbox.checked = value;
		
		return checkbox;
	}
	
}