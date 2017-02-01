package contexts;
import data.Data;
import data.FieldData;
import data.Selection;
import enums.TValueType;
import js.html.InputElement;
import js.html.SelectElement;

/**
 * ...
 * @author Urs Stutz
 */
class UI2Data {

	public static function retrieve( dataContainer:Data, fieldDatasets:Array<FieldData> ):Data {
		
		for ( fieldData in fieldDatasets ) {
			var value = fieldData.retrieve( cast( fieldData.inputElement ));
			if ( value != null ) {
				switch fieldData.type {
					case TValueType.TEnum:
						var enumType = Type.getEnum( fieldData.value );
						var constructs = Type.getEnumConstructs( enumType );
						var enumString = constructs[value];
						var enumValue = Type.createEnum( enumType, enumString );
						Reflect.setProperty( dataContainer, fieldData.name, enumValue );
					case TValueType.TSelection:
						var selection = new Selection( fieldData.value.options, value );
						Reflect.setProperty( dataContainer, fieldData.name, selection );
					case _:
						Reflect.setProperty( dataContainer, fieldData.name, value );
				}
			} else {
				trace( 'Error retrieving value for ${fieldData.name}' );
			}
		}
		return dataContainer;
	}
	
	public static function retrieveArray( selectElement:SelectElement ):Int {
		return selectElement.selectedIndex;
	}
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
	public static function retrieveSelect( selectElement:SelectElement ):Int {
		return selectElement.selectedIndex;
	}
	public static function retrieveZero( selectElement:SelectElement ):Int {
		return 0;
	}
	
}