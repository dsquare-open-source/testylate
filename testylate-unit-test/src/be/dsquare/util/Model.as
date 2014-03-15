package be.dsquare.util {
[ManagedEvent(name="updated")]
[ManagedEvent(name="created")]
public class Model {
	public function Model() {
		super();
	}

	[Observer("updated")]
	public function onUpdated(event:ModelEvent):void {
	}
}
}
