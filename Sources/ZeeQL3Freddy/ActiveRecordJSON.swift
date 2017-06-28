//
//  ActiveRecordJSON.swift
//  ZeeQL3JSON
//
//  Created by Helge Hess on 06/04/17.
//  Copyright © 2017 ZeeZide GmbH. All rights reserved.
//

import ZeeQL
import Freddy

extension ZeeQL.ActiveRecord : Freddy.JSONEncodable {
}

// TBD: We cannot make it JSONDecodable because we first need the entity,
//      right?

public extension ActiveRecordType {
  
  public func toJSON() -> JSON {
    return entity.toJSON(object: self)
  }
  
}

public extension Entity {
  
  public func toJSON(object : ZeeQL.KeyValueCodingType,
                     brief  : Bool = false)
               -> JSON
  {
    var json = [ String : JSON ]()
    
    for attr in attributes {
      let name  = attr.name
      
      if let value = object.value(forKey: name) {
        if let jsonValue = value as? JSONEncodable {
          json[name] = jsonValue.toJSON()
        }
        else {
          json[name] = .string("\(value)")
        }
      }
      else if !brief {
        json[name] = JSON.null
      }
    }
    
    return .dictionary(json)
  }
  
}

public enum JSONAttributeType {
  case array, dictionary, double, int, string, bool, null
}

public protocol JSONEncodableType {
  
  public var jsonAttributeType : JSONAttributeType { get }
  
}

extension String : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .string }
}

#if false // TODO:
extension Data    : JSONEncodableType
extension Date    : JSONEncodableType
extension Decimal : JSONEncodableType
  #endif

extension Int     : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int16   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int32   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Int64   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .int }
}
extension Float   : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .double }
}
extension Double  : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .double }
}
extension Bool    : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .bool }
}

extension URL     : JSONEncodableType {
  public var jsonAttributeType : JSONAttributeType { return .string }
}

public extension Attribute {
  
  public var jsonAttributeType : JSONAttributeType {
    // TODO: support a userInfo key to override the mapping
    
    if let v = self.valueType {
    }
    
    return .string // TBD: or make it optional?
  }
}

