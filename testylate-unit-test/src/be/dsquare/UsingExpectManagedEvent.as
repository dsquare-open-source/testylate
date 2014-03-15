package be.dsquare {
import be.dsquare.util.Model;
import be.dsquare.util.ModelEvent;

public class UsingExpectManagedEvent {
	public function UsingExpectManagedEvent() {
		super();
	}

	[Test]
	public function managedEventsAreDeclared():void {
		expectManagedEvent(Model, ModelEvent.UPDATED, ModelEvent.CREATED);
	}
}
}
