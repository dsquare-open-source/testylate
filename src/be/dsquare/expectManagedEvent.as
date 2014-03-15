package be.dsquare {
import be.dsquare.dto.Metadata;
import be.dsquare.util.MetadataUtil;

import flash.utils.getQualifiedClassName;

import org.flexunit.asserts.fail;

public function expectManagedEvent(classs:Class, ...rest):void {
    var metadata:Array = MetadataUtil.getMetadata(classs);
    var stackTrace:String = '';

    var found:Boolean;
    for each (var eventName:String in rest) {
        found = false;
        for each (var metadataItem:Metadata in metadata) {
            if (metadataItem.name == 'ManagedEvent' && metadataItem.metadata.hasOwnProperty('name') && metadataItem.metadata['name'] == eventName) {
                found = true;
            }
        }
        if (!found) {
            stackTrace += 'Event ' + eventName + ' was not declared in ' + getQualifiedClassName(classs) + '\n';
        }
    }
    if (stackTrace != '') {
        fail(stackTrace);
    }
}
}
