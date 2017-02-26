package factory;
import js.Browser;
import js.html.SelectElement;

class Select {

	public static function create( options:Array<String>, defaultIndex:Int = 0 ):SelectElement {
		
		var select = Browser.document.createSelectElement();
		
		for ( i in 0...options.length ) {
			var option = Browser.document.createOptionElement();
			option.value = Std.string( i );
			option.innerHTML = options[i];
			if ( i == defaultIndex ) {
				option.selected = true;
			}
			select.appendChild( option );
		}
		
		return select;
	}
	
}