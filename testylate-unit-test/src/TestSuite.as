package {
import be.dsquare.UsingExpectManagedEvent;
import be.dsquare.UsingExpectObserver;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class TestSuite {
	public function TestSuite() {
		super();
	}

	public var usingExpectObserver:UsingExpectObserver;
	public var usingExpectManagedEvent:UsingExpectManagedEvent;
}
}
