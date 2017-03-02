package data;
import data.fieldTypes.BoolField;
import data.fieldTypes.EnumField;
import data.fieldTypes.FloatField;
import data.fieldTypes.IDataField;
import data.fieldTypes.IntField;
import data.fieldTypes.SelectField;
import data.fieldTypes.StringField;
import factory.ElementFactory;
import js.html.Element;


class UIData {

	var mainData:Dynamic;
	public var rows:Array<Element> = [];
	var dataFields:Array<IDataField> = [];
	
	public function new( mainData:Dynamic ) {
		this.mainData = mainData;
	}
	
	public function init():Void {
		
		initData( mainData );
	}
	
	function initData( data:Dynamic ) {
	
		var c = Type.getClass( data );
		var fields = Type.getInstanceFields( c );
		
		for ( field in fields ) {
			
			var value:Dynamic = Reflect.getProperty( data, field );
			var labelElement = ElementFactory.createLabelElement( field );
			
			switch( Type.typeof( value )) {
			
				case TClass( c ):
					if ( c == String ) {
						var inputElement = ElementFactory.createTextinput();
						dataFields.push( new StringField( data, field, inputElement ));
						rows.push( ElementFactory.createRow( labelElement, inputElement ));
					
					} else if ( c == Selection ) {
						var selectElement = ElementFactory.createSelect();
						dataFields.push( new SelectField( data, field, selectElement ));
						rows.push( ElementFactory.createRow( labelElement, selectElement ));
						
					} else if ( c == NestedData ) {
						initData( value );
					}
				
				case TEnum(_):
					var selectElement = ElementFactory.createSelect();
					dataFields.push( new EnumField( data, field, selectElement ));
					rows.push( ElementFactory.createRow( labelElement, selectElement ));
				
				case TFloat:
					var inputElement = ElementFactory.createTextinput();
					dataFields.push( new FloatField( data, field, inputElement ));
					rows.push( ElementFactory.createRow( labelElement, inputElement ));
				
				case TInt:
					var inputElement = ElementFactory.createTextinput();
					dataFields.push( new IntField( data, field, inputElement ));
					rows.push( ElementFactory.createRow( labelElement, inputElement ));
				
				case TBool:
					var inputElement = ElementFactory.createCheckBox();
					dataFields.push( new BoolField( data, field, inputElement ));
					rows.push( ElementFactory.createRow( labelElement, inputElement ));
				
				case _:
			}
		}
		data2UI();
	}
	
	public function data2UI():Void {
		for ( dataField in dataFields ) {
			dataField.data2UI();
		}
	}
	
	public function ui2Data():Void {
		for ( dataField in dataFields ) {
			dataField.ui2Data();
		}
	}
	
}