package contexts;
import contexts.UI2Data;
import data.Data;
import data.FieldData;
import data.Selection;
import enums.TValueType;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.SelectElement;

class Data2UIData {

	public static function createFieldDatasets<T>( data:T ):Array<FieldData> {
		
		var fieldDatasets:Array<FieldData> = [];
		
		var c = Type.getClass( data );
		var fields = Type.getInstanceFields( c );
		
		for ( field in fields ) {
			
			var value:Dynamic = Reflect.getProperty( data, field );
			var labelElement = createLabelElement( field );
			
			switch( Type.typeof( value )) {
			
				case TClass( c ):
					if ( c == String ) {
						
						var inputElement = createTextinput( value );
						fieldDatasets.push( new FieldData( field, TValueType.TString, value, labelElement, inputElement, UI2Data.retrieveString ));
					
					} else if ( c == Selection ) {
						
						if ( value.options.length > 1 ) {
							var selectElement = createSelect( value.options, value.defaultIndex );
							fieldDatasets.push( new FieldData( field, TValueType.TSelection, value, labelElement, selectElement, UI2Data.retrieveSelect ));
						} else {
							var selectElement = createText( value.options[0] );
							fieldDatasets.push( new FieldData( field, TValueType.TSelection, value, labelElement, selectElement, UI2Data.retrieveZero ));
						}
					}
				
				case TEnum(_):
					var selectElement = createSelect( Type.getEnumConstructs( Type.getEnum( value )), Type.enumIndex( value ) );
					fieldDatasets.push( new FieldData( field, TValueType.TEnum, value, labelElement, selectElement, UI2Data.retrieveSelect ));
				
				case TFloat:
					var inputElement = createTextinput( Std.string( value ));
					fieldDatasets.push( new FieldData( field, TValueType.TFloat, value, labelElement, inputElement, UI2Data.retrieveFloat ));
				
				case TInt:
					var inputElement = createTextinput( Std.string( value ));
					fieldDatasets.push( new FieldData( field, TValueType.TInt, value, labelElement, inputElement, UI2Data.retrieveInt ));
				
				case TBool:
					var inputElement = createCheckBox( value );
					fieldDatasets.push( new FieldData( field, TValueType.TBool, value, labelElement, inputElement, UI2Data.retrieveBool ));
				
				case _:
			}
		}
		
		return fieldDatasets;
		
	}
	
	static function createCheckBox( value:Bool ):InputElement {
		
		var checkbox = Browser.document.createInputElement();
		checkbox.type = "checkbox";
		checkbox.checked = value;
		
		return checkbox;
	}
	
	public static function createSelect( options:Array<String>, defaultIndex:Int = 0 ):SelectElement {
		
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
	
	static function createText( text:String ):Element {
		var span = Browser.document.createSpanElement();
		span.innerHTML = text;
		return span;
	}
	
	public static function createTextinput( value:String = "" ):InputElement {
		
		var input = Browser.document.createInputElement();
		input.type = "text";
		input.defaultValue = value;
		return input;
	}
	
	static function createLabelElement( text:String ):Element {
		
		var labelElement = Browser.document.createLabelElement();
		labelElement.innerHTML = upperFirst( splitAtUppercaseLetters( filterIs( text )));
		return labelElement;
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
}