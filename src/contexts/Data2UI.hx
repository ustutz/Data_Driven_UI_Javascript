package contexts;
import contexts.UI2Data;
import data.Data;
import data.FieldData;
import enums.TValueType;
import factory.Checkbox;
import factory.Textinput;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author Urs Stutz
 */
class Data2UI {

	public static function create( data:Dynamic ):Array<FieldData> {
		
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
					}
				case TEnum(_):
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
	
	static function createLabelElement( text:String ):Element {
		
		var formatLabel = Ramda.compose3( upperFirst, splitAtUppercaseLetters, filterIs );
		
		var labelElement = Browser.document.createLabelElement();
		labelElement.innerHTML = formatLabel( text );
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