package contexts;
import contexts.UI2Data;
import data.Data;
import data.FieldData;
import data.Selection;
import enums.TValueType;
import factory.Checkbox;
import factory.Select;
import factory.Textinput;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author Urs Stutz
 */
class Data2UI {

	public static function create<T>( data:T ):Array<FieldData> {
		
		var fieldDatasets:Array<FieldData> = [];
		
		var c = Type.getClass( data );
		var fields = Type.getInstanceFields( c );
		
		// sort fields
		
		for ( field in fields ) {
			
			var value:Dynamic = Reflect.getProperty( data, field );
			var labelElement = createLabelElement( field );
			
			switch( Type.typeof( value )) {
			
				case TClass( c ):
					if ( c == String ) {
						var inputElement = Textinput.create( value );
						fieldDatasets.push( new FieldData( field, TValueType.TString, value, labelElement, inputElement, UI2Data.retrieveString ));
					} else if ( c == Selection ) {
						var selectElement = value.options.length > 1 ? Select.create( value.options, value.defaultIndex ) : createText( value.options[0] );
						var retrieve = value.options.length > 1 ? UI2Data.retrieveSelect : UI2Data.retrieveZero;
						fieldDatasets.push( new FieldData( field, TValueType.TSelection, value, labelElement, selectElement, retrieve ));
					}
				case TEnum(_):
					var selectElement = Select.create( Type.getEnumConstructs( Type.getEnum( value )), Type.enumIndex( value ) );
					fieldDatasets.push( new FieldData( field, TValueType.TEnum, value, labelElement, selectElement, UI2Data.retrieveSelect ));
				case TFloat:
					var inputElement = Textinput.create( Std.string( value ));
					fieldDatasets.push( new FieldData( field, TValueType.TFloat, value, labelElement, inputElement, UI2Data.retrieveFloat ));
				case TInt:
					var inputElement = Textinput.create( Std.string( value ));
					fieldDatasets.push( new FieldData( field, TValueType.TInt, value, labelElement, inputElement, UI2Data.retrieveInt ));
				case TBool:
					var inputElement = Checkbox.create( value );
					fieldDatasets.push( new FieldData( field, TValueType.TBool, value, labelElement, inputElement, UI2Data.retrieveBool ));
				case _:
			}
		}
		
		return fieldDatasets;
		
	}
	
	static function createText( text:String ):Element {
		var span = Browser.document.createSpanElement();
		span.innerHTML = text;
		return span;
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