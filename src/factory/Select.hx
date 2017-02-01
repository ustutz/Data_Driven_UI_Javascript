package factory;
import js.Browser;
import js.html.SelectElement;

/**
 * ...
 * @author Urs Stutz
 */
class Select {

	public static function create( index:Int, options:Array<String> ):SelectElement {
		
		var select = Browser.document.createSelectElement();
		
		for ( i in 0...options.length ) {
			var option = Browser.document.createOptionElement();
			option.value = Std.string( i );
			option.innerHTML = options[i];
			if ( i == index ) {
				option.selected = true;
			}
			select.appendChild( option );
		}
		
		return select;
	}
	
}