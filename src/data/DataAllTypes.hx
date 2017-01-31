package data;
import data.Data;

/**
 * ...
 * @author Urs Stutz
 */
enum Choices {
	First;
	Second;
	Third;
}
 
class DataAllTypes  extends Data {
	
	public var isYesOrNo:Bool;
	public var number:Float;
	public var amount:Int;
	public var someText:String;
	public var choice:Choices;

	public function new( isYesOrNo:Bool, number:Float, amount:Int, someText:String, choice:Choices ) {
		
		super();
		
		this.isYesOrNo = isYesOrNo;
		this.number = number;
		this.amount = amount;
		this.someText = someText;
		this.choice = choice;
	}
	
	override public function copy():DataAllTypes {
		return new DataAllTypes( isYesOrNo, number, amount, someText, choice );
	}
}