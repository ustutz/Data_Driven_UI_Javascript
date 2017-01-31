package data;

/**
 * ...
 * @author Urs Stutz
 */
class DataString extends Data {
	
	public var text:String;

	public function new( text:String ) {
		
		super();
		
		this.text = text;
	}
	
	override public function copy():DataString {
		return new DataString( text );
	}
}