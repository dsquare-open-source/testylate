package be.dsquare {
import be.dsquare.dto.Metadata;
import be.dsquare.util.MetadataUtil;

import flash.utils.getQualifiedClassName;

import flashx.textLayout.debug.assert;

import org.flexunit.asserts.assertTrue;
import org.flexunit.asserts.fail;

/**
 * @param eventType
 * @param eventClass
 * @param methodName
 * @param classs
 */
public function expectObserver(eventType:String, eventClass:Class, methodName:String, classs:Class):void {
	var metadata:Array = MetadataUtil.getMetadata(classs, MetadataUtil.METHOD);
	for each (var metadataItem:Metadata in metadata) {
		if(metadataItem.name == methodName) {
			if(metadataItem.arguments.length != 1) {
				fail('Incorect number of argumenst for Observer "' + eventType + '" expected to be ' + getQualifiedClassName(eventClass).replace("::", ".") + ' at ' + getQualifiedClassName(classs).replace("::", ".") + '.' + methodName + '\n');
			}
			if(metadataItem.arguments[0].type != getQualifiedClassName(eventClass)) {
				fail('Argument for Observer "' + eventType + '" expected to be ' + getQualifiedClassName(eventClass).replace("::", ".") + ' at ' + getQualifiedClassName(classs).replace("::", ".") + '.' + methodName + 'but was ' + metadataItem.arguments[0].type + '\n');
			}
		}
		if(observerIsDeclared()) {
			return
		}
	}
	fail('Observer "' + eventType + '" was not declared on ' + getQualifiedClassName(classs).replace("::", ".") + '.' + methodName + '\n');
	function observerIsDeclared():Boolean {
		var observerIsDeclared:Boolean = metadataItem.name == methodName && metadataItem.metadata.hasOwnProperty('Observer') && metadataItem.metadata.Observer == eventType;
		return observerIsDeclared;
	}
}
}
