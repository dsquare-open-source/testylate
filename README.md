Testylate
=========

Utils for safety refactoring of metatags parameters.
Currently done for Tide Client Framework only ( http://www.granitedataservices.com/public/docs/3.0.1/docs/reference/flex/graniteds-refguide-flex.html#graniteds.tideframework ).


Documentation:

Testing of managed events:

```as3
expectManagedEvent(Model, ModelEvent.UPDATED);
```
Expects ModelEvent.UPDATED to be declared in Model class.
 ```as3
[ManagedEvent(name="created")]
public class Model {
}

```

Testing of observers:

```as3
expectObserver(ModelEvent.UPDATED, ModelEvent, "onUpdated", Model);

```
Expects ModelEvent.UPDATED event to be declared in Model under onUpdated method.

 ```as3
[Observer("updated")]
public function onUpdated(event:ModelEvent):void {
}

```