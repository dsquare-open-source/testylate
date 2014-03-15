package be.dsquare.util {
import flash.events.Event;

public class ModelEvent extends Event {
	public static const UPDATED:String = 'updated';
	public static const CREATED:String = 'created';

	public function ModelEvent(type, bubbles, cancelable) {
		super(type, bubbles, cancelable);
	}
}
}
