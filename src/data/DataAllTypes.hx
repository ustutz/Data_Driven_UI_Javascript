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
	public var panel:Array<Dynamic>;

	public function new( id:Int, isYesOrNo:Bool, number:Float, amount:Int, someText:String, choice:Choices, panel:Array<Dynamic> ) {
		
		super( id );
		
		this.isYesOrNo = isYesOrNo;
		this.number = number;
		this.amount = amount;
		this.someText = someText;
		this.choice = choice;
		this.panel = panel;
	}
	
	override public function copy():DataAllTypes {
		return new DataAllTypes( id, isYesOrNo, number, amount, someText, choice, panel );
	}
}