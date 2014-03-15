package be.dsquare.util {
import be.dsquare.dto.Metadata;

import flash.system.ApplicationDomain;
import flash.utils.describeType;
import flash.utils.getQualifiedClassName;

/**
 * Currently getting metadata for VARIABLE is not working --> should be implemented
 * dmoskovtsov
 *
 */
public class MetadataUtil {
    public static const CLASS:String = 'class';
    private static const VARIABLE:String = 'variable';
    public static const METHOD:String = 'method';

    public static function getMetadata(classObject:*, type:String = CLASS):Array {
        var xml:XML = describeType(ApplicationDomain.currentDomain.getDefinition(getQualifiedClassName(classObject).replace("::", ".")));
        var metadata:XMLList = getMetadataList(xml, type);
        return parse(metadata);
    }

    private static function getMetadataList(xml:XML, type:String):XMLList {
        if (type == CLASS) {
            return xml.factory.metadata;
        } else if (type == VARIABLE) {
            return xml.factory.variable.metadata;
        } else if (type == METHOD) {
            return xml.factory.method.metadata;
        }
        return null;
    }

    private static function parse(metadata:XMLList):Array {
        var data:Array = [];
        var metadataLength:int = metadata.length();
        for (var i:int = 0; i < metadataLength; i++) {
            var args:XMLList = metadata[i].arg;
            var argsLength:int = args.length();
            switch (metadata[i].parent().name().toString()) {
                case "factory":
                    data.push(parseClassMetadata(metadata[i], argsLength));
                    break;
                case "variable":
                    var vo:Metadata;
                    vo = new Metadata();
                    vo.metadata = {};
                    for (var j:int = 0; j < argsLength; j++) {
                        vo.metadata[metadata[i].arg[j].@key.toString()] = metadata[i].arg[j].@value.toString();
                    }
                    vo.name = metadata[i].parent().@name.toString();
                    vo.type = metadata[i].parent().@type.toString();
                    data.push(vo);
                    break;
                case "method":
                    var vo:Metadata = parseMethodMetadata(metadata, i, argsLength)
                    if (!vo.metadata.hasOwnProperty('__go_to_definition_help') && !vo.metadata.hasOwnProperty('cppcall')) {
                        data.push(vo);
                    }
                    break;
            }
        }
        return data;
    }

    private static function parseClassMetadata(metadata:XML, argsLength:int):Metadata {
        var vo:Metadata = new Metadata();
        vo.metadata = {};
        for (var j:int = 0; j < argsLength; j++) {
            vo.metadata[metadata.arg[j].@key.toString()] = metadata.arg[j].@value.toString();
        }
        vo.name = metadata.@name.toString();
        return vo;
    }

    private static function parseMethodMetadata(metadata:XMLList, i:int, argsLength:int):Metadata {
        var vo:Metadata = new Metadata();
        vo.metadata = {};
        vo.name = metadata[i].parent().@name.toString();
        vo.returnType = metadata[i].parent().@returnType.toString();
        for (var j:int = 0; j < argsLength; j++) {
            vo.metadata[metadata[i].@name.toString()] = metadata[i].arg.@value.toString();
        }
        var paramsList:XMLList = metadata[i].parent().parameter;
        vo.arguments = parseMethodParameters(paramsList);
        return vo;
    }

    private static function parseMethodParameters(paramsList:XMLList):Array {
        var params:Array = [];
        var numOfParams:int = paramsList.length();
        for (var j:int = 0; j < numOfParams; j++) {
            params.push(
                    {
                        index: paramsList[j].@index.toString(),
                        type: paramsList[j].@type.toString(),
                        optional: paramsList[j].@optional.toString()
                    }
            );
        }
        return params;
    }
}
}