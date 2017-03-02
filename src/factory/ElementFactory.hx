package factory;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.SelectElement;


class ElementFactory {

	public static function createCheckBox():InputElement {
		
		var checkbox = Browser.document.createInputElement();
		checkbox.type = "checkbox";
		
		return checkbox;
	}
	
	public static function createSelect():SelectElement {
		
		var select = Browser.document.createSelectElement();
		return select;
	}
	
	public static function createText( text:String ):Element {
		
		var span = Browser.document.createSpanElement();
		span.innerHTML = text;
		return span;
	}
	
	public static function createTextinput():InputElement {
		
		var input = Browser.document.createInputElement();
		input.type = "text";
		return input;
	}
	
	public static function createLabelElement( text:String ):Element {
		
		var label = Browser.document.createLabelElement();
		label.innerHTML = upperFirst( splitAtUppercaseLetters( filterIs( text )));
		return label;
	}
	
	static function filterIs( s:String ):String {
		
		if ( ~/^is/.match( s )) {
			return s.substr( 2 );
		}
		return s;
	}
	
	static function splitAtUppercaseLetters( s:String ):String {
		
		var ereg:EReg = ~/([A-Z][a-z0-9]+)/;
		var v = "";
		if( ereg.match( s )) {
			v = ereg.matchedLeft();
		}
		while ( ereg.match( s )) {
			v += " " + ereg.matched( 1 );
			s = ereg.matchedRight();
		}

		if( v == "" ) {
			return s;
		} else {
			return StringTools.trim( v );
		}
	}
	
	static function upperFirst( s:String ):String {
		return s.charAt( 0 ).toUpperCase() + s.substr( 1 );
	}
	
	public static function createRow( element1:Element, element2:Element ):Element {
		
		var doc = Browser.document;
		
		var row = doc.createDivElement();
		row.classList.add( "row" );
		
		var cell1 = doc.createDivElement();
		cell1.classList.add( "cell" );
		
		var cell2 = doc.createDivElement();
		cell2.classList.add( "cell" );
		
		row.appendChild( cell1 );
		row.appendChild( cell2 );
		cell1.appendChild( element1 );
		cell2.appendChild( element2 );
		
		return row;
	}
	
}