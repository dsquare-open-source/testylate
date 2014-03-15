package be.dsquare {
import be.dsquare.util.Model;
import be.dsquare.util.ModelEvent;

public class UsingExpectObserver {
	public function UsingExpectObserver() {
		super();
	}


	[Test]
	public function observersAreDeclared():void {
		expectObserver(ModelEvent.UPDATED, ModelEvent, "onUpdated", Model);
	}
}
}
