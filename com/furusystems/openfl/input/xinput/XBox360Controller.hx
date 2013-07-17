package com.furusystems.openfl.input.xinput;
import cpp.Lib;

/**
 * ...
 * @author Andreas Rønning
 */

 
class XBox360Controller
{
	private var _id:Int;
	
	private var _state:Xbox360ControllerState;
	
	private var _vibrationLeft:Int;
	private var _vibrationRight:Int;
	
	public function new(id:Int) 
	{
		_state = new Xbox360ControllerState();
		_id = id;
	}
	
	public var leftStick(get_leftStick, null):XBox360ThumbStick;
	public var rightStick(get_rightStick, null):XBox360ThumbStick;
	
	private function get_leftStick():XBox360ThumbStick {
		return _state.leftStick;
	}
	private function get_rightStick():XBox360ThumbStick {
		return _state.rightStick;
	}
	
	public inline function setVibration(leftStrength:Int, rightStrength:Int) {
		xinput_vibrate(_id, leftStrength, rightStrength);
	}
	
	public function isConnected():Bool {
		return xinput_isconnected(_id);
	}
	
	public function poll():Xbox360ControllerState {
		_state.update(xinput_poll(_id));
		return _state;
	}
	
	function get_id():Int 
	{
		return _id;
	}
	
	public var id(get_id, null):Int;
	
	function get_state():Xbox360ControllerState 
	{
		poll();
		return _state;
	}
	
	public var state(get_state, null):Xbox360ControllerState;
	
	function get_vibrationLeft():Int 
	{
		return _vibrationLeft;
	}
	
	function set_vibrationLeft(value:Int):Int 
	{
		_vibrationLeft = value;
		setVibration(_vibrationLeft, _vibrationRight);
		return _vibrationLeft;
	}
	
	public var vibrationLeft(get_vibrationLeft, set_vibrationLeft):Int;
	
	function get_vibrationRight():Int 
	{
		return _vibrationRight;
	}
	
	function set_vibrationRight(value:Int):Int 
	{
		_vibrationRight = value;
		setVibration(_vibrationLeft, _vibrationRight);
		return _vibrationRight;
	}
	
	public var vibrationRight(get_vibrationRight, set_vibrationRight):Int;
	
	static var xinput_vibrate = Lib.load("xinput", "vibrate", 3);
	static var xinput_poll = Lib.load("xinput", "poll", 1);
	static var xinput_isconnected = Lib.load("xinput", "isConnected", 1);
	
}